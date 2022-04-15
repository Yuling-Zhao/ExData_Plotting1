library(dplyr)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "Electric power comsumption.zip", method = "curl")
unzip("Electric power comsumption.zip")

household_power_consumption <- read.table("household_power_consumption.txt", header = T, sep = ";")

practice_file <- household_power_consumption 
practice_file$Date <- as.Date(practice_file$Date, "%d/%m/%Y")
practice_file$Day <- as.POSIXlt(practice_file$Date)$wday
practice_file$Global_active_power <- as.numeric(practice_file$Global_active_power)
practice_file <- practice_file[!is.na(practice_file$Global_active_power),]

str(practice_file)

subset <- filter(practice_file, practice_file$Date == c("2007-02-01", "2007-02-02"))
subset <- mutate(subset, day_time = paste(subset$Date, subset$Time))
subset$day_time <- strptime(subset$day_time, "%Y-%m-%d %H:%M:%S")
str(subset)

plot_3 <- plot(x = subset$day_time, y = subset$Sub_metering_1, type = "n")
lines(x = subset$day_time, y = subset$Sub_metering_1, col = "black")
lines(x = subset$day_time, y = subset$Sub_metering_2, col = "red")
lines(x = subset$day_time, y = subset$Sub_metering_3, col = "blue")
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()
