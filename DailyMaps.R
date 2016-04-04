# setwd("/Users/dphnrome/Documents/Git/rmR/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")
setwd("/home/pi/Github/rmR")

library(dplyr)
library(lubridate)
library(leafletR)

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


## Last week 
d <- allData %>%
  filter(date >= lastWeek)

# Num calls
chiLastWeek <- nrow(d)


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


# Now make geojson and save it to ratmaps
dailyMap_chi <- d %>% 
  select(Latitude, Longitude) %>% 
  rename(latitude = Latitude, longitude = Longitude)

# Convert and upload to our server
toGeoJSON(dailyMap_chi, "daily_chicago", "../ratmaps/geo/")




#### NYC ####

allData <- read.csv("./data/NYC_rats.csv")

# Make some variables 
allData <- allData %>%
  mutate(dateTime = mdy_hms(Created.Date, tz='EST')) %>%
  mutate(date = as.Date(dateTime)) %>%
  mutate(week = week(date),
         year = year(date))

## Yesterday 
d <- allData %>%
  filter(date == yesterday)

# Num calls
nycYesterday <- nrow(d)


## Last week 
d <- allData %>%
  filter(date >= lastWeek)

# Num calls
nycLastWeek <- nrow(d)


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

nycAverageForThisTime <- round(mean(averageForThisTime$Events))


# Now make geojson and save it to ratmaps
dailyMap_nyc <- d %>% 
  select(Latitude, Longitude) %>% 
  rename(latitude = Latitude, longitude = Longitude)

# Convert and upload to our server
toGeoJSON(dailyMap_nyc, "daily_nyc", "../ratmaps/geo/")


