##################################################### LOAD LIBRARIES ##################################################################
# Load packages
library('gmp')
library('plyr')
library('rnoaa')

####################################################### LOAD DATA ####################################################################

# Load Raw Data
TE_PZ_AWC1<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TE_PZ_AWC1.csv", skip=1, row.names=1)
TW_PZ_01<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_PZ_01.csv", skip=1, row.names=1)
TW_PZ_02<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_PZ_02.csv", skip=1, row.names=1)
TW_PZ_03<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_PZ_03.csv", skip=1, row.names=1)
TW_PZ_04<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_PZ_04.csv", skip=1, row.names=1)
TW_PZ_05<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_PZ_05.csv", skip=1, row.names=1)
TW_PZ_06<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_PZ_06.csv", skip=1, row.names=1)
TW_PZ_07<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_PZ_07.csv", skip=1, row.names=1)
TW_PZ_08<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_PZ_08.csv", skip=1, row.names=1)
TW_PZ_09<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_PZ_09.csv", skip=1, row.names=1)
TW_SW_02<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_SW_02.csv", skip=1, row.names=1)
TW_SW_03<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_SW_03.csv", skip=1, row.names=1)
TW_SW_04<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_SW_04.csv", skip=1, row.names=1)
TW_SW_07<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_SW_07.csv", skip=1, row.names=1)
TW_WARM<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_WARM.csv", skip=1, row.names=1)
TW_ICE<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_10_22/TW_ICE.csv", skip=1, row.names=1)

# Information for the Plymouth station: https://www.ncdc.noaa.gov/homr/#ncdcstnid=20009418&tab=MSHR
#ncdc_stations(datasetid='GHCND', locationid='FIPS:12017', stationid='GHCND:USC00084289', token="fvDqAprtAssGRLiLzWpbBfBewLSytetM")
#ncdc_stations(datasetid='GHCND', stationid='GHCND:USW00054769', token="fvDqAprtAssGRLiLzWpbBfBewLSytetM")

# Load data from Plymouth Municipal Airport from NOAA
NOAA_Plymouth_Data<-read.table("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/NOAA/3974717470584dat.txt", fill=TRUE, header=TRUE)
# Subset the data to only include the Plymouth station (remove Taunton)
NOAA_Plymouth_Data<-subset(NOAA_Plymouth_Data, NOAA_Plymouth_Data[,"USAF"]==725064, select=c(USAF,WBAN,YR..MODAHRMN,SKC,TEMP,DEWP,SLP,ALT,STP,MAX,MIN,PCP01,PCP06,PCP24,PCPXX,SD))

####################################################### REFORMAT DATA ####################################################################

# Reformat NOAA dates and times
dates<-sapply(NOAA_Plymouth_Data[,"YR..MODAHRMN"], function(x) paste(substr(x,5:6, 6),substr(x,7:8, 8),substr(x,3:4, 4), sep="/"))
times<-sapply(NOAA_Plymouth_Data[,"YR..MODAHRMN"], function (x) paste(substr(x,9:10, 10), (substr(x,11:12, 12)), sep=":"))
#times<-sapply(NOAA_Plymouth_Data[,"YR..MODAHRMN"], function (x) paste(substr(x,9:10, 10), round(as.numeric(as.character((substr(x,11:12, 12))))/15)*15, sep=":"))

# Add a column for exact times in decimal form
dec_times<-sapply(strsplit(times,":"),
        function(x) {
            x <- as.numeric(x)
            x[1]+x[2]/60
            }
)
# Create a column of the times as decimals
NOAA_Plymouth_Data[,"TIME_DEC"]<-dec_times    
              
# Create a column for the sum of hours that have passed since the start of the dataset  
# Create a vector for the differences between times (in decimal form) in the rows              
DiffTimes<-diff(NOAA_Plymouth_Data[,"TIME_DEC"]) 
# Correct for when time jumps crosses the 24 to 0 boundary           
DiffTimes[which(DiffTimes<0)]<-DiffTimes[which(DiffTimes<0)]+24
# Create a column in NOAA data table for the sum of time that has passed (starting with 0 at beginng of dataset)   
NOAA_Plymouth_Data[1,"TIME_SUM"]<-NOAA_Plymouth_Data[1,"TIME_DEC"]          
# Write a for loop to make a vector of 
for (i in 1:length(DiffTimes)){
        NOAA_Plymouth_Data[i+1,"TIME_SUM"]<-NOAA_Plymouth_Data[1,"TIME_SUM"]+sum(DiffTimes[1:i])
        }
             
# Change pressure column to numeric values
 NOAA_Plymouth_Data[,"STP"]<-as.numeric(as.character(NOAA_Plymouth_Data[,"STP"]))
