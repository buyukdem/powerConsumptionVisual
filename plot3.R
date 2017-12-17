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
png(filename = "plot3.png")

#plot3
plot(dataset$Sub_metering_1 ~ dataset$datetime, 
     ylab = "Energy sub metering", xlab = "", type = "l")
lines(dataset$Sub_metering_2 ~ dataset$datetime, col = "blue")
lines(dataset$Sub_metering_3 ~ dataset$datetime, col = "red")

legend("topright", col = c("black","blue","red"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#checking and closing the device
dev.cur()
dev.off()