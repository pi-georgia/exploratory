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

small_md<-subset(md, Date >="2007-01-02", select=c(Date,Time, Sub_metering_1, Sub_metering_2, Sub_metering_3), drop=TRUE)

#get pointer for date table
first_line<- nrow(md)-nrow(small_md)

small_md<-subset(small_md, Date <= "2007-02-02", select=c(Date,Time,  Global_active_power))

#get pointer for date table
last_line<-first_line+ nrow(small_md)-1

#create date table
dat<-dat[first_line: last_line]


#plot
library(datasets)
plot(dat,small_md$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

#create png
dev.copy(png,file="plot2.png")
dev.off()




