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

png(filename = "plot3.png",
    width = 480, 
    height = 480,
    bg="transparent")

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

dev.off()