setwd("/Users/dphnrome/Documents/Git/rmR/oneOffScripts/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")

library(lubridate)
library(tidyr)
library(dplyr)
library(broom) # augments d with model variables
library(ggplot2)
library(ggmap)

d <- read.csv("../data/SanFrancisco_rats.csv")


# Prepare to create x, y
d$Loc <- gsub("\\(", "", d$Point)
d$Loc <- gsub("\\)", "", d$Loc)

d <- d %>%
  tbl_df()  %>% # Convert to tbl class - easier to examine than dfs
  separate(Loc, c("y", "x"), ",") %>%
  mutate(Longitude = as.numeric(x), Latitude = as.numeric(y),
         order = seq(1, nrow(d)))


#### Dot maps #### 
map.center <- geocode("San Francisco")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 2, alpha = .5, bins = 26, color="red",) 

ggsave(paste("../plots/San_Francisco_Rat_Map_all.png",sep=""), dpi=200, width=4, height=4)


#### Dot maps #### 
map.center <- geocode("San Francisco")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 2, alpha = .5, bins = 26, color="red",) 

ggsave(paste("../plots/San_Francisco_Rat_Map_all.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Tenderloin, San Francisco")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 15, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 3, alpha = .5, bins = 26, color="red",) 

ggsave(paste("../plots/San_Francisco_Rat_Map_Tenderloin.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Mission District, San Francisco")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 15, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 3, alpha = .5, bins = 26, color="red",) 

ggsave(paste("../plots/San_Francisco_Rat_Map_Mission.png",sep=""), dpi=200, width=4, height=4)

map.center <- geocode("Chinatown, San Francisco")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 15, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 3, alpha = .5, bins = 26, color="red",) 

ggsave(paste("../plots/San_Francisco_Rat_Map_Chinatown.png",sep=""), dpi=200, width=4, height=4)


