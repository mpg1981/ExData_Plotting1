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

##### Plot 2
png(filename = "plot2.png", 
    width = 480, height = 480,
    units = "px", bg = "transparent")
plot(DayTime, Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()

detach(dataFrom)