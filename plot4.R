# Plot 4 - creating 4 subplots and output them to 'plot4.png'. The graphs are:
# topleft: line graph of Global Active Power against datetime
# topright: line graph of Voltage against datetime
# bottomleft: line graph of Sub_metering_1, Sub_metering_2 and Sub_metering_3 against datetime
# bottomright: line graph of Global Reactive Power against datetime
#
# The code assumes that a file named "household_power_consumption.txt" is in
# the current working folder

plot4 <- function()
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
    png("plot4.png")
    # set up the plotting frame to accept 4 subplots
    par(mfrow=c(2,2))
    # top left plot
    plot(x=plotdata$Time, y=plotdata$Global_active_power, type="l", xlab="", ylab="Global Active Power")
    # top right plot
    plot(x=plotdata$Time, y=plotdata$Voltage, type="l", xlab="datetime", ylab="Voltage")
    # bottom left plot
    plot(x=plotdata$Time, y=plotdata$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
    lines(x=plotdata$Time, y=plotdata$Sub_metering_2, col="red")
    lines(x=plotdata$Time, y=plotdata$Sub_metering_3, col="blue")
    legend(x="topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty="n")
    # bottom right plot
    plot(x=plotdata$Time, y=plotdata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
    # finish writing to the output file
    dev.off()
}