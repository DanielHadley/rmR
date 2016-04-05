# setwd("/Users/dphnrome/Documents/Git/rmR/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")
setwd("/home/pi/Github/rmR")

library(dplyr)
library(lubridate)
library(jsonlite)
library(tidyr)



#### Chicago ####

allData <- read.csv("./data/Chicago_rats.csv")

# Make some variables 
allData <- allData %>%
  mutate(date = as.Date(Creation.Date, format="%m/%d/%Y")) %>%
  mutate(week = week(date),
         year = year(date))


# Now make json array and save it to ratmaps
## IMPORTANT: you are not done ##
# After this you need to wrap the array in a var = blah[];
# See here http://www.d3noob.org/2014/02/generate-heatmap-with-leafletheat-and.html
yearlyMap_chi <- allData %>%
  filter(year == 2015) %>%
  filter(Latitude != "NA") %>% 
  mutate(xy = paste(Latitude, Longitude)) %>% 
  group_by(xy) %>% 
  summarise(Latitude = Latitude[1], Longitude = Longitude[1], n = n()) %>% 
  select(-xy) %>%
  as.matrix() %>% 
  toJSON()
  
write(yearlyMap_chi, "../ratmaps/geo/yearly_chicago.js")




#### NYC ####

allData <- read.csv("./data/NYC_rats.csv")

# Make some variables 
allData <- allData %>%
  mutate(dateTime = mdy_hms(Created.Date, tz='EST')) %>%
  mutate(date = as.Date(dateTime)) %>%
  mutate(week = week(date),
         year = year(date))

# Now make json array and save it to ratmaps
## IMPORTANT: you are not done ##
# After this you need to wrap the array in a var = blah[];
# See here http://www.d3noob.org/2014/02/generate-heatmap-with-leafletheat-and.html
yearlyMap_nyc <- allData %>%
  filter(year == 2015) %>%
  filter(Latitude != "NA") %>% 
  mutate(xy = paste(Latitude, Longitude)) %>% 
  group_by(xy) %>% 
  summarise(Latitude = Latitude[1], Longitude = Longitude[1], n = n()) %>% 
  select(-xy) %>%
  as.matrix() %>% 
  toJSON()

write(yearlyMap_nyc, "../ratmaps/geo/yearly_nyc.js")




#### Boston ####

allData <- read.csv("./data/Boston_rats.csv")

# Make some variables 
allData <- allData %>%
  mutate(dateTime = mdy_hms(OPEN_DT, tz='EST')) %>%
  mutate(date = as.Date(dateTime)) %>%
  mutate(week = week(date),
         year = year(date))

# Now make json array and save it to ratmaps
## IMPORTANT: you are not done ##
# After this you need to wrap the array in a var = blah[];
# See here http://www.d3noob.org/2014/02/generate-heatmap-with-leafletheat-and.html
yearlyMap_boston <- allData %>%
  filter(year == 2015) %>%
  filter(LATITUDE != "NA") %>% 
  mutate(xy = paste(LATITUDE, LONGITUDE)) %>% 
  group_by(xy) %>% 
  summarise(Latitude = LATITUDE[1], Longitude = LONGITUDE[1], n = n()) %>% 
  select(-xy) %>%
  as.matrix() %>% 
  toJSON()

write(yearlyMap_boston, "../ratmaps/geo/yearly_boston.js")




#### SF ####

allData <- read.csv("./data/SanFrancisco_rats.csv")

# Make some variables 
allData <- allData %>%
  mutate(dateTime = mdy_hms(Opened, tz='EST')) %>%
  mutate(date = as.Date(dateTime)) %>%
  mutate(week = week(date),
         year = year(date))

# Now make json array and save it to ratmaps
## IMPORTANT: you are not done ##
# After this you need to wrap the array in a var = blah[];
# See here http://www.d3noob.org/2014/02/generate-heatmap-with-leafletheat-and.html
yearlyMap_sf <- allData %>%
  # filter(year == 2015) %>%
  separate(Point, c("y", "x"), ",") %>%
  mutate(y = gsub("\\(", "", y), x = gsub("\\)", "", x)) %>%
  mutate(Longitude = as.numeric(x), Latitude = as.numeric(y)) %>% 
  filter(Latitude != "NA") %>% 
  mutate(xy = paste(Latitude, Longitude)) %>% 
  group_by(xy) %>% 
  summarise(Latitude = Latitude[1], Longitude = Longitude[1], n = n()) %>% 
  select(-xy) %>%
  as.matrix() %>% 
  toJSON()

write(yearlyMap_sf, "../ratmaps/geo/yearly_sf.js")