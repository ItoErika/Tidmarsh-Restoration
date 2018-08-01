############################################# Load required libraries ################################################################
library('R.matlab')
library('matlab')
library('ggplot2')
library('graphics')

#################################################### Load DTS data ###################################################################

#TW_10<-readMat('file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/TW_DTS_Soil/TW_10cm.mat')
#TW_20<-readMat('file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/TW_DTS_Soil/TW_20cm.mat')
#TW_30<-readMat('file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/TW_DTS_Soil/TW_30cm.mat')

# JANUARY DATA
#TW_10<-readMat('file:///C:/Users/erikai94/Documents/TIDMARSH/TW_2018_01_05_to_15/TW_10cm.mat')
#TW_20<-readMat('file:///C:/Users/erikai94/Documents/TIDMARSH/TW_2018_01_05_to_15/TW_20cm.mat')
#TW_30<-readMat('file:///C:/Users/erikai94/Documents/TIDMARSH/TW_2018_01_05_to_15/TW_30cm.mat')

# SEPTEMBER DATA
TW_10<-readMat('file:///C:/Users/erikai94/Documents/TIDMARSH/TW_2017_09_19_to_29/TW_10cm.mat')
TW_20<-readMat('file:///C:/Users/erikai94/Documents/TIDMARSH/TW_2017_09_19_to_29/TW_20cm.mat')
TW_30<-readMat('file:///C:/Users/erikai94/Documents/TIDMARSH/TW_2017_09_19_to_29/TW_30cm.mat')

#################################################### Organize / manipulate data ######################################################

# Extract temperatures
Temp10<-TW_10$tempC
Temp20<-TW_20$tempC
Temp30<-TW_30$tempC

# Extract distances
Dist10<-TW_10$distance
Dist20<-TW_20$distance
Dist30<-TW_30$distance

# Extract datetime in matlab datenum form
datetime10<-TW_10$datetime
datetime20<-TW_20$datetime
datetime30<-TW_30$datetime

# Equivalent of datestr in Matlab (convert from datenum)
datetext10<-as.POSIXct((datetime10[1,] - 719529)*86400, origin = "1970-01-01", tz = "UTC")
datetext20<-as.POSIXct((datetime20[1,] - 719529)*86400, origin = "1970-01-01", tz = "UTC")
datetext30<-as.POSIXct((datetime30[1,] - 719529)*86400, origin = "1970-01-01", tz = "UTC")

# Convert from GMT to EST (subtact 4 hours)
datetext10<-datetext10-3600*4
datetext20<-datetext20-3600*4
datetext30<-datetext30-3600*4

# Remove the mirrored portion of the data
# Note: the negative distances are NOT mirrored in the data, so you cannot split the data evenly in half
# 10 cm
half10<-length(which(Dist10>=0))/2+length(which(Dist10<0))
Temp10half<-Temp10[1:half10,]
Dist10half<-Dist10[1:half10]
# 20 cm
half20<-length(which(Dist20>=0))/2+length(which(Dist20<0))
Temp20half<-Temp20[1:half20,]
Dist20half<-Dist20[1:half20]
# 30 cm
half30<-length(which(Dist30>=0))/2+length(which(Dist30<0))
Temp30half<-Temp30[1:half30,]
Dist30half<-Dist30[1:half30]

################################################# Coldest/Warmest times JANUARY 7TH ###############################################
# 10 cm
# Coldest time of the day (3AM)
datetext10[55]
# "2018-01-07 02:48:55 UTC"
Coldest10Jan<-Temp10half[,55]
# Warmest time of the day (3PM)
datetext10[67]
# "2018-01-07 14:49:19 UTC"
Warmest10Jan<-Temp10half[,67]

# 20 cm
# Coldest time of the day (3AM)
datetext20[55]
# "2018-01-07 02:53:57 UTC"
Coldest20Jan<-Temp20half[,55]
# Warmest time of the day (3PM)
datetext20[67]
# "2018-01-07 14:54:21 UTC"
Warmest20Jan<-Temp20half[,67]

