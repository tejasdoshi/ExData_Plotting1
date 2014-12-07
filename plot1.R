
library(dplyr)

#Read the downloaded epc data to memory if not already
if(is.null(feb_epcdata)) {
  epcdata <- read.csv2("../epcdata/household_power_consumption.txt", header=TRUE, sep=";", dec=".", na.strings="?")
  
  #Convert Date and Time columns to proper format
  epcdata$Date <- as.Date(epcdata$Date, "%d/%m/%Y")
  epcdata$Time <- strftime(strptime(epcdata$Time, "%H:%M:%S"), "%H:%M:%S")
  
  #filter the data to our interested dates
  feb_epcdata <- filter(epcdata, Date >= '2007-02-01', Date <= '2007-02-02')
} else {
  print("Using existing filtered epcdata!")
}


#open the png device
png("figure/plot1.png")
#lets plot the data for plot1
hist(feb_epcdata$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
#close the png device
dev.off()