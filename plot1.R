# Plot 1 - creating histogram of Global Active Power and output to plot1.png
#
# The code assumes that a file named "household_power_consumption.txt" is in
# the current working folder

plot1 <- function()
{
    filename <- "household_power_consumption.txt"
    # read in raw data
    rawdata <- read.csv(filename, sep=";", na.strings="?", colClasses="character")
    # convert the Time field to Time
    rawdata$Time <- strptime(paste(rawdata$Date, rawdata$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
    # convert the Date field to Date
    rawdata$Date <- as.Date(rawdata$Date, format="%d/%m/%Y")
    # convert the rest of the fields to numeric
    rawdata[, 3:9] <- lapply(rawdata[, 3:9], function(f) as.numeric(f))
    # select the plot data over the two days period 2007-02-01 and 2007-02-02
    plotdata <- rawdata[rawdata$Date %in% as.Date(c("2007/02/01", "2007/02/02")),]
    # divert the output to the png file
    png("plot1.png")
    # create the histogram
    hist(plotdata$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
    # finish writing to the output file
    dev.off()
}