# Add interpolated station pressure values where they are missing
# Identify which rows have data
Measured<-which(!(is.na((NOAA_Plymouth_Data[,"STP"]))))
# LastMeasured represent the last element before a patch of missing data
LastMeasured<-Measured[which(diff(Measured)>1)]
# FirstMeasured represent the first element after patch of missing data
# This is the element in Measured AFTER the elements where the next data point are more than one element away
FirstMeasured<-Measured[which(diff(Measured)>1)+1]                
# Note that there are 75 blanks (length(FirstMeasured) = length(LastMeasured) = 75)
# Create a column for interpolated values
NOAA_Plymouth_Data[,"STP_interp"]<-NOAA_Plymouth_Data[,"STP"]       
# Write a for loop that linearly interpolates values between missing data points 
for (i in 1:75){
    NOAA_Plymouth_Data[LastMeasured[i]:FirstMeasured[i],"STP_interp"]<-seq(NOAA_Plymouth_Data[LastMeasured[i],"STP_interp"], NOAA_Plymouth_Data[FirstMeasured[i],"STP_interp"],length=length(LastMeasured[i]:FirstMeasured[i]))
 } 

temp2<-0
for (i in 1:(nrow(NOAA_Plymouth_Data)-1)){
    # Use an if statement to make sure there is a multiple of .25 in between the time sums
    if(any(is.whole(round(seq(NOAA_Plymouth_Data[i,"TIME_SUM"],NOAA_Plymouth_Data[i+1,"TIME_SUM"],.01), 2)/.25))&  round_any(NOAA_Plymouth_Data[i,"TIME_SUM"],.25, ceiling)<round_any(NOAA_Plymouth_Data[i+1,"TIME_SUM"],.25, floor)){
    QuarterHrs<- seq(round_any(NOAA_Plymouth_Data[i,"TIME_SUM"],.25, ceiling),round_any(NOAA_Plymouth_Data[i+1,"TIME_SUM"], .25, floor), .25)                       
    }
    x<-c(NOAA_Plymouth_Data[i,"TIME_SUM"],NOAA_Plymouth_Data[i+1,"TIME_SUM"])        
    y<-c(NOAA_Plymouth_Data[i,"STP_interp"],NOAA_Plymouth_Data[i+1,"STP_interp"])
    temp<-approx(x,y,xout=QuarterHrs)
    temp2<-rbind(temp2, cbind(i,temp$x, temp$y))
    }
              
            
STP_interp<-seq(round_any(NOAA_Plymouth_Data[1,"TIME_DEC"],.25, ceiling),round_any(NOAA_Plymouth_Data[2,"TIME_DEC"], .25, floor), .25)                           
y<-c(NOAA_Plymouth_Data[1,"STP"],NOAA_Plymouth_Data[2,"STP"])
x<-c(NOAA_Plymouth_Data[1,"TIME_DEC"],NOAA_Plymouth_Data[2,"TIME_DEC"])     
app<-approx(x,y,xout=test)   
              

   
              
              
              
              
   
              
              
              
              
              
              

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
              
# Identify which rows have data
Measured<-which(!(is.na((PressureData_AWC1[,"STP"]))))
# LastMeasured represent the last element before a patch of missing data
LastMeasured<-Measured[which(diff(Measured)>1)]
# FirstMeasured represent the first element after patch of missing data
# This is the element in Measured AFTER the elements where the next data point are more than one element away
FirstMeasured<-Measured[which(diff(Measured)>1)+1]
                
# Note that there are 36 clusters of blanks (length(FirstMeasured) = length(LastMeasured) = 36)
# Create a column for interpolated values
PressureData_AWC1[,"STP_interp"]<-PressureData_AWC1[,"STP"]       
# Write a for loop that linearly interpolates values between missing data points 
for (i in 1:1170){
    PressureData_AWC1[LastMeasured[i]:FirstMeasured[i],"STP_interp"]<-seq(PressureData_AWC1[LastMeasured[i],"STP_interp"], PressureData_AWC1[FirstMeasured[i],"STP_interp"],length=length(LastMeasured[i]:FirstMeasured[i]))
 } 

# Convert mb to Pa              
PressureData_AWC1[,"STP_interp"]<-PressureData_AWC1[,"STP_interp"]*100 
# Create a column for m of water above each logger             
PressureData_AWC1[,"m_water"]<-(PressureData_AWC1[,"Abs.Pres..Pa..LGR.S.N..10499236..SEN.S.N..10499236."]-PressureData_AWC1[,"STP_interp"])/(9.81*1000)              
              

              
 PressureData_AWC1[,"STP_interp"]<-as.numeric(paste(PressureData_AWC1[,"STP"]))             
 
              test<-paste(dates, times, sep=" ")

