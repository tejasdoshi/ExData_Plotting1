
library(dplyr)

#Read the downloaded epc data to memory if not already
if(!exists("feb_epcdata")) {
  epcdata <- read.csv2("../epcdata/household_power_consumption.txt", header=TRUE, sep=";", dec=".", na.strings="?")
  
  #Convert Date and Time columns to proper format
  epcdata$Date <- as.Date(epcdata$Date, "%d/%m/%Y")
  epcdata$Time <- strftime(strptime(epcdata$Time, "%H:%M:%S"), "%H:%M:%S")
  
  #filter the data to our interested dates
  feb_epcdata <- filter(epcdata, Date >= '2007-02-01', Date <= '2007-02-02')
  feb_epcdata$Datetime <- as.POSIXct(paste(feb_epcdata$Date, feb_epcdata$Time), format("%Y-%m-%d %H:%M:%S"))
} else {
  print("Using existing filtered epcdata!")
}


#open the png device
png("figure/plot3.png")
#lets plot the data for plot3
plot(feb_epcdata$Datetime, feb_epcdata$Sub_metering_1, pch="", xlab="", ylab="Energy sub metering", yaxp=c(0, 30, 3), ylim=c(0, 40))
plot(feb_epcdata$Datetime, feb_epcdata$Sub_metering_2, pch="", xlab="", ylab="Energy sub metering", yaxp=c(0, 30, 3), ylim=c(0, 40))
plot(feb_epcdata$Datetime, feb_epcdata$Sub_metering_3, pch="", xlab="", ylab="Energy sub metering", yaxp=c(0, 30, 3), ylim=c(0, 40))
lines(feb_epcdata$Datetime, feb_epcdata$Sub_metering_1, col="black")
lines(feb_epcdata$Datetime, feb_epcdata$Sub_metering_2, col="red")
lines(feb_epcdata$Datetime, feb_epcdata$Sub_metering_3, col="blue")

#add legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5, 2.5, 2.5), col=c("black", "red", "blue"))
#close the png device
dev.off()
