# setwd("/Users/dphnrome/Documents/Git/rmR/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")
setwd("/home/pi/Github/rmR")

library(ggmap)
library(dplyr)
library(lubridate)
library(Cairo)

today <- Sys.Date()
yesterday <- today - 1
lastWeek <- today - 7
tenDaysAgo <- today - 10

todayText <- format(today, "%B %d")
yesterdayText <- format(yesterday, "%B %d")
lastWeekText <- format(lastWeek, "%B %d")
thisYear <- format(today, "%Y")
todayUSA <- format(today, '%m-%d-%Y')
thisWeekNumber <- week(today)


#### Chicago ####

allData <- read.csv("./data/Chicago_rats.csv")

# Make some variables 
allData <- allData %>%
  mutate(date = as.Date(Creation.Date, format="%m/%d/%Y")) %>%
  mutate(week = week(date),
         year = year(date))

## Yesterday 
d <- allData %>%
  filter(date == yesterday)

# Num calls
chiYesterday <- nrow(d)

# Dot map
# Saved using Cairo because otherwise transparency doesn't work
# set up the map
map.center <- geocode("Chicago, IL")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 11, color='bw')

# Now save it using Cairo
Cairo(file="/home/pi/Github/ratmaps/images/pages/daily/Chicago_Rat_Map_Daily.png", 
      units="in", 
      width=4, 
      height=4, 
      pointsize=12, 
      res=200) 
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 2, alpha = .5, bins = 26, color="red",) 
dev.off()


## Last week 
d <- allData %>%
  filter(date >= lastWeek)

# Num calls
chiLastWeek <- nrow(d)

# Dot map
# Saved using Cairo because otherwise transparency doesn't work
# set up the map
map.center <- geocode("Chicago, IL")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 11, color='bw')

# Now save it using Cairo
Cairo(file="/home/pi/Github/ratmaps/images/pages/daily/Chicago_Rat_Map_Weekly.png", 
      units="in", 
      width=4, 
      height=4, 
      pointsize=12, 
      res=200) 
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 2, alpha = .5, bins = 26, color="red",) 
dev.off()


# older than 2009 is bad comparison
# and get rid of this year,
pastYears <- allData %>%
  filter(year > 2009 & year < thisYear) 

# comparison average
averageForThisTime <- pastYears %>%
  group_by(year, week) %>%
  summarise(Events = n()) %>%
  filter(week == thisWeekNumber-2 |
           week == thisWeekNumber-1 |
           week == thisWeekNumber |
           week == thisWeekNumber+1 |
           week == thisWeekNumber+2)

chiAverageForThisTime <- round(mean(averageForThisTime$Events))




#### Start writing to an output file ####
# This makes the .md page
sink("../ratmaps/daily.md") #"/home/pi/Github

cat("---\n")
cat("layout: page\n")
cat('title: Daily Rat Calls\n')
cat("tags: Chicago NYC weekly daily rats\n")
cat("---\n")

cat("\n")

cat("+[Chicago](#chicago)\n")
cat("\n")
cat("+[New York City](#nyc)\n")
cat("+[Boston](#boston)\n")
cat("\n")
cat("****\n")
cat("\n")

cat("#Chicago <a id=\"chicago\"><a>\n")
cat("### Daily\n")
cat(sprintf("Yesterday (%s), there were %s calls to Chicago's 311 line about rats.\n", yesterdayText, chiYesterday))

cat("![Chicago rat calls to 311 weekly map]({{ site.cityimages }}/daily/Chicago_Rat_Map_Daily.png)\n")

cat("\n")

cat("### Weekly\n")
cat(sprintf("Between %s and %s, there were %s calls to Chicago's 311 line about rats. The average number of weekly calls for this time of year is %s.\n", lastWeekText, yesterdayText, chiLastWeek, chiAverageForThisTime)) 

cat("![Chicago rat calls to 311 weekly map]({{ site.cityimages }}/daily/Chicago_Rat_Map_Weekly.png)\n")

cat("\n")
cat("Each red dot represents one call about a rat seen in that location. The dots are transparent, so multiple calls from one location will be seen as a solid dot. The usual caveats apply: more calls do not necessarily mean that there are more rats in that location than other parts of the city. A cluster of dots could indicate that one resident is unusually vocal about rodents in his or her neighborhood. Also, more densely populated neighborhoods tend to make more calls to 311.")

# Stop writing to the file
sink()


