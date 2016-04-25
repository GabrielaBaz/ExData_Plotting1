library(dplyr)

# Read the data into R
power<-read.table("./household_power_consumption.txt",header=TRUE,sep=";")

#Format the date
power$Date<-as.Date(power$Date,"%d/%m/%Y")

#Subset the data
power_sub<-subset(power,Date >="2007-02-01" & Date<="2007-02-02")

#Convert factors to numeric
power_sub$Global_active_power<-as.numeric(as.character(power_sub$Global_active_power))

#Create histogram
hist(power_sub$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

dev.copy(png,file="plot1.png", width=480, height=480)

dev.off()
