filename<- "household_power_consumption.txt"

thetab<- read.table(filename, sep=";", na.strings="?", header=TRUE,  stringsAsFactors =!default.stringsAsFactors())

#library(data.table)

md=data.frame(thetab)
md<-droplevels(md)



#create dates
dat<-strptime(paste(md$Date,md$Time,sep=" "),format='%Y-%m-%d %H:%M:%S')

#convert types
md$Date<-as.Date(md$Date, "%d/%m/%Y")
md$Global_active_power<-as.numeric(md$Global_active_power)

#subset data

small_md<-subset(md, Date >="2007-01-02", select=c(Date,Time,Voltage, Global_active_power, Global_reactive_power, Sub_metering_1, Sub_metering_2, Sub_metering_3), drop=TRUE)

#get pointer for date table
first_line<- nrow(md)-nrow(small_md)

small_md<-subset(small_md, Date <= "2007-02-02", select=c(Date,Time,  Sub_metering_1, Sub_metering_2, Sub_metering_3))

#get pointer for date table
last_line<-first_line+ nrow(small_md)-1

#create date table
dat<-dat[first_line: last_line]

library(datasets)
par(mfrow=c(2,2))

# plot existing stuff
plot(dat,small_md$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

# plot new stuff
plot(dat,small_md$Voltage,type="l",xlab="datetime",ylab="Voltage")

# plot existing stuff
plot(dat,small_md$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
legend('topright',lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.9)

lines(dat,small_md$Sub_metering_2,col="red")
lines(dat,small_md$Sub_metering_3,col="blue")



# plot new stuff
plot(dat,small_md$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.copy(png,file="plot4.png")
dev.off()

