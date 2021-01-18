install.packages("data.table")
library("data.table")

data <- read.table("household_power_consumption.txt", header= TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
summary(data)

#Subset data
subsetdata <- data[data$Date %in% c("1/2/2007","2/2/2007"),]
globalActivePower <- as.numeric(subsetdata$Global_active_power)
globalReactivePower <- as.numeric(subsetdata$Global_reactive_power)
voltage <- as.numeric(subsetdata$Voltage)
subMetering1 <- as.numeric(subsetdata$Sub_metering_1)
subMetering2 <- as.numeric(subsetdata$Sub_metering_2)
subMetering3 <- as.numeric(subsetdata$Sub_metering_3)

#Plot1. Histogram
png("plot1.png", width=480, height=480)

hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

dev.off()

#Plot2. Time Series
png("plot2.png", width=480, height=480)
datetime <- strptime(paste(subsetdata$Date, subsetdata$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

#Plot 3.
png("plot3.png", width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()


#Plot 4. 
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
# Plot 4a
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
# Plot 4b
plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")
# Plot 4c
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
# Plot 4d
plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power", cex=0.2)
dev.off()
