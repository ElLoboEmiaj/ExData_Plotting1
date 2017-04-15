#step 0: checking file-->unzip the dataset:

if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

#Step 1: Reading and setting our Data Set
#Reading
DataSet<-read.table(file,header=TRUE,sep=";")

#change to Date format
DataSet$Date<-as.Date(DataSet$Date, format="%d/%m/%Y")

#Setting the Data that we need
date1<-as.Date("2007-02-01")
date2<-as.Date("2007-02-02")
subset<-DataSet[DataSet$Date>=date1&DataSet$Date<=date2,]

#converting the other Variables in order to plot
subset$Global_active_power <- as.numeric(as.character(subset$Global_active_power))
subset$Global_reactive_power <- as.numeric(as.character(subset$Global_reactive_power))
subset$Voltage <- as.numeric(as.character(subset$Voltage))

subset <- transform(subset, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
subset$Sub_metering_1 <- as.numeric(as.character(subset$Sub_metering_1))
subset$Sub_metering_2 <- as.numeric(as.character(subset$Sub_metering_2))
subset$Sub_metering_3 <- as.numeric(as.character(subset$Sub_metering_3))

#Plotting Graph
plot3 <- function() {
  plot(subset$timestamp,subset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(subset$timestamp,subset$Sub_metering_1,col="brown")
  lines(subset$timestamp,subset$Sub_metering_2,col="red")
  lines(subset$timestamp,subset$Sub_metering_3,col="blue")
  
  
  legend("topright", col=c("brown","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
  
  #Output
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
  
}
plot3()