# Plot 3 - creating line graph of for Sub_metering_1, Sub_metering_2 and Sub_metering_3
# against datetime and output to plot3.png
#
# The code assumes that a file named "household_power_consumption.txt" is in
# the current working folder

plot3 <- function()
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
    png("plot3.png")
    # create the line graph and plot the first series    
    plot(x=plotdata$Time, y=plotdata$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering")
    # add the second series    
    lines(x=plotdata$Time, y=plotdata$Sub_metering_2, col="red")
    # add the third series   
    lines(x=plotdata$Time, y=plotdata$Sub_metering_3, col="blue")
    # add the legend  
    legend(x="topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
    # finish writing to the output file
    dev.off()
}