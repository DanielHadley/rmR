setwd("/Users/dphnrome/Documents/Git/rmR/oneOffScripts/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")

library(ggplot2)
library(ggmap)

d <- read.csv("../data/Boston_rats.csv")


#### Dot maps #### 
map.center <- geocode("South End, Boston, MA")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 12, color='bw')
SHmap + geom_point(data=d, aes(y=LATITUDE, x=LONGITUDE), size = 1, alpha = .2, bins = 26, color="red",) 

ggsave(paste("../plots/Boston_Rat_Map_all.png",sep=""), dpi=200, width=4, height=4)



map.center <- geocode("Downtown, Boston, MA")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 14, color='bw')
SHmap + geom_point(data=d, aes(y=LATITUDE, x=LONGITUDE), size = 1.5, alpha = .3, bins = 26, color="red",) 

ggsave(paste("../plots/Boston_Rat_Map_Downtown.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Allston, Boston, MA")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 14, color='bw')
SHmap + geom_point(data=d, aes(y=LATITUDE, x=LONGITUDE), size = 1.5, alpha = .3, bins = 26, color="red",) 

ggsave(paste("../plots/Boston_Rat_Map_Allston.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Back Bay, Boston, MA")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 14, color='bw')
SHmap + geom_point(data=d, aes(y=LATITUDE, x=LONGITUDE), size = 1.5, alpha = .3, bins = 26, color="red",) 

ggsave(paste("../plots/Boston_Rat_Map_Back_Bay.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Uphamn's Corner, Boston, MA")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 14, color='bw')
SHmap + geom_point(data=d, aes(y=LATITUDE, x=LONGITUDE), size = 1.5, alpha = .3, bins = 26, color="red",) 

ggsave(paste("../plots/Boston_Rat_Map_Uphams_Corner.png",sep=""), dpi=200, width=4, height=4)


map.center <- geocode("Saratoga Street, Boston, MA")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 14, color='bw')
SHmap + geom_point(data=d, aes(y=LATITUDE, x=LONGITUDE), size = 1.5, alpha = .3, bins = 26, color="red",) 

ggsave(paste("../plots/Boston_Rat_Map_Eastie.png",sep=""), dpi=200, width=4, height=4)







