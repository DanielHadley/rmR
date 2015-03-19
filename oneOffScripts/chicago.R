setwd("/Users/dphnrome/Documents/Git/rmR/oneOffScripts/")
setwd("C:/Users/dhadley/Documents/GitHub/rmR/oneOffScripts/")

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







#### Neighborhoods ####

chicagoNeighborhoods <- read.csv("./chicagoNeighborhoods.csv")
chicagoNeighborhoods$full <- gsub(" ", "_", chicagoNeighborhoods$b)
chicagoNeighborhoods$quotes <- paste("\"",chicagoNeighborhoods$full,"\"",sep="")

# ### Automatic Maps ####
# uncomment to use #
# 
# for(i in 1 : 76){
#   map.center <- geocode(paste(chicagoNeighborhoods[i,2], ", Chicago, Il"))
#   SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 15, color='bw')
#   SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 1.5, alpha = .3, bins = 26, color="red",)
#   
#   ggsave(paste("../plots/Chicago_Rat_Map_", chicagoNeighborhoods[i,3],".png",sep=""), dpi=200, width=3, height=3)
# }


#### Start writing to an output file ####
# This makes the .md page with neighborhoods
sink("../../ratmaps/chicago-neighborhoods.md")

cat("---\n")
cat("layout: page\n")
cat('title: Chicago Neighborhoods\n')
cat("permalink: /chicago/neighborhoods/\n")
cat("---\n")

cat("\n")

for(i in 1 : 76){
  cat(sprintf("+ [%s](#%s)\n", chicagoNeighborhoods[i,2], chicagoNeighborhoods[i,3]))
}

cat("\n")

for(i in 1 : 76){
  cat(sprintf("### %s <a id=%s></a>\n", chicagoNeighborhoods[i,2], chicagoNeighborhoods[i,4]))
  cat(sprintf("![chicago rat calls to 311 map %s]({{ site.cityimages }}/neighborhoods/Chicago_Rat_Map_%s.png)\n", chicagoNeighborhoods[i,2], chicagoNeighborhoods[i,3]))
}


# Stop writing to the file
sink()














#### K-means ####
# This is how we group crimes on a map.
# It may be more convenient to use reporting areas, but often those bisect a cluster

# NAs throw off clustering
# http://stackoverflow.com/questions/11254524/omit-rows-containing-specific-column-of-na
completeFun <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}

d <-  completeFun(d, "Latitude")

clust <- d %>%
  ungroup %>% dplyr::select(Latitude, Longitude) %>% kmeans(15)


# Add cluster variable back to the data frame 
c <- augment(clust, d) %>% select(.cluster)
c$order <- d$order

d <- merge(d, c, by='order')

d <- d  %>% tbl_df() %>% mutate(cluster = .cluster) #the ."var name" throws off some functions

remove(c)


