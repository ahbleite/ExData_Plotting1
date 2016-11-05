#Check if library is installed if not install it
if("readr" %in% rownames(installed.packages()) == FALSE) {install.packages("readr")}
library(readr)
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
library(dplyr)
if("lubridate" %in% rownames(installed.packages()) == FALSE) {install.packages("lubridate")}
library(lubridate)

hpcData <- read_delim("data/household_power_consumption.txt",
                      delim = ";",
                      col_types = "ccddddddd",
                      na = c("?"))

hpcData <- mutate(hpcData, 
                  datetime = fast_strptime(paste(Date, Time), 
                                           "%d/%m/%Y %H:%M:%S", 
                                           lt=FALSE, 
                                           tz = "UTC"))

hpcData <- hpcData[between(hpcData$datetime, 
                           as.POSIXct("2007-02-01 00:00:00", tz="UTC"), 
                           as.POSIXct("2007-02-02 23:59:59", tz="UTC")),]

png(filename = "plot4.png",
    width = 480, 
    height = 480,
    bg="transparent")

par(mfcol = c(2,2))

#Graph 1
plot(hpcData$datetime, 
     hpcData$Global_active_power, 
     type = "l", 
     ylab = "Global Active Power", 
     xlab = "")


#Graph 2
plot(hpcData$datetime, 
     hpcData$Sub_metering_1, 
     type = "n", 
     ylab = "Energy sub metering", 
     xlab = "")

lines(hpcData$datetime, 
      hpcData$Sub_metering_1, 
      type="l",
      col="black")

lines(hpcData$datetime, 
      hpcData$Sub_metering_2, 
      type="l",
      col="red")

lines(hpcData$datetime, 
      hpcData$Sub_metering_3, 
      lwd=1,
      type="l",
      col="blue")

legend("topright", 
       col = c("black","red", "blue"), 
       lty=c(1,1),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Graph 3
plot(hpcData$datetime, 
     hpcData$Voltage, 
     type = "l", 
     ylab = "Voltage", 
     xlab = "datetime")

#Graph 3
plot(hpcData$datetime, 
     hpcData$Global_reactive_power, 
     type = "l", 
     ylab = "Global_reactive_power", 
     xlab = "datetime")

dev.off()