temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";",header=TRUE, 
                   stringsAsFactors = FALSE, na.strings = "?")
unlink(temp)

head(data)
names(data)

## convert the date variable to date format
data$Date <- strptime(data$Date, format = "%d/%m/%Y")
data$Date <- as.Date(data$Date)

## select only the required data by date
select_data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

## convert date and time columns into one datetime object
select_data$Datetime <- as.POSIXct(paste(select_data$Date, select_data$Time), format="%Y-%m-%d %H:%M:%S")

## create a file to save the plot
png("plot2.png")

## make the plot
plot(select_data$Datetime, select_data$Global_active_power, type = "S", xlab = "",
     ylab = "Global Active Power (kilowatts)")

## close the file
dev.off()

