setwd("/Users/dphnrome/Documents/Git/rmR/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")

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

api <- paste("http://data.cityofnewyork.us/resource/erm2-nwe9.csv?$where=descriptor=%27Rat%20Sighting%27AND%20created_date%20%3E%20%27", lastWeek, "%27", sep="")

nyc <- read.csv(url(api))
d <- nyc

# Dot map 
map.center <- geocode("New York City, NY")
SHmap <- qmap(c(lon=map.center$lon, lat=map.center$lat), source="google", zoom = 11, color='bw')
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 2, alpha = .7, bins = 26, color="red",) + 
  ggtitle(paste("Rat Calls: ", lastWeekText, " to ", todayText, ", ", Year, sep="")) 

ggsave(paste("/Users/dphnrome/Google Drive/RatMaps/posts/NYC_Rat_Map_",today,".png",sep=""), dpi=200, width=4, height=4)



# Start writing to an output file
sink(paste("/Users/dphnrome/Documents/Git/ratmaps/_posts/test-", today,".md",sep=""))

cat("---\n")
cat("layout: post\n")
cat("title: NYC Weekly", today, "\n") 
cat("tags: NYC weekly\n")
cat("---\n")




cat("![_config.yml](http://googledrive.com/host/0BxOPuM_gK7bqUW85bjZUd1UwTGs/posts/NYC_Rat_Map_",today,".png\n")

# Stop writing to the file
sink()