# 30 cm
# Coldest time of the day (3AM)
datetext30[55]
# "2018-01-07 02:58:58 UTC"
Coldest30Jan<-Temp30half[,55]
# Warmest time of the day (3PM)
datetext30[67]
# "2018-01-07 14:59:22 UTC"
Warmest30Jan<-Temp30half[,67]

################################################# Coldest/Warmest times JANUARY 13TH ###############################################

# 10 cm
# Coldest time of the day (3AM) JANUARY 13TH
datetext10[199]
# "2018-01-13 02:53:35 UTC"
Coldest10Jan_2<-Temp10half[,199]
# Warmest time of the day (3PM)
datetext10[211]
# "2018-01-13 14:53:59 UTC"
Warmest10Jan_2<-Temp10half[,211]

# 20 cm
# Coldest time of the day (3AM) JANUARY 13TH
datetext20[199]
#"2018-01-13 02:58:37 UTC"
Coldest20Jan_2<-Temp20half[,199]
# Warmest time of the day (3PM)
datetext20[211]
#"2018-01-13 14:59:00 UTC"
Warmest20Jan_2<-Temp20half[,211]

# 30 cm
# Coldest time of the day (3AM) JANUARY 13TH
datetext30[199]
# "2018-01-13 03:03:38 UTC"
Coldest30Jan_2<-Temp30half[,199]
# Warmest time of the day (3PM)
datetext30[211]
# "2018-01-13 15:04:00 UTC"
Warmest30Jan_2<-Temp30half[,211]

################################################# Coldest/Warmest times SEPTEMBER 28TH ###############################################

# 10 cm
# Coldest time of the day (3AM) SEPTEMBER 28TH
datetext10[210]
# "2017-09-28 03:20:06 UTC"
Coldest10Sept<-Temp10half[,210]
# Warmest time of the day (3PM)
datetext10[222]
# "2017-09-28 15:20:30 UTC"
Warmest10Sept<-Temp10half[,222]

# 20 cm
# Coldest time of the day (3AM) SEPTEMBER 28TH
datetext20[210]
# "2017-09-28 03:25:07 UTC"
Coldest20Sept<-Temp20half[,210]
# Warmest time of the day (3PM)
datetext20[222]
# "2017-09-28 15:25:31 UTC"
Warmest20Sept<-Temp20half[,222]

# 30 cm
# Coldest time of the day (3AM) SEPTEMBER 28TH
datetext30[210]
# "2017-09-28 03:30:07 UTC"
Coldest30Sept<-Temp30half[,210]
# Warmest time of the day (3PM)
datetext30[222]
# "2017-09-28 15:25:31 UTC"
Warmest30Sept<-Temp30half[,222]

# Plotting to locate the coil under the main ditch

# Enter Channel
plot(Dist10[3110:3250], Warmest10Sept[3110:3250], main='Coil Under Channel 9/28/18 3:20 PM', type='l', col='red', lwd='2', ylab='Temperature (C)', xlab='Distance (m)', xlim=c(742,750), ylim=c(13,15)) 
lines(Dist20[3110:3250], Warmest20Sept[3110:3250], lwd=2, col='green')
lines(Dist30[3110:3250], Warmest30Sept[3110:3250], col='blue', lwd=2)
legend(764,27, c("10 cm", "20 cm", "30 cm"), col=c("red","green", "blue"), lty=c(1,1), lwd=c(2.5,2.5))
# Exit Channel
plot(Dist10[3110:3250], Warmest10Sept[3110:3250], main='Coil Under Channel 9/28/18 3:20 PM', type='l', col='red', lwd='2', ylab='Temperature (C)', xlab='Distance (m)', xlim=c(762,769), ylim=c(13,15)) 
lines(Dist20[3110:3250], Warmest20Sept[3110:3250], lwd=2, col='green')
lines(Dist30[3110:3250], Warmest30Sept[3110:3250], col='blue', lwd=2)
legend(764,27, c("10 cm", "20 cm", "30 cm"), col=c("red","green", "blue"), lty=c(1,1), lwd=c(2.5,2.5))

