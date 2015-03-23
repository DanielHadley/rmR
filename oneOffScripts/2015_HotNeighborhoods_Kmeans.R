# setwd("/Users/dphnrome/Documents/Git/rmR/")
setwd("C:/Users/dhadley/Documents/GitHub/rmR")
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


## K-means ##
# This is how we group sightings on a map.

# NAs throw off clustering
# http://stackoverflow.com/questions/11254524/omit-rows-containing-specific-column-of-na
completeFun <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}

d <-  completeFun(d, "Latitude")


# Now ready
clust <- d %>%
  ungroup %>% dplyr::select(Latitude, Longitude) %>% kmeans(50)


# Add cluster variable back to the data frame 
c <- augment(clust, d) %>% select(.cluster)
d <- merge(d, c, by='row.names')

d <- d  %>% tbl_df() %>% mutate(cluster = .cluster) #the ."var name" throws off some functions
remove(c)


## Use maps to inspect the clusters ##

# Dot map 
map.center <- geocode("Chicago, Il")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 12, color='bw')
SHmap + geom_point(data=d, aes(x=Longitude, y=Latitude, color=d$cluster))



## Once you are happy with the clusters, see which one grew the most

hotHoods <- d %>%
  group_by(period, cluster) %>%
  summarise(calls = n()) %>%
  spread(period, calls)

hotHoods$Avg <- rowMeans(hotHoods[,c("PrevPer1", "PrevPer2", "PrevPer3")], na.rm=TRUE)
hotHoods$PerChng <- ((hotHoods$TrailingYear - hotHoods$Avg)) / hotHoods$Avg


topCluster <- subset(hotHoods, PerChng == max(PerChng))
topCluster <- topCluster$cluster
  
# Reverse geocode
hottestHood <- as.numeric(clust$centers[topCluster,])
hottestHood <- rev(hottestHood)
res <- revgeocode(hottestHood, output="more")

hottestHoodData <- d %>%
  filter(cluster == topCluster)


# Dot map of hottest hood 
map.center <- geocode(as.character(res$address))
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 14, color='bw')
SHmap + geom_point(data=hottestHoodData, aes(x=Longitude, y=Latitude, color="red"))


## Coldest - e.g. largest decrease
bottomCluster <- subset(hotHoods, PerChng == min(PerChng))
bottomCluster <- bottomCluster$cluster

# Reverse geocode
coldestHood <- as.numeric(clust$centers[bottomCluster,])
coldestHood <- rev(coldestHood)
res <- revgeocode(coldestHood, output="more")

coldestHoodData <- d %>%
  filter(cluster == bottomCluster)


# Dot map of coldest hood 
map.center <- geocode(as.character(res$address))
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 14, color='bw')
SHmap + geom_point(data=coldestHoodData, aes(x=Longitude, y=Latitude, color="red"))



#### Boston ####

bos <- read.csv("./data/Boston_rats.csv")

# Get dates ready & make data look like Chicago's
d <- bos %>%
  mutate(date = as.Date(OPEN_DT, format="%m/%d/%Y")) %>%
  mutate(week = week(date),
         year = year(date),
         YearDay = yday(date),
         Latitude = LATITUDE,
         Longitude = LONGITUDE)

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


## K-means ##
# This is how we group sightings on a map.

# NAs throw off clustering
# http://stackoverflow.com/questions/11254524/omit-rows-containing-specific-column-of-na
completeFun <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}

d <-  completeFun(d, "Latitude")


# Now ready
clust <- d %>%
  ungroup %>% dplyr::select(Latitude, Longitude) %>% kmeans(12)


# Add cluster variable back to the data frame 
c <- augment(clust, d) %>% select(.cluster)
d <- merge(d, c, by='row.names')

d <- d  %>% tbl_df() %>% mutate(cluster = .cluster) #the ."var name" throws off some functions
remove(c)


## Use maps to inspect the clusters ##

# Dot map 
map.center <- geocode("Boston, MA")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 12, color='bw')
SHmap + geom_point(data=d, aes(x=Longitude, y=Latitude, color=d$cluster))



## Once you are happy with the clusters, see which one grew the most

hotHoods <- d %>%
  group_by(period, cluster) %>%
  summarise(calls = n()) %>%
  spread(period, calls)

hotHoods$Avg <- rowMeans(hotHoods[,c("PrevPer1", "PrevPer2", "PrevPer3")], na.rm=TRUE)
hotHoods$PerChng <- ((hotHoods$TrailingYear - hotHoods$Avg)) / hotHoods$Avg


topCluster <- subset(hotHoods, PerChng == max(PerChng))
topCluster <- topCluster$cluster

# Reverse geocode
hottestHood <- as.numeric(clust$centers[topCluster,])
hottestHood <- rev(hottestHood)
res <- revgeocode(hottestHood, output="more")

hottestHoodData <- d %>%
  filter(cluster == topCluster)


# Dot map of hottest hood 
map.center <- geocode(as.character(res$address))
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 14, color='bw')
SHmap + geom_point(data=hottestHoodData, aes(x=Longitude, y=Latitude, color="red"))


## Coldest - e.g. largest decrease
bottomCluster <- subset(hotHoods, PerChng == min(PerChng))
bottomCluster <- bottomCluster$cluster

# Reverse geocode
coldestHood <- as.numeric(clust$centers[bottomCluster,])
coldestHood <- rev(coldestHood)
res <- revgeocode(coldestHood, output="more")

coldestHoodData <- d %>%
  filter(cluster == bottomCluster)


# Dot map of coldest hood 
map.center <- geocode(as.character(res$address))
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 14, color='bw')
SHmap + geom_point(data=coldestHoodData, aes(x=Longitude, y=Latitude, color="red"))

