setwd("/Users/dphnrome/Documents/Git/rmR/oneOffScripts/")
# setwd("C:/Users/dhadley/Documents/GitHub/rmR")

library(lubridate)
library(tidyr)
library(dplyr)
library(scales)
library(ggplot2)
library(ggmap)


#### NYC ####
nyc <- read.csv("../data/NYC_rats.csv")

# Mainly fixing dates
d <- nyc %>%
  tbl_df()  %>% # Convert to tbl class - easier to examine than dfs
  mutate(dateTime = mdy_hms(Created.Date, tz='EST')) %>%
  arrange(dateTime) %>%
  mutate(date = as.Date(dateTime),
         hour = hour(dateTime)) %>%
  mutate(monthDay = day(date),
         weekDay = wday(date),
         month = month(date),
         year = year(date),
         Year.Month = format(date, '%Y-%m')) %>%
  select(Unique.Key:Park.Borough, Latitude:Year.Month) # drop useless columns


### This will give me a timeseries of every day
days <- d %>%
  group_by(date) %>%
  summarise(Events = n())

allDays <- seq.Date(from=d$date[1], to = d$date[nrow(d)], b='days')
allDays <- allDays  %>%  as.data.frame() 
colnames(allDays)[1] = "date"

# After this we will have a df with every date and how many BnEs
ts = merge(days, allDays, by='date', all=TRUE)
ts[is.na(ts)] <- 0

remove(allDays, days)
ts$id <- seq(1, nrow(ts))



#### Visualize ####

my.theme <- 
  theme(#plot.background = element_rect(fill="white"), # Remove background
    panel.grid.major = element_blank(), # Remove gridlines
    # panel.grid.minor = element_blank(), # Remove more gridlines
    # panel.border = element_blank(), # Remove border
    # panel.background = element_blank(), # Remove more background
    axis.ticks = element_blank(), # Remove axis ticks
    axis.text=element_text(size=6), # Enlarge axis text font
    axis.title=element_text(size=8), # Enlarge axis title font
    plot.title=element_text(size=12) # Enlarge, left-align title
    ,axis.text.x = element_text(angle=60, hjust = 1) # Uncomment if X-axis unreadable 
  )


## Every Month
monthly <- d %>%
  filter(year > 2009) %>%
  group_by(Year.Month) %>%
  filter(Year.Month != "2015-02") %>%
  summarise(Events = n()) %>%
  mutate(Year.Month = as.Date(paste(Year.Month,1,sep="-"),"%Y-%m-%d")) 
  
ggplot(monthly, aes(x=Year.Month, y=Events, group = 1)) + 
  geom_line(colour='red', size = 1) + 
  my.theme + ggtitle("Monthly Rat Calls, NYC") + xlab("Year") +
  ylab("311 Calls") + 
  scale_y_continuous(labels = comma) +
  scale_x_date(labels=date_format("%Y"))
  
ggsave("../plots/RatStats/NYC_Rats_monthly.png", dpi=250, width=5, height=3)


## Borough
borough <- d %>%
  filter(year > 2009) %>%
  group_by(Borough) %>%
  summarise(Events = n()) %>%
  filter(Borough != "Unspecified")

ggplot(borough, aes(x=reorder(Borough, Events), y=Events)) + 
  geom_bar(stat = "identity", colour="white", fill="red") +
  geom_line(colour='red', size = 1) + 
  my.theme + ggtitle("Rat Calls By Borough") + xlab("Borough") +
  ylab("311 Rat Calls") + 
  scale_y_continuous(labels = comma) 

ggsave("../plots/RatStats/NYC_Rats_by_borough.png", dpi=250, width=3, height=3)




