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

##Grenate plot 4
par(mfrow = c(2,2), mar = c(4,4,2,1))
plot(as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")
     , df$Global_active_power
     , type= "l"
     , xlab= ""
     , ylab= "Global Active Power (kilowatts)")
plot(as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")
     , df$Voltage
     , type= "l"
     , xlab= "datetime"
     , ylab= "Voltage")
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
       , legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , cex= 0.8
       , bty= "n")
plot(as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")
     , df$Global_reactive_power
     , type= "l"
     , xlab= "datetime"
     , ylab= "Global_reactive_power")

## Create PNG file in working direcotry
dev.copy(png, file ="plot4.png", width=480, height=480)
dev.off()