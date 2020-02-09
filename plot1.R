powerconsumption<-read.delim("household_power_consumption.txt",sep = ";",na.strings = "?")
library(dplyr)
library(tidyverse)
library(lubridate)
powerconsumption$Date<- as.character(powerconsumption$Date)
powerconsumption$Date<-dmy(powerconsumption$Date)
periodofinterest<-interval(ymd("2007-02-01"),ymd("2007-02-02"))
powerconsumption2007<- powerconsumption%>% 
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
png(filename = "plot1.png",height = 480,width = 480)
with(powerconsumption2007,
     hist(Global_active_power,
                               col = "red",
          main = "Global Active Power",xlab = "Global Active Power (kilowatts)"))
dev.off()