plot(Dist10half, Warmest10Sept, main='9/28 3:20 PM', type='l', col='red', lwd='2', ylab='Temperature (C)', xlab='Distance (m)') 
lines(Dist20half, Warmest20Sept, lwd=2, col='green')
lines(Dist30half, Warmest30Sept, col='blue', lwd=2)
legend(764,27, c("10 cm", "20 cm", "30 cm"), col=c("red","green", "blue"), lty=c(1,1), lwd=c(2.5,2.5))


################################################# MAKE PLOTS ###############################################

# Set working directory to save plots to 
setwd('C:/Users/erikai94/Documents/UMass/Tidmarsh/R_Plots')


# JANUARY 7TH
# 10 cm
pdf("Jan_10_WarmCold.pdf", width=15, height=7)
plot(Dist10half,Coldest10Jan,type="l", lwd=2, col="blue", main='10 cm Cable 01/07/18', xlab='Distance (m)', ylab='Temperature (C)')
lines(Dist10half,Warmest10Jan,col="red", lwd=2)
legend(840,5.5, c("2:49 AM", "2:49 PM"), ,col=c("blue","red"), lty=c(1,1), lwd=c(2.5,2.5))
dev.off()
# 20 cm
pdf("Jan_20_WarmCold.pdf", width=15, height=7)
plot(Dist20half,Coldest20Jan,type="l", lwd=2, col="blue", main='20 cm Cable 01/07/18', xlab='Distance (m)', ylab='Temperature (C)')
lines(Dist20half,Warmest20Jan,col="red", lwd=2)
legend(840,5.5, c("2:54 AM", "2:54 PM"), ,col=c("blue","red"), lty=c(1,1), lwd=c(2.5,2.5))
dev.off()
# 30 cm
pdf("Jan_30_WarmCold.pdf", width=15, height=7)
plot(Dist30half,Coldest30Jan,type="l", lwd=2, col="blue", main='30 cm Cable 01/07/18', xlab='Distance (m)', ylab='Temperature (C)')
lines(Dist30half,Warmest30Jan,col="red", lwd=2)
legend(840,5.5, c("2:59 AM", "2:59 PM"), ,col=c("blue","red"), lty=c(1,1), lwd=c(2.5,2.5))
dev.off()

# JANUARY 13TH
# 10 cm
pdf("Jan_10_WarmCold_2.pdf", width=15, height=7)
plot(Dist10half,Coldest10Jan_2,type="l", lwd=2, col="blue", main='10 cm Cable 01/13/18', xlab='Distance (m)', ylab='Temperature (C)')
lines(Dist10half,Warmest10Jan_2,col="red", lwd=2)
legend(840,24, c("2:54 AM", "2:54 PM"), ,col=c("blue","red"), lty=c(1,1), lwd=c(2.5,2.5))
dev.off()
# 20 cm
pdf("Jan_20_WarmCold_2.pdf", width=15, height=7)
plot(Dist20half,Coldest20Jan_2,type="l", lwd=2, col="blue", main='20 cm Cable 01/13/18', xlab='Distance (m)', ylab='Temperature (C)')
lines(Dist20half,Warmest20Jan_2,col="red", lwd=2)
legend(840,24, c("2:59 AM", "2:59 PM"), ,col=c("blue","red"), lty=c(1,1), lwd=c(2.5,2.5))
dev.off()
# 30 cm
pdf("Jan_30_WarmCold_2.pdf", width=15, height=7)
plot(Dist30half,Coldest30Jan_2,type="l", lwd=2, col="blue", main='30 cm Cable 01/13/18', xlab='Distance (m)', ylab='Temperature (C)')
lines(Dist30half,Warmest30Jan_2,col="red", lwd=2)
legend(840,24, c("3:04 AM", "3:04 PM"), ,col=c("blue","red"), lty=c(1,1), lwd=c(2.5,2.5))
dev.off()

