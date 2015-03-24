setwd("/Users/dphnrome/Documents/Git/rmR/oneOffScripts/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")
# setwd("/home/pi/Github/rmR")

library(dplyr)
library(tidyr)
library(lubridate)
library(broom) # augments d with model variables
library(ggplot2)
library(ggmap)

set.seed(311)

# I can probably do each city by the delimited neighborhoods instead of k-means
# Except for Baltimore


#### Chicago ####

chi <- read.csv("./data/Chicago_rats.csv")

# Get dates ready
d <- chi %>%
  mutate(date = as.Date(Creation.Date, format="%m/%d/%Y")) %>%
  mutate(week = week(date),
         year = year(date),
         YearDay = yday(date))

# Trailing 365 - a better comparison than YTD when it's early in the year
lastDate <- max(d$date)
YearAgo <- lastDate - 365
TwoYearsAgo <- YearAgo - 365
ThreeYearsAgo <- TwoYearsAgo - 365
FourYearsAgo <- ThreeYearsAgo - 365

d$period <- 
  ifelse((d$date >= YearAgo), "TrailingYear",
                   ifelse((d$date >= TwoYearsAgo) & (d$date < YearAgo), "PrevPer1",
                          ifelse((d$date >= ThreeYearsAgo) & (d$date < TwoYearsAgo), "PrevPer2",
                                 ifelse((d$date >= FourYearsAgo) & (d$date < ThreeYearsAgo), "PrevPer3",
                                        "LongAgo"))))                                 



## Use maps to inspect the neighborhoods ##

# Dot map 
map.center <- geocode("Chicago, Il")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 12, color='bw')
SHmap + geom_point(data=d, aes(x=Longitude, y=Latitude, color=as.character(d$Community.Area)))


## See which one grew the most

hotHoods <- d %>%
  group_by(period, Community.Area) %>%
  summarise(calls = n()) %>%
  filter(Community.Area != "NA") %>%
  spread(period, calls)

hotHoods$Avg <- rowMeans(hotHoods[,c("PrevPer1", "PrevPer2", "PrevPer3")], na.rm=TRUE)
hotHoods$PerChng <- ((hotHoods$TrailingYear - hotHoods$Avg)) / hotHoods$Avg

# Before selecting the top & bottom hoods, I drop the bottom quartile of avg total calls
# The outliers often have the most variance, and are less interesting

hotHoods <- hotHoods %>%
  mutate(quartile = ntile(Avg, 4)) %>%
  filter(quartile > 1)

topNeighborhood <- subset(hotHoods, PerChng == max(PerChng))
bottomNeighborhood <- subset(hotHoods, PerChng == min(PerChng))

# Make a map for the blog post

topNeighborhoodData <- d %>%
  filter(Community.Area == topNeighborhood$Community.Area)

bottomNeighborhoodData <- d %>%
  filter(Community.Area == bottomNeighborhood$Community.Area)

# Geocode and then map
lon <- c(mean(topNeighborhoodData$Longitude))
lat <- c(mean(topNeighborhoodData$Latitude))
map.center <- data.frame(lon, lat)
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 14, color='bw')
SHmap + geom_point(data=topNeighborhoodData, aes(y=Latitude, x=Longitude), size = 2, alpha = .3, bins = 26, color="red",) 

ggsave("../plots/Chicago_Rat_Map_Top_Neighborhood_2015.png", dpi=200, width=4, height=4)



