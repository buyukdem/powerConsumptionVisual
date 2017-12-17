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

#changing the device
png(filename = "plot1.png")

#plot1
hist(dataset$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     col = "red", main = "Global Active Power")

#checking and closing the device
dev.cur()
dev.off()