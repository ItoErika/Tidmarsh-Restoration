# Load required libraries
library('R.matlab')
library('matlab')
library('ggplot2')
library('graphics')

# Load DTS data
TW_10<-readMat('file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/TW_DTS_Soil/TW_10cm.mat')
TW_20<-readMat('file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/TW_DTS_Soil/TW_20cm.mat')
TW_30<-readMat('file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/TW_DTS_Soil/TW_30cm.mat')

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
half10<-length(which(Dist10>=0))/2+length(which(Dist10<0))
Temp10half<-Temp10[1:half10,]
Dist10half<-Dist10[1:half10]

half20<-length(which(Dist20>=0))/2+length(which(Dist20<0))
Temp20half<-Temp20[1:half20,]
Dist20half<-Dist20[1:half20]

half30<-length(which(Dist30>=0))/2+length(which(Dist30<0))
Temp30half<-Temp30[1:half30,]
Dist30half<-Dist30[1:half30]

# Coldest time of the day (3AM)
datetext10[55]
#[1] "2018-01-07 02:48:55 UTC"
Coldest10Jan<-Temp10half[,55]
# Warmest time of the day (3PM)
datetext10[67]
#[1] "2018-01-07 14:49:19 UTC"
Warmest10Jan<-Temp10half[,67]

pdf("
plot(Dist10half,Coldest10Jan,type="l", lwd=2, col="blue", xlab='Distance (m)', ylab='Temperature (C)')
lines(Dist10half,Warmest10Jan,col="red", lwd=2)
legend(598,-12, c("01/07/18 2:49 AM", "01/07/18 2:49 PM"), ,col=c("blue","red"), lty=c(1,1), lwd=c(2.5,2.5))

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
