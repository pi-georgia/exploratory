filename<- "household_power_consumption.txt"

thetab<- read.table(filename, sep=";", na.strings="?", header=TRUE,  stringsAsFactors =!default.stringsAsFactors())

#library(data.table)

md=data.frame(thetab)
md<-droplevels(md)

#convert types

#dat<-strptime(paste(md$Date,md$Time,sep=" "),format='%d/%m/%Y %H:%M:%S')

md$Date<-as.Date(md$Date, "%d/%m/%Y")
md$Global_active_power<-as.numeric(md$Global_active_power)

#subset

small_md<-subset(md, Date >="2007/02/01", select=c(Date,Time, Global_active_power), na.omit())
small_md<-subset(small_md, Date <= "2007/02/02", select=c(Date,Time, Global_active_power))
                 
theday<-strptime(paste(small_md$Date,small_md$Time,sep=" "),format="%Y-/%d-/%m %H:%M:%S")


#plot
library(datasets)
plot(theday,small_md$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

#create png
dev.copy(png,file="plot2.png")
dev.off()


