library(sqldf)
library(dplyr)
library(lubridate)

# load and prepare data
consumption <- read.csv.sql('./data/household_power_consumption.txt',
                            'select * from file where Date = "1/2/2007" or Date = "2/2/2007" ',
                            sep=';')

consumption <- consumption%>%
  mutate(DateTime = as.POSIXct(dmy(Date) + hms(Time)))

# plot the graph
plot(consumption$DateTime, 
     consumption$Global_active_power, 
     type="l",
     ylab = 'Global Active Power (kilowats)',
     xlab = '')

# export the graph
dev.print(png, file='./figure/plot2.png',height=480,width=480)
dev.off()