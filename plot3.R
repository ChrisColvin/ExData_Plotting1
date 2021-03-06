## R code to generate plot3.png

## 0 Data Collection
      setwd("~/Data Science/data") ## Working Directory
      fileURL<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      
      ## Check to see if file exists
      if(file.exists("./household_power_consumption.zip") == FALSE) { 
            download.file(fileURL, "./household_power_consumption.zip", mode="wb")
      }
      
      if(file.exists("./household_power_consumption") == FALSE) {
            unzip("./household_power_consumption.zip", unzip = "internal")
      }

## 1 Reading and preparing the data
      power<- read.table("./household_power_consumption.txt",header = TRUE, sep=";", na.strings = "?") ## reads the data

      ## Combines date/time and converts to appropriate class
      power$Date_Time <- paste(power$Date, power$Time)
      power$Date_Time <- strptime(power$Date_Time, "%d/%m/%Y %H:%M:%S")
      power$Date<- as.Date(power$Date,"%d/%m/%Y")

      ## Subsets the data based upon February 1 & 2 2007
      powerFeb07<- subset(power,Date =="2007-02-01" | Date == "2007-02-02")

## 2 Creates Plot3, opens device and closes device
      png(filename = "./plot3.png")
      plot(powerFeb07$Date_Time,powerFeb07$Sub_metering_1,ylab = "Energy sub metering",xlab = "", type = "l", col = "black") 
      lines(powerFeb07$Date_Time,powerFeb07$Sub_metering_2,col = "red")
      lines(powerFeb07$Date_Time,powerFeb07$Sub_metering_3, col = "blue")
      legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1)
      
      

      dev.off()