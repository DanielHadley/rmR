setwd("/Users/dphnrome/Documents/Git/rmR/oneOffScripts/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")

library(lubridate)
library(tidyr)
library(dplyr)
library(broom) # augments d with model variables
library(ggplot2)
library(ggmap)

d <- read.csv("../data/Chicago_rats.csv")


#### Dot maps #### 
map.center <- geocode("Chicago, Il")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 11, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = .5, alpha = .1, bins = 26, color="red",) 

ggsave(paste("../plots/Chicago_Rat_Map_all.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("North Park, Chicago, Il") #Far North
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .1, bins = 26, color="red",) 

ggsave(paste("../plots/Chicago_Rat_Map_Far_North.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Belmont Cragin, Chicago, Il") #Northwest Side
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .1, bins = 26, color="red",) 

ggsave(paste("../plots/Chicago_Rat_Map_Northwest.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Lake View, Chicago, Il") #North Side
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .1, bins = 26, color="red",) 

ggsave(paste("../plots/Chicago_Rat_Map_North.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("East Garfield Park, Chicago, Il")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .1, bins = 26, color="red",) 

ggsave(paste("../plots/Chicago_Rat_Map_West.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Near East Loop, Chicago, Il")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .1, bins = 26, color="red",) 

ggsave(paste("../plots/Chicago_Rat_Map_Central.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Near East Loop, Chicago, Il")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .1, bins = 26, color="red",) 

ggsave(paste("../plots/Chicago_Rat_Map_Central.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Hyde Park, Chicago, Il")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .1, bins = 26, color="red",) 

ggsave(paste("../plots/Chicago_Rat_Map_South.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Gage Park, Chicago, Il")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .1, bins = 26, color="red",) 

ggsave(paste("../plots/Chicago_Rat_Map_Southwest.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Beverly, Chicago, Il")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .1, bins = 26, color="red",) 

ggsave(paste("../plots/Chicago_Rat_Map_Far_Southwest.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("South Deering, Chicago, Il")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 13, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1, alpha = .1, bins = 26, color="red",) 

ggsave(paste("../plots/Chicago_Rat_Map_Far_Southeast.png",sep=""), dpi=200, width=4, height=4)


