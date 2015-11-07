# Set the working directory to where this file is. 
# Note that the UCI zip file is assumed to be in this directory.
setwd(dirname(parent.frame(2)$ofile))

# Read the file, as described in the project spec
reading <- read.table("household_power_consumption.txt", 
                      sep = ";", 
                      stringsAsFactors = F, 
                      header = T,
                      na.strings = "?")

# Subset only the interesting dataset
dataset <- reading[reading$Date == "1/2/2007" | reading$Date == '2/2/2007',]

# Set the mfrow to a 2, 2 matrix
par(mfrow = c(2, 2))

# Create the time axis, and then plot Global Active Power against time
with(dataset, {
    time <- strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")
    plot(time, 
         Global_active_power, 
         type = "l",
         col = "black",
         ylab = "Global Active Power",
         xlab = ""
    )
})

# Create the time axis, and then plot Voltage against time
with(dataset, {
    time <- strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")
    plot(time, 
         Voltage, 
         type = "l",
         col = "black",
         ylab = "Voltage",
         xlab = "datetime"
    )
})

# Create the time axis, and then plot the meter variables against time
# Note the cex resetting to less than 1 for the legend, so that it does
# does lie on top of the chart
with(dataset, {
    time <- strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")
    plot(time, 
         Sub_metering_1, 
         type = "l",
         col = "black",
         ylab = "",
         xlab = ""
    )
    lines(time, 
          Sub_metering_2, 
          col = "red"
    )
    lines(time, 
          Sub_metering_3, 
          col = "blue"
    )
    legend("topright",
           pch = "-",
           bty = "n",
           xjust = 1,
           yjust = 1,
           cex = 0.75,
           col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", 
                      "Sub_metering_2", 
                      "Sub_metering_3")
    )
    title(ylab = "Energy sub metering")
})

# Create the time axis, and then plot Global Reactive Power against time
with(dataset, {
    time <- strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")
    plot(time, 
         Global_reactive_power, 
         type = "l",
         cex = 1,
         col = "black",
         ylab = "Global_reactive_power",
         xlab = "datetime"
    )
})

# Copy this to the png device and flush to the file
dev.copy(png, file = "plot4.png")
dev.off()