# setwd("/Users/dphnrome/Documents/Git/rmR/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")
setwd("/home/pi/Github/rmR")

library(ggplot2)
library(dplyr)
library(lubridate)
library(Cairo)

today <- Sys.Date()
tenDaysAgo <- today - 10

allData <- read.csv("./data/Chicago_rats.csv")

d <- allData %>%
  mutate(date = as.Date(Creation.Date, format="%m/%d/%Y")) %>%
  mutate(week = week(date),
         year = year(date)) %>%
  filter(date >= tenDaysAgo)  %>%  # last week
  arrange(date)


my.theme <- 
  theme(plot.background = element_rect(fill="white"), # Remove background
    panel.grid.major = element_blank(), # Remove gridlines
    panel.grid.minor = element_blank(), # Remove more gridlines
    panel.border = element_blank(), # Remove border
    panel.background = element_blank(), # Remove more background
    axis.ticks = element_blank(), # Remove axis ticks
    axis.text=element_text(size=6), # Enlarge axis text font
    axis.title=element_text(size=8), # Enlarge axis title font
    plot.title=element_text(size=12) # Enlarge, left-align title
    ,axis.text.x = element_text(angle=60, hjust = 1) # Uncomment if X-axis unreadable 
  )

#### Time Series ####
days <- d %>%
  group_by(date) %>%
  summarise(Events = n())

allDays <- seq.Date(from=d$date[1], to = d$date[nrow(d)], b='days')
allDays <- allDays  %>%  as.data.frame() 
colnames(allDays)[1] = "date"

# After this we will have a df with every date and how many work orders
ts = merge(days, allDays, by='date', all=TRUE)
ts[is.na(ts)] <- 0

remove(allDays, days)

highest <- subset(ts, Events == max(Events))
lowest <- subset(ts, Events == min(Events))

# In case there is more than 1
highest <- highest[1:1,]
lowest <- lowest[1:1,]

Cairo(file="/home/pi/Github/ratmaps/images/pages/RatStats/ChicagoSparkline.png", 
      units="in", 
      width=4, 
      height=4, 
      pointsize=12, 
      res=200) 

ggplot(ts, aes(x=date, y=Events)) + 
  geom_line(colour="black", size = .5) + 
  my.theme + ggtitle("Rat Calls Over Time") + xlab("Time") +
  ylab("Daily Calls") + 
  # scale_y_continuous(labels = comma) +
  geom_point(data = lowest, size = 3, colour = "blue") +
  geom_point(data = highest, size = 3, colour = "red")

dev.off()