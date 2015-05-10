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

##Grenate plot 2
par(mfrow = c(1,1), mar = c(4,4,2,1))
plot(as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")
     , df$Global_active_power
     , type= "l"
     , xlab= ""
     , ylab= "Global Active Power (kilowatts)")

## Create PNG file in working direcotry
dev.copy(png, file ="plot2.png", width=480, height=480)
dev.off()