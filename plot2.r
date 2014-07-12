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
plot(thetab,small_md$V3,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.copy(png,file="plot2.png")


