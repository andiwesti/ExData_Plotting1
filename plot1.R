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
hist(consumption$Global_active_power,
     col = 'red',
     xlab = 'Global Active Power (kilowats)',
     main = 'Global Active Power')

# export the graph
dev.print(png, file='plot1.png',height=480,width=480)
dev.off()