library(dplyr)
library(lubridate)

# Read the data into R
power<-read.table("./household_power_consumption.txt",header=TRUE,sep=";")

#Format the date
power$Date<-as.Date(power$Date,"%d/%m/%Y")

#Subset the data
power_sub<-subset(power,Date >="2007-02-01" & Date<="2007-02-02")

#Convert factors to numeric
power_sub$Global_active_power<-as.numeric(as.character(power_sub$Global_active_power))

#Create Date_Time column
power_tb<-tbl_df(power_sub)
power_tb<-mutate(power_tb,Date_Time=paste(Date,Time))
power_tb$Date_Time<-strptime(power_tb$Date_Time,format="%Y-%m-%d %H:%M:%S")

#Create plot
plot(power_tb$Date_Time,power_tb$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")

dev.copy(png,file="plot2.png", width=480, height=480)

dev.off()