# SEPTEMBER 28TH
# 10 cm
pdf("Sept_10_WarmCold.pdf", width=15, height=7)
plot(Dist10half,Coldest10Sept,type="l", lwd=2, col="blue", main='10 cm Cable 09/28/18', xlab='Distance (m)', ylab='Temperature (C)', ylim=c(10,38))
lines(Dist10half,Warmest10Sept,col="red", lwd=2)
legend(840,37, c("3:20 AM", "3:20 PM"), ,col=c("blue","red"), lty=c(1,1), lwd=c(2.5,2.5))
dev.off()

pdf("Sept_20_WarmCold.pdf", width=15, height=7)
plot(Dist20half,Coldest20Sept,type="l", lwd=2, col="blue", main='20 cm Cable 09/28/18', xlab='Distance (m)', ylab='Temperature (C)', ylim=c(10,38))
lines(Dist20half,Warmest20Sept,col="red", lwd=2)
legend(840,37, c("3:25 AM", "3:25 PM"), ,col=c("blue","red"), lty=c(1,1), lwd=c(2.5,2.5))
dev.off()

pdf("Sept_30_WarmCold.pdf", width=15, height=7)
plot(Dist30half,Coldest30Sept,type="l", lwd=2, col="blue", main='30 cm Cable 09/28/18', xlab='Distance (m)', ylab='Temperature (C)', ylim=c(10,38))
lines(Dist30half,Warmest30Sept,col="red", lwd=2)
legend(840,37, c("3:30 AM", "3:30 PM"), ,col=c("blue","red"), lty=c(1,1), lwd=c(2.5,2.5))
dev.off()

################################################# LOCATING BENCHMARK INDICES ###############################################


Marks10<-c(0,14,34,35,58.5,59.75,62,84,99,111.25,136,141,164,169,254,264,349.25,365.25, 399.25, 411.5,525.75, 561, 594, 597.5, 639.25, 645, 733.5, 746, 764, 834, 850.25, 853.5, 859, 862, 866, 882, 910, 918, 940.75, 942.5)
Indices10<-sapply(Marks10, function (x) which.min(abs(Dist10-x)))

Marks20<-c(0, 14.25, 34, 35, 58.5, 59.75, 62, 83.5, 98.5, 110.75, 135.5, 140.5, 165.5, 170.5, 255.5, 265.5, 350.75, 366.75,400.75,412.75,526.75,562.25,595,598.75,640.5,646.25,734,746.5,767.5, 834,853.75,857,862.5,865.5,865.5,881.5,909.5,917.5,936.25,938)
Indices20<-sapply(Marks20, function (x) which.min(abs(Dist20-x)))

Marks30<-c(0, 14, 34, 35, 58.5, 59.75, 62, 85, 99.75, 112.25, 136.75, 141.75, 162.25, 167.25, 254, 264, 348.75, 364.75,398.75,411,524.75,560,593,597,638.5,644.5,732,745,765, 834,851,854.5,860,863,863,879,907,915,936,938.5)
Indices30<-sapply(Marks30, function (x) which.min(abs(Dist30-x)))
                  
                  

tref1_10<-TW_10$tref.1
tref2_10<-TW_10$tref.2
trefint_10<-TW_10$tref.int
datetime_10<-TW_10$datetime

as.POSIXct((datetime_10[1] - 719529)*86400, origin = "1970-01-01", tz = "UTC")

df<-as.data.frame(t(rbind(datetime_10, trefint_10, tref1_10, tref2_10)))
colnames(df)<-c("datetime", "trefint", "tref1", "tref2")

g<-ggplot()+ geom_point(data=df, aes(x=datetime, y=trefint, color='trefint'))+ geom_point(data=df, aes(x=datetime, y=tref1, color='tref1'))+geom_point(data=df, aes(x=datetime, y=tref2, color='tref2'))

ggplot(data = df, aes(x = metrics, y = teams)) +
  geom_tile(aes(fill = performance)) 
plot(Dist_10, Temp_10[,1])



which.min(abs(Dist10-Marks10))


