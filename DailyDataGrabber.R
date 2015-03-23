# Downloads last week of data each night. I go back 7 days in case there is a malfunction:
# it can pick up more easily where it left off

# setwd("/Users/dphnrome/Documents/Git/rmR/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")
setwd("/home/pi/Github/rmR")

today <- Sys.Date()
lastWeek <- today - 7


#### Chicago ####

api <- paste("http://data.cityofchicago.org/resource/97t6-zrhs.csv?$where=creation_date%20%3E%20%27", lastWeek, "%27", sep="")

chi <- read.csv(url(api))

# Bring in all data, combine it, and save new CSV
# I do this to update data and to provide a comparison
allData <- read.csv("./data/Chicago_rats.csv")
allData <- rbind(allData, chi)
allData <- allData[!duplicated(allData$Service.Request.Number), ] #remove duplicates
write.csv(allData, "./data/Chicago_rats.csv", row.names=FALSE)


#### NYC #### 

api <- paste("http://data.cityofnewyork.us/resource/erm2-nwe9.csv?$where=descriptor=%27Rat%20Sighting%27AND%20created_date%20%3E%20%27", lastWeek, "%27", sep="")

nyc <- read.csv(url(api))

# Bring in all data, combine it, and save new CSV
# I do this to update data and to provide a comparison
allData <- read.csv("./data/NYC_rats.csv")
allData <- rbind(allData, nyc)
allData <- allData[!duplicated(allData$Unique.Key), ] #remove duplicates
write.csv(allData, "./data/NYC_rats.csv", row.names=FALSE)



#### Boston #### 

api <- paste("http://data.cityofboston.gov/resource/awu8-dc52.csv?$where=type=%27Rodent%20Activity%27AND%20open_dt%20%3E%20%27", lastWeek, "%27", sep="")

bos <- read.csv(url(api))

# Bring in all data, combine it, and save new CSV
# I do this to update data and to provide a comparison
allData <- read.csv("./data/Boston_rats.csv")
allData <- rbind(allData, bos)
allData <- allData[!duplicated(allData$CASE_ENQUIRY_ID), ] #remove duplicates
write.csv(allData, "./data/Boston_rats.csv", row.names=FALSE)


