setwd("/Users/dphnrome/Documents/Git/rmR/oneOffScripts/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")

library(lubridate)
library(tidyr)
library(dplyr)
library(broom) # augments d with model variables
library(ggplot2)
library(ggmap)

c <- read.csv("../data/NYC_rats.csv")

# Mainly fixing dates
d <- c %>%
  tbl_df()  %>% # Convert to tbl class - easier to examine than dfs
  mutate(dateTime = mdy_hms(Created.Date, tz='EST')) %>%
  arrange(dateTime) %>%
  mutate(date = as.Date(dateTime),
         hour = hour(dateTime)) %>%
  mutate(monthDay = day(date),
         weekDay = wday(date),
         month = month(date),
         year = year(date)) %>%
  select(Unique.Key:Park.Borough, Latitude:year) # drop useless columns




### This will give me a timeseries of every day
days <- d %>%
  group_by(date) %>%
  summarise(Events = n())

allDays <- seq.Date(from=d$date[1], to = d$date[nrow(d)], b='days')
allDays <- allDays  %>%  as.data.frame() 
colnames(allDays)[1] = "date"

# After this we will have a df with every date and how many BnEs
ts = merge(days, allDays, by='date', all=TRUE)
ts[is.na(ts)] <- 0

remove(allDays, days)
ts$id <- seq(1, nrow(ts))


#### Dot maps #### 
map.center <- geocode("New York City, NY")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 11, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = .5, alpha = .2, bins = 26, color="red",) 

ggsave(paste("../plots/NYC_Rat_Map_all.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Brooklyn, NY")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .3, bins = 26, color="red",) 

ggsave(paste("../plots/NYC_Rat_Map_Brooklyn.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Queens, NY")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .3, bins = 26, color="red",) 

ggsave(paste("../plots/NYC_Rat_Map_Queens.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Bronx, NY")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .3, bins = 26, color="red",) 

ggsave(paste("../plots/NYC_Rat_Map_Bronx.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Staten Island, NY")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .3, bins = 26, color="red",) 

ggsave(paste("../plots/NYC_Rat_Map_Staten_Island.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Uptown Manhattan, NY")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .3, bins = 26, color="red",) 

ggsave(paste("../plots/NYC_Rat_Map_Uptown_Manhattan.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Downtown Manhattan, NY")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .3, bins = 26, color="red",) 

ggsave(paste("../plots/NYC_Rat_Map_Downtown_Manhattan.png",sep=""), dpi=200, width=4, height=4)
