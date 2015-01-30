setwd("/Users/dphnrome/Documents/Git/rmR/")
setwd("C:/Users/dhadley/Documents/GitHub/rmR")

library(ggmap)

today <- Sys.Date()
lastWeek <- today - 7

todayText <- format(today, "%b %d")
lastWeekText <- format(lastWeek, "%b %d")
Year <- format(today, "%Y")

## Plain Text:
# https://data.cityofnewyork.us/resource/erm2-nwe9.json?$where=descriptor='Rat Sighting'AND created_date > '2015-01-20'
## As URL (read.csv) can't do https, just http
#https://data.cityofnewyork.us/resource/erm2-nwe9.csv?$where=descriptor=%27Rat%20Sighting%27AND%20created_date%20%3E%20%272015-01-20%27

api <- paste("http://data.cityofchicago.org/resource/97t6-zrhs.csv?$where=creation_date%20%3E%20%27", lastWeek, "%27", sep="")

chi <- read.csv(url(api))
d <- chi

# Dot map 
map.center <- geocode("Chicago, IL")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 11, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 2, alpha = .7, bins = 26, color="red",) + 
  ggtitle(paste("Rat Calls: ", lastWeekText, " to ", todayText, ", ", Year, sep=""))

ggsave(paste("../ratmaps/images/posts/CHIMap",today,".png",sep=""), dpi=200, width=4, height=4)