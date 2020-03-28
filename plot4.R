library(sqldf)
library(dplyr)
library(lubridate)

# load and prepare data
consumption <- read.csv.sql('./data/household_power_consumption.txt',
                            'select * from file where Date = "1/2/2007" or Date = "2/2/2007" ',
                            sep=';')

consumption <- consumption%>%
  mutate(DateTime = as.POSIXct(dmy(Date) + hms(Time)))

# 
par(mfcol = c(2,2))

# plot 1
plot(consumption$DateTime, 
     consumption$Global_active_power, 
     type="l",
     ylab = 'Global Active Power',
     xlab = '')

#  plot 2
plot(consumption$DateTime, 
     consumption$Global_active_power, 
     type = "n",
     ylab = 'Energy sub metering',
     xlab = '',
     ylim = c(0,38))

line_color <- c('black','red','blue')

for(i in 1:3) {
  lines(x = consumption$DateTime,
        y = consumption[,6+i],
        type = 'l',
        col = line_color[i])
}

legend <- legend("topright",
                 plot = FALSE)

leftx <- legend$rect$left * 0.99994
rightx <- (legend$rect$left + legend$rect$w)
topy <- legend$rect$top
bottomy <- (legend$rect$top - legend$rect$h) * 0.65

legend(x = c(leftx, rightx), y = c(topy, bottomy),
       legend = names(consumption[7:9]), 
       lty = 1, 
       col = line_color,
       bty = 'n')

# plot 3
plot(consumption$DateTime, 
     consumption$Voltage, 
     type="l",
     ylab = 'Voltage',
     xlab = 'datetime')

# plot 4
plot(consumption$DateTime, 
     consumption$Global_reactive_power, 
     type="l",
     ylab = 'Global_reactive_power',
     xlab = 'datetime')

# export the graph
dev.print(png, file='plot4.png',height=480,width=480)
dev.off()