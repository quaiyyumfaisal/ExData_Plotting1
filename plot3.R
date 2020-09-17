## Reading power consumption data

power <- read.table("household_power_consumption.txt", skip = 1, sep = ";")

## Naming the columns of power consumption data

names(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
                  "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                  "Sub_metering_3")

## Subsetting power consumption data
subpower <- subset(power, power$Date == "1/2/2007" | power$Date == "2/2/2007")

## Transforming the Date and Time variables from characters into objects of type:
## Date and POSIXlt respectively.

subpower$Date <- as.Date(subpower$Date ,format = "%d/%m/%Y")
subpower$Time <- strptime(subpower$Time, format = "%H:%M:%S")
subpower[1:1440, "Time"] <- format(subpower[1:1440, "Time"], "2007-02-01 %H:%M:%S")
subpower[1441:2880, "Time"] <- format(subpower[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

## Constructing and Saving the plot to a PNG file
png("plot3.png",  width = 480, height = 480)
plot(subpower$Time, subpower$Sub_metering_1, type="n", xlab="", ylab = "Energy sub metering", main = "Energy sub_metering")
with(subpower, {
    lines(Time, as.numeric(as.character(Sub_metering_1)))
    lines(Time, as.numeric(as.character(Sub_metering_2)), col = "red")
    lines(Time, as.numeric(as.character(Sub_metering_3)), col = "blue")
})
legend("topright", lty=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1",
                                                    "Sub_metering_2", "Sub_metering_3"))
dev.off()