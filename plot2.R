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

# This is required because the 4th plot resets the mfrow, so if you are running
# plot1, plot2, plot3 and plot4 in cycles the first 3 will start using the mfrow
# setting of the 4th. So, it needs to be reset to 1, 1.
par(mfrow = c(1, 1))

# Create the time axis, and then plot the variable required against time
with(dataset, {
    time <- strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")
    plot(time, 
         Global_active_power, 
         type = "l",
         xlab = "",
         ylab = "Global Active Power (kilowatts)"
    )
 })

# Copy this to the png device and flush to the file
dev.copy(png, file = "plot2.png")
dev.off()