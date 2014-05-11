#### Exploratory Data Analysis ## May 2014 ####
##### Course Project ## Adriana Dominguez #####
################### Plot 2 ####################

## For some reason, my graph axes were in Spanish, so with a little 
## investigation, I discovered that I have to add these two lines
## to change them to English.
language <- "English"
Sys.setlocale("LC_TIME", language) 

## Set the directory where the household power consumption data is. 
setwd("C:\\Users\\adriana dominguez\\Documents\\CourseraDataScience\\GCData")

##############################
## To subset the data, I was beating myself up until I saw some help from the forums
## So, the data is in order (we can verify that), and we are only interested in data
## that have a date 2007-02-01 or 2007-02-02. The dataset we are given has measurements
## of hours, minutes and seconds, so we want to focus on these two days (as in 2*24*60=2880
## minutes). To do that, we must read the first line to see where we are starting from. That is:
#          read.table("household_power_consumption.txt", nrow = 1, header = TRUE, sep=";")
## Thus, our dataset starts at an observation with date 16/12/2006 and time 17:24:00.
## From then until the next day, 2006-12-17 00:00:00 are a total of 6 hours and 37 minutes
## or rather 6*60 + 37 = 397 minutes. Now we must find the total number of whole days from 
## 2006-12-17 until 2007-02-01: 
#          x <- as.POSIXct("2006-12-17 00:00:00")
#          y <- as.POSIXct("2007-02-01 00:00:00")
#          y - x
## Which gives 46, and thus there are 42 days between 2006-12-17 and 2007-02-01, which means that
## there is a total number of minutes between those days of 46*24*60 = 66240. And this way the first
## row we should care about is 66240+397 = 66637. We can see we are correct by reading the following row:
#          read.table("household_power_consumption.txt", skip=66637, nrow = 1, header = TRUE, sep=";")
## Which gives us:
##  X1.2.2007 X00.00.00 X0.326 X0.128 X243.150 X1.400 X0.000 X0.000.1 X0.000.2
## 1  1/2/2007  00:01:00  0.326   0.13   243.32    1.4      0        0        0
################################

## So now that we have the reasoning behind the numbers 66637 and 2880, we have the following piece
## of code to read the dataset into R:

## na.strings sets "?" to NA
## The data is also separated by ";"
powerData <- read.table("household_power_consumption.txt", skip = 66637, nrow = 2880, 
                   sep = ";", na.strings="?", 
                   col.names = colnames(read.table("household_power_consumption.txt",
                   nrow = 1, header = TRUE, sep=";"))) 

## It was easier to convert powerData$Date and powerData$Time to characters
powerData$Date <- as.character(powerData$Date)
powerData$Time <- as.character(powerData$Time)

## We're going to need powerData$DateTime for this plot. It joins the columns
## for Date and Time so that we can use the strptime function
powerData$DateTime <- strptime(paste(powerData$Date, powerData$Time),
	 format="%d/%m/%Y %H:%M:%S")

##### Plot 2
## We make a line plot of the data with the corresponding axes names.
plot(powerData$DateTime,powerData$Global_active_power,type="l",ylab="Global Active Power 
	(kilowatts)",xlab="")
par(mar=c(2,8,2,2)) # This is so that the y axis name will show  up completely
dev.copy(png, file = "plot2.png")
dev.off()