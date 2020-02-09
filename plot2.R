
powerconsumption<-read.delim("household_power_consumption.txt",sep = ";",na.strings = "?")
library(dplyr)
library(tidyverse)
library(lubridate)
powerconsumption$Date<- as.character(powerconsumption$Date)
powerconsumption$Date<-dmy(powerconsumption$Date)
periodofinterest<-interval(ymd("2007-02-01"),ymd("2007-02-02"))
powerconsumption2007<- powerconsumption%>% 
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))%>%
  mutate(completedate=ymd_hms(paste(Date,Time,sep = " ")))
png(filename = "plot2.png",height = 480,width = 480)
with(powerconsumption2007, plot(Global_active_power~completedate,type="l",
                                ylab = "Global active power (kilowatts)",xlab=NA))
dev.off()
