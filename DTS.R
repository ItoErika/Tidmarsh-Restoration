# Load required libraries
library('R.matlab')
library('matlab')
library('ggplot2')

# Load DTS data
TW_10<-readMat('file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/TW_DTS_Soil/TW_10cm.mat')
TW_20<-readMat('file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/TW_DTS_Soil/TW_20cm.mat')
TW_30<-readMat('file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/TW_DTS_Soil/TW_30cm.mat')

Temp_10<-TW_10$tempC
Temp_20<-TW_20$tempC
Temp_30<-TW_30$tempC

Dist_10<-TW_10$distance
Dist_20<-TW_20$distance
Dist_30<-TW_30$distance

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
