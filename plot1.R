#Check if library is installed if not install it
if("readr" %in% rownames(installed.packages()) == FALSE) {install.packages("readr")}
library(readr)


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

png(filename = "plot1.png",
    width = 480, 
    height = 480,
    bg="transparent")

hist(hpcData$Global_active_power, 
    col = "red", 
    main = "Global Active Power", 
    xlab = "Global Active Power (kilowatts)")

dev.off()