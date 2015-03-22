# setwd("/Users/dphnrome/Documents/Git/rmR/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")
setwd("/home/pi/Github/rmR")

today <- Sys.Date()
yesterday <- today - 1
lastWeek <- today - 7
tenDaysAgo <- today - 10


#### Chicago

api <- paste("http://data.cityofchicago.org/resource/97t6-zrhs.csv?$where=creation_date%20%3E%20%27", lastWeek, "%27", sep="")

chi <- read.csv(url(api))
