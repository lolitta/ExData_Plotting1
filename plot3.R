if (!file.exists("./data")){dir.create("./data")}
if (file.exists("exdata_data_household_power_consumption.zip")){
    unzip("exdata_data_household_power_consumption.zip", exdir="./data", overwrite=TRUE)
}
library(lubridate)
Sys.setlocale(category ="LC_ALL", locale="C")

#### measure reading time
##system.time(read.table("./data/household_power_consumption.txt", sep=";", header=TRUE))

## Read data file
pc <- read.table("./data/household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

## Create a subset for using data from the dates 2007-02-01 and 2007-02-02
df <- subset(pc, dmy(pc$Date) %in% c(dmy('1/2/2007'), dmy('2/2/2007')))
rm(pc)

##Grenate plot 3
par(mfrow = c(1,1), mar = c(4,4,2,1))
plot(x=as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")
     , y=df$Sub_metering_1 
     , type="l"
     , col= "black"
     , xlab= ""
     , ylab= "Energy sub metering")
lines(x=as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")
      , y=df$Sub_metering_2, type="l"
      , col= "red")
lines(x=as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")
      , y=df$Sub_metering_3, type="l"
      , col= "blue")
legend("topright"
       , lwd =1
       , col= c("black", "red", "blue")
       , cex= 0.7
       , legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )

## Create PNG file in working direcotry
dev.copy(png, file ="plot3.png", width=480, height=480)
dev.off()