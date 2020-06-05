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

## create a file to save the plot to
png('plot1.png')

## plot the histogram
hist(select_data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power")

## close the file
dev.off()
