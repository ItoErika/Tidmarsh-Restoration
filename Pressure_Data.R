# Load packages
library('plyr')
library('rnoaa')
ncdc_stations(datasetid='GHCND', stationid='GHCND:USW00054769', token="fvDqAprtAssGRLiLzWpbBfBewLSytetM")

# Information for the Plymouth station: https://www.ncdc.noaa.gov/homr/#ncdcstnid=20009418&tab=MSHR
# Load Raw Data
PressureData_AWC1<-read.csv("file:///F:/Tidmarsh_for Erika/Hydro_pressure/Tidmarsh_TW_WL_2017_10_22/TE_PZ_AWC1.csv", skip=1, row.names=1)


#ncdc_stations(datasetid='GHCND', locationid='FIPS:12017', stationid='GHCND:USC00084289', token="fvDqAprtAssGRLiLzWpbBfBewLSytetM")

# Load data from Plymouth Municipal Airport from NOAA
NOAA_Plymouth_Data<-read.table("file:///C:/Users/erikai94/Desktop/NOAA/3974717470584dat.txt", fill=TRUE, header=TRUE)
# Subset the data to only include the Plymouth station (remove Taunton)
NOAA_Plymouth_Data<-subset(NOAA_Plymouth_Data, NOAA_Plymouth_Data[,"USAF"]==725064, select=c(USAF,WBAN,YR..MODAHRMN,SKC,TEMP,DEWP,SLP,ALT,STP,MAX,MIN,PCP01,PCP06,PCP24,PCPXX,SD))

# Reformat NOAA dates and times and round times to the nearest quarter hour
dates<-sapply(NOAA_Plymouth_Data[,"YR..MODAHRMN"], function(x) paste(substr(x,5:6, 6),substr(x,7:8, 8),substr(x,3:4, 4), sep="/"))
times<-sapply(NOAA_Plymouth_Data[,"YR..MODAHRMN"], function (x) paste(substr(x,9:10, 10), round(as.numeric(as.character((substr(x,11:12, 12))))/15)*15, sep=":"))
# Fix formatting error caused by rounding
times<-sapply(times, function(x) gsub(":0", ":00",x,  fixed=TRUE))
# Convert hours into non-military time
hours<-sub(":.*", "", times)
PM<-which(as.numeric(as.character(hours))>=12&as.numeric(as.character(hours))!=24)
AM<-which(as.numeric(as.character(hours))<12|as.numeric(as.character(hours))==24)              
Military<-which(as.numeric(as.character(hours))>12)              
hours<-as.numeric(as.character(hours[Military]))-12
# convert hours to character vector so it is easier to paste
hours<-as.character(hours)
# Paste a zero in front of single digit hours|
hours[which(nchar(hours)==1)]<-paste("0",hours[which(nchar(hours)==1)], sep="")
# Paste a colon after the hour digits
hrs<-paste(hours, ":", sep="")  
mins<-sub(".*:", "", times[Military])
MTimes<-paste(hrs, mins, sep="")
# Replace military times with updated times
times[Military]<-MTimes 
# add :00 at the end of all times for seconds
times<-paste(times, ":00", sep="")              
# Add AM or PM tags
times[AM]<-paste(times[AM], "AM")
times[PM]<-paste(times[PM], "PM")              
# Paste dates and times together as new column in NOAA data
NOAA_Plymouth_Data[,"Date_Time"]<-paste(dates, times, sep=" ")            

PressureData_AWC1<-merge(PressureData_AWC1, NOAA_Plymouth_Data[,c("TEMP","DEWP","SLP","ALT","STP","Date_Time")], by.x="Date.Time..GMT.04.00", by.y="Date_Time", all.x=TRUE)
              
# Add linearly interpolated values between probe measurement data for distance up to 8100 cm:
# Identify which rows have data
Measured<-which(!(is.na((PressureData_AWC1[,"STP"]))))
# Identify clusters of blanks
# Take difference of each measured element and element ahead
# Can identify the start of data gaps as places where the next measured point is more than one element away
# LastMeasured represent the last element before a patch of missing data
LastMeasured<-Measured[which(diff(Measured)>1)]
# FirstMeasured represent the first element after patch of missing data
# This is the element in Measured AFTER the elements where the next data point are more than one element away
FirstMeasured<-Measured[which(diff(Measured)>1)+1]
                
# Write a for loop that linearly interpolates values in these blank clusters 
# Note that there are 36 clusters of blanks (length(FirstMeasured) = length(LastMeasured) = 36)
# Create a column in MoistureData for interpolated values
PressureData_AWC1[,"STP_interp"]<-PressureData_AWC1[,"STP"]       
              
for (i in 1:1170){
    PressureData_AWC1[LastMeasured[i]:FirstMeasured[i],"STP_interp"]<-seq(PressureData_AWC1[LastMeasured[i],"STP_interp"], PressureData_AWC1[FirstMeasured[i],"STP_interp"],length=length(LastMeasured[i]:FirstMeasured[i]))
 } 

# Convert mb to Pa              
PressureData_AWC1[,"STP_interp"]<-PressureData_AWC1[,"STP_interp"]*100 
# Create a column for m of water above each logger             
PressureData_AWC1[,"m_water"]<-(PressureData_AWC1[,"Abs.Pres..Pa..LGR.S.N..10499236..SEN.S.N..10499236."]-PressureData_AWC1[,"STP_interp"])/(9.81*1000)              
              

              
 PressureData_AWC1[,"STP_interp"]<-as.numeric(paste(PressureData_AWC1[,"STP"]))             
 
              test<-paste(dates, times, sep=" ")

