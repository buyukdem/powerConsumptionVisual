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
png(filename = "plot2.png")

#plot2
plot(dataset$Global_active_power ~ dataset$datetime, ylab = "Global Active Power (kilowatts)", 
     xlab = "", type = "l")

#checking and closing the device
dev.cur()
dev.off()