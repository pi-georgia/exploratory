filename<- "household_power_consumption.txt"

mydata<- read.table(filename, sep=";", na.strings="?")
library(data.table)
md=data.table(mydata)
small_md<-md[md$V1 == c("1/2/2007", "2/2/2007"),]
small_md$V3<-as.numeric(small_md$V3)
small_md$V3
library(datasets)
hist(small_md$V3, col="red", breaks=12)