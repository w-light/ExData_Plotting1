temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";",header=TRUE, 
                   stringsAsFactors = FALSE, na.strings = "?")
unlink(temp)

## convert the date variable to date format
data$Date <- strptime(data$Date, format = "%d/%m/%Y")
data$Date <- as.Date(data$Date)

## select only the required data by date
select_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

## convert date and time columns into one datetime object
select_data$Datetime <- as.POSIXct(paste(select_data$Date, select_data$Time), 
                                   format="%Y-%m-%d %H:%M:%S")
## create a file to save the plot
png("plot4.png")

## set up the plot area
par(mfcol=c(2,2))

## plot the first graph
plot(select_data$Datetime, select_data$Global_active_power, type = "S", xlab = "",
     ylab = "Global Active Power")

## plot the second graph
plot(select_data$Datetime, select_data$Sub_metering_1, type="S", 
     xlab="", ylab="Energy sub metering")
lines(select_data$Datetime, select_data$Sub_metering_2, type="S", col="red")
lines(select_data$Datetime, select_data$Sub_metering_3, type="S", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty=1, bty="n")

## plot the third graph
plot(select_data$Datetime, select_data$Voltage, type = "S", xlab = "datetime",
     ylab = "Voltage")
## plot the fourth graph
plot(select_data$Datetime, select_data$Global_reactive_power, type = "S",
     xlab="datetime", ylab="Global_reactive_power")
## close the file
dev.off()
