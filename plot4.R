# setup custom options

#setwd("D:\\R\\Exploratory Data Analysis\\Assignment1\\ExData_Plotting1")
library(dplyr)
Sys.setlocale("LC_TIME", "English")
windows.options(width=480, height=480)

# read data
hps <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

############ prepare variables start ##############
hps$Date_c <- as.character(hps$Date)
hps <- hps[hps$Date_c == "1/2/2007" | hps$Date_c == "2/2/2007" ,]
hps$Date <- format(as.Date(hps$Date, "%d/%m/%Y"),"%d/%m/%Y %a")
hps$Global_active_power <- as.numeric(as.character(hps$Global_active_power))
hps$Voltage <- as.numeric(as.character(hps$Voltage))
hps$Global_reactive_power <- as.numeric(as.character(hps$Global_reactive_power))
hps$Sub_metering_1 <- as.numeric(as.character(hps$Sub_metering_1))
hps$Sub_metering_2 <- as.numeric(as.character(hps$Sub_metering_2))
hps$Sub_metering_3 <- as.numeric(as.character(hps$Sub_metering_3))

hps$Time <- as.character(hps$Time)
hps$DT <- as.factor(paste(hps$Date, hps$Time))

hps$ax_labels = ifelse (hps$DT == "02/02/2007 Fri 00:00:00", "FRI",
                        ifelse (hps$DT == "02/02/2007 Fri 23:59:00", "SAT",
                                ifelse (hps$DT == "01/02/2007 Thu 00:00:00", "THU", "")
                        ))

hps$scale <- c(1:length(hps$Date))

x_ticks <- filter(hps, hps$ax_labels != "")[,ncol(hps)]
x_ticks_lbl <- filter(hps, hps$ax_labels != "")[,ncol(hps)-1]

############ prepare variables end ################

png("plot4.png") # open device

opar <- par()
par(mfrow = c(2, 2), mar = c(3, 3, 3, 3), oma = c(0, 2, 0, 0))

# creating plot 4

#1
plot(hps$DT, hps$Global_active_power ,type = "n" ,xaxt = 'n', ylab = "Global Active Power (kilowatts)")
points(hps$DT, hps$Global_active_power, type = "l")
axis(1, at=c(x_ticks), labels=c(x_ticks_lbl))

#2
plot(hps$DT, hps$Voltage ,type = "n", xaxt = 'n', ylab = "Voltage")
points(hps$DT, hps$Voltage, type = "l")
axis(1, at=c(x_ticks), labels=c(x_ticks_lbl))
mtext("datetime",1,line=2,at=1500)

#3
plot(hps$DT, hps$Sub_metering_3 , xaxt = 'n', type = "l", ylim = c(0,30), ylab = "Energy Sub Mergering")
points(hps$DT, hps$Sub_metering_3, type = "l" , col = "blue")
points(hps$DT, hps$Sub_metering_2, type = "l" , col = 2)
points(hps$DT, hps$Sub_metering_1, type = "l" , col = "grey")
axis(1, at=c(x_ticks), labels=c(x_ticks_lbl))
legend("topright", cex = 0.8,legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"), col = c("grey","red", "blue"), lty = c(1, 1, 1))


#4
plot(hps$DT, hps$Global_reactive_power ,type = "n", xaxt = 'n', ylab = "Global Reactive Power")
points(hps$DT, hps$Global_reactive_power, type = "l")
axis(1, at=c(x_ticks), labels=c(x_ticks_lbl))
mtext("datetime",1,line=2,at=1500)

dev.off() #close device
opar

