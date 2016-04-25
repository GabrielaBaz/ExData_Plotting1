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
power_sub$Sub_metering_1<-as.numeric(as.character(power_sub$Sub_metering_1))
power_sub$Sub_metering_2<-as.numeric(as.character(power_sub$Sub_metering_2))
power_sub$Sub_metering_3<-as.numeric(as.character(power_sub$Sub_metering_3))

#Create Date_Time column
power_tb<-tbl_df(power_sub)
power_tb<-mutate(power_tb,Date_Time=paste(Date,Time))
power_tb$Date_Time<-strptime(power_tb$Date_Time,format="%Y-%m-%d %H:%M:%S")

#Plot the data one variable at a time
plot(power_tb$Date_Time, power_tb$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
points(power_tb$Date_Time, power_tb$Sub_metering_1, type="l")
points(power_tb$Date_Time, power_tb$Sub_metering_2, type="l",col="red")
points(power_tb$Date_Time, power_tb$Sub_metering_3, type="l",col="blue")

legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.6)

dev.copy(png,file="plot3.png", width=480, height=480)

dev.off()



