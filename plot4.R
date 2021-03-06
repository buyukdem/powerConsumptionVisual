#Getting the dataset and date conversion
mydata <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", 
                   stringsAsFactors=F, na.strings = "?")
mydata$Date <- as.Date(mydata$Date, "%d/%m/%Y")
mydata[,3:8] <- lapply(mydata[,3:8], as.numeric)
str(mydata)
head(mydata)

#subsetting the dataset
dataset <- subset(mydata, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(mydata)

#datetime variable
datetime <- paste(dataset$Date, dataset$Time)
dataset$datetime <- datetime
dataset$datetime <- as.POSIXct(dataset$datetime)
str(dataset)

#changing the device
png(filename = "plot4.png")

#plot4
par(mfcol = c(2,2))

plot(dataset$Global_active_power ~ dataset$datetime, ylab = "Global Active Power", xlab = "", type = "l")

with(dataset,
     {
        plot(Sub_metering_1 ~ datetime, 
             ylab = "Energy sub metering", xlab = "", type = "l")
        lines(Sub_metering_2 ~ datetime, col = "blue")
        lines(Sub_metering_3 ~ datetime, col = "red")
     })
legend("topright", col = c("black","blue","red"), lty = 1, lwd = 2, bty = "n", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)

plot(dataset$Voltage ~ dataset$datetime, ylab = "Voltage", type = "l", xlab = "datetime")

plot(dataset$Global_reactive_power ~ dataset$datetime, type = "l", xlab = "datetime")

#checking and closing the device
dev.cur()
dev.off()