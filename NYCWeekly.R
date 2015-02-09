setwd("/Users/dphnrome/Documents/Git/rmR/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")

library(ggmap)

today <- Sys.Date()
lastWeek <- today - 7

todayText <- format(today, "%B %d")
lastWeekText <- format(lastWeek, "%B %d")
Year <- format(today, "%Y")
todayUSA <- format(today, '%m-%d-%Y')

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
SHmap + geom_point(data=d, aes(y=Latitude, x=Longitude), size = 2, alpha = .7, bins = 26, color="red",) 

ggsave(paste("/Users/dphnrome/Google Drive/RatMaps/posts/NYC_Rat_Map_",today,".png",sep=""), dpi=200, width=4, height=4)


# total calls
totalCalls <- nrow(d)

#### Start writing to an output file ####
# This makes the .md blog posts
sink(paste("/Users/dphnrome/Documents/Git/ratmaps/_posts/", today,"-NYC-Rats.md",sep=""))

cat("---\n")
cat("layout: post\n")
cat(sprintf('title: NYC Weekly %s\n', todayUSA))
cat("tags: NYC weekly\n")
cat("---\n")

cat("\n")

cat(sprintf("Between %s and %s, there were %s calls to New York City's 311 line about rats.\n", lastWeekText, todayText, totalCalls)) 

cat(sprintf("![_config.yml](http://googledrive.com/host/0BxOPuM_gK7bqUW85bjZUd1UwTGs/posts/NYC_Rat_Map_%s.png)\n", today))

cat("\n")
cat("Each red dot represents one call about a rat seen in that location. The dots are transparent, so multiple calls from one location will be seen as a solid dot. The usual caveats apply: more calls do not necessarily mean that there are more rats in that location than other parts of the city. A cluster of dots could indicate that one resident is unusually vocal about rodents in his or her neighborhood. Also, more densely populated neighborhoods tend to make more calls to 311.")

# Stop writing to the file
sink()

