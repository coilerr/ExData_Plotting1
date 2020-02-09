Sys.setenv("http_proxy" = "http://www-proxy.ivi.admin.ch:8080") 

Sys.setenv("https_proxy" = "http://www-proxy.ivi.admin.ch:8080")#proxy to circumvent the BIT for HTTPS

powerconsumption<-read.delim("household_power_consumption.txt",sep = ";",na.strings = "?")
library(dplyr)
library(lubridate)
powerconsumption$Date<- as.character(powerconsumption$Date)
powerconsumption$Date<-dmy(powerconsumption$Date)
periodofinterest<-interval(ymd("2007-01-02"),ymd("2007-02-02"))
powerconsumption2007<- powerconsumption%>% 
  filter(Date >= as.Date("2007-01-02") & Date <= as.Date("2007-02-02"))
