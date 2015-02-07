###  No need to unpack the archive !!!!
data <- read.table(unzip(zipfile = file.choose()),
                   header = TRUE,
                   sep = ";",
                   colClasses = c("character", "character",rep("numeric",7)),
                   na = "?")
##### We only need data of 2 days #####
dataFrom <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

library(dplyr)
library(stringr)
dataFrom <- mutate (dataFrom,
                    DayTime = paste(
                            dataFrom$Date, " ", dataFrom$Time)) #Combine the date and time

dataFrom$DayTime <- strptime(dataFrom$DayTime,
                             "%e/%m/%Y %H:%M:%S", tz = "GMT") #Convert the characters in time

# Sys.setlocale("LC_TIME", "English")
## Only for Cyrillic 
### Вместо "English" можно поставить "C" - Clear

attach(dataFrom)

##### Plot 4
png(filename = "plot4.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")
par(mfrow = c(2, 2))
## Top-left
plot(DayTime, Global_active_power, 
     type = "l",
     xlab = "", ylab = "Global Active Power")
## Top-right
plot(DayTime, Voltage,
     type = "l",
     xlab = "datetime", ylab = "Voltage")
## Bottom-left
plot(DayTime, Sub_metering_1, 
     type = "l",
     col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(DayTime, Sub_metering_2, col = "red")
lines(DayTime, Sub_metering_3, col = "blue")
# Remove the border of legend here.
legend("topright", 
       bty = "n",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)
## Bottom-right
plot(DayTime, Global_reactive_power, 
     type = "l",
     col = "black",
     xlab = "datetime", ylab = colnames(DayTime))
dev.off()

detach(dataFrom)