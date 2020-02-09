Sys.setenv("http_proxy" = "http://www-proxy.ivi.admin.ch:8080") 

Sys.setenv("https_proxy" = "http://www-proxy.ivi.admin.ch:8080")#proxy to circumvent the BIT for HTTPS

powerconsumption<-read.delim("household_power_consumption.txt",sep = ";",na.strings = "?")
library(dplyr)
library(lubridate)
library(tidyverse)
powerconsumption$Date<- as.character(powerconsumption$Date)
powerconsumption$Date<-dmy(powerconsumption$Date)
periodofinterest<-interval(ymd("2007-02-01"),ymd("2007-02-02"))
powerconsumption2007<- powerconsumption%>% 
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))%>%
  mutate(completedate=ymd_hms(paste(Date,Time,sep = " ")))%>%
  pivot_longer(cols=c(Sub_metering_1,Sub_metering_2,Sub_metering_3),
               values_to = "sub_metering")
png(filename = "plot4.png",height = 480,width = 480)
par(mfrow=c(2,2))
with(powerconsumption2007, plot(Global_active_power~completedate,type="l",
                                ylab = "Global active power",xlab=NA))
with(powerconsumption2007, plot(Voltage ~completedate,type="l",
                                ylab = "Volatage",xlab="datetime"))



with(subset(powerconsumption2007,name=="Sub_metering_1"),
     plot(sub_metering ~completedate,
          col=c("black"),type="l",
          ylab = "Energy sub metering",xlab=NA))
with(subset(powerconsumption2007,name=="Sub_metering_2"),
     points(sub_metering ~completedate,
            col=c("red"),type="l",
            ylab = "Energy sub metering",xlab=NA))
with(subset(powerconsumption2007,name=="Sub_metering_3"),
     points(sub_metering ~completedate,
            col=c("blue"),type="l",
            ylab = "Energy sub metering",xlab=NA))
legend("topright",
       col=c("black","red","blue"),lty=c(1,1,1),bty="n",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with(powerconsumption2007, plot(Global_reactive_power~completedate,type="l",xlab="datetime"))
dev.off()

