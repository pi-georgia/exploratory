filename<- "household_power_consumption.txt"

thetab<- read.table(filename, sep=";", na.strings="?", header=TRUE,  stringsAsFactors =!default.stringsAsFactors())

#library(data.table)

md=data.frame(thetab)
md<-droplevels(md)

#convert types

dat<-strptime(paste(md$Date,md$Time,sep=" "),format='%d/%m/%Y %H:%M:%S')

md$Date<-as.Date(md$Date, "%d/%m/%Y")
md$Global_active_power<-as.numeric(md$Global_active_power)

#subset

small_md<-subset(md, Date >="2007/02/01", select=c(Date,Time, Global_active_power), na.omit())
small_md<-subset(small_md, Date <= "2007/02/02", select=c(Date,Time, Global_active_power))

library(datasets)

plot(dat,small_md$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
legend('topright',lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.9)

lines(thetab,small_md$Sub_metering_2,col="red")
lines(thetab,small_md$Sub_metering_3,col="blue")


dev.copy(png,file="plot3.png")

dev.off()
