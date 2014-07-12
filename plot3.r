filename<- "household_power_consumption.txt"

thetab<- read.table(filename, sep=";", na.strings="?")
library(data.table)
md=data.table(thetab)
small_md$V1<-as.Date(small_md$V1, "%d/%m/%y")
small_md$V3<-as.numeric(small_md$V3)

small_md<-md[md$V1 >= "2/1/2007"),]
small_md<-md[md$V1 <= "2/2/2007"),]

small_md$V3<-as.numeric(small_md$V3)

library(datasets)

plot(thetab,small_md$V7,type="l",xlab="",ylab="Energy sub metering")
legend('topright',lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.9)

lines(thetab,small_md$V8,col="red")
lines(thetab,small_md$V9,col="blue")


dev.copy(png,file="plot3.png")


