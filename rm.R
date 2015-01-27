setwd("/Users/dphnrome/Documents/Git/rmR/")
setwd("C:/Users/dhadley/Documents/GitHub/rmR")

library(lubridate)
library(tidyr)
library(dplyr)
library(broom) # augments d with model variables
library(ggplot2)
library(ggmap)
library(randomForest)

library(RCurl)

#### NYC data ####
# Import data from Socrata
# Using their api
# nyc <- read.csv(url("http://data.cityofnewyork.us/resource/
#                     erm2-nwe9.csv?$limit=%2020000&descriptor=Rat%20Sighting"))
# # Write the dataset so I don't have to keep importing from Socrata
# dB <- dBRaw
# write.csv(dBRaw, file = "./data/NYC.csv")

# Plain Text:
# https://data.cityofnewyork.us/resource/erm2-nwe9.json?$where=descriptor='Rat Sighting'AND created_date > '2015-01-20'

# As URL
#https://data.cityofnewyork.us/resource/erm2-nwe9.csv?$where=descriptor=%27Rat%20Sighting%27AND%20created_date%20%3E%20%272015-01-20%27

nyc <- read.csv(url("http://data.cityofnewyork.us/resource/erm2-nwe9.csv?$where=descriptor=%27Rat%20Sighting%27AND%20created_date%20%3E%20%272015-01-20%27"))
