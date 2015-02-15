setwd("/Users/dphnrome/Documents/Git/rmR/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")

library(ggmap)
library(dplyr)
library(lubridate)

today <- Sys.Date()
lastWeek <- today - 7
tenDaysAgo <- today - 10

todayText <- format(today, "%B %d")
lastWeekText <- format(lastWeek, "%B %d")
thisYear <- format(today, "%Y")
todayUSA <- format(today, '%m-%d-%Y')
thisWeekNumber <- week(today)


api <- paste("http://data.cityofchicago.org/resource/97t6-zrhs.csv?$where=creation_date%20%3E%20%27", tenDaysAgo, "%27", sep="")

chi <- read.csv(url(api))

# Bring in all data, combine it, and save new CSV
# I do this to update data and to provide a comparison
allData <- read.csv("./data/Chicago_rats.csv")
allData <- rbind(allData, chi)
allData <- allData[!duplicated(allData$Service.Request.Number), ] #remove duplicates
write.csv(allData, "./data/Chicago_rats.csv", row.names=FALSE)


# Winnow down to the last week
d <- allData %>%
  mutate(date = as.Date(Creation.Date, format="%m/%d/%Y")) %>%
  mutate(week = week(date),
         year = year(date)) %>%
  filter(date >= lastWeek) # last week

# Make the same variables for all data, but keep all
# we will compare these later
allData <- allData %>%
  mutate(date = as.Date(allData$Creation.Date, format="%m/%d/%Y")) %>%
  mutate(week = week(date),
         year = year(date))


# Dot map 
map.center <- geocode("Chicago, IL")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 11, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 2, alpha = .7, bins = 26, color="red",) 

ggsave(paste("/Users/dphnrome/Google Drive/RatMaps/posts/Chicago_Rat_Map_",today,".png",sep=""), dpi=200, width=4, height=4)


### Now for comparisons to add to the text below

# total calls
totalCalls <- nrow(d)

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

averageForThisTime <- round(mean(averageForThisTime$Events))


#### Start writing to an output file ####
# This makes the .md blog posts
sink(paste("/Users/dphnrome/Documents/Git/ratmaps/_posts/", today,"-Chicago-Rats.md",sep=""))

cat("---\n")
cat("layout: post\n")
cat(sprintf('title: Chicago Weekly %s\n', todayUSA))
cat("tags: Chicago weekly\n")
cat("---\n")

cat("\n")

cat(sprintf("Between %s and %s, there were %s calls to Chicago's 311 line about rats. The average number of weekly calls for this time of year is %s.\n", lastWeekText, todayText, totalCalls, averageForThisTime)) 

cat(sprintf("![_config.yml](http://googledrive.com/host/0BxOPuM_gK7bqUW85bjZUd1UwTGs/posts/Chicago_Rat_Map_%s.png)\n", today))

cat("\n")
cat("Each red dot represents one call about a rat seen in that location. The dots are transparent, so multiple calls from one location will be seen as a solid dot. The usual caveats apply: more calls do not necessarily mean that there are more rats in that location than other parts of the city. A cluster of dots could indicate that one resident is unusually vocal about rodents in his or her neighborhood. Also, more densely populated neighborhoods tend to make more calls to 311.")

# Stop writing to the file
sink()