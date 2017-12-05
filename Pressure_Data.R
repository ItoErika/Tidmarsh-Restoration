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
NOAA_Plymouth_Data[1,"HRS_ELAPSED"]<-NOAA_Plymouth_Data[1,"TIME_DEC"]          
# Write a for loop to make a vector of 
for (i in 1:length(DiffTimes)){
        NOAA_Plymouth_Data[i+1,"HRS_ELAPSED"]<-NOAA_Plymouth_Data[1,"HRS_ELAPSED"]+sum(DiffTimes[1:i])
        }
              
# Add a column for the number of days elapsed
NOAA_Plymouth_Data[,"DAYS_ELAPSED"]<-NOAA_Plymouth_Data[,"HRS_ELAPSED"]/24
# Add a column for a day assignment for each row
NOAA_Plymouth_Data[,"DAY"]<-# Add a column for a day assignment for each row
NOAA_Plymouth_Data[,"DAY"]<-floor(NOAA_Plymouth_Data[,"DAYS_ELAPSED"])
# Add a column for a date assignment for each row
NOAA_Plymouth_Data[,"DATE"]<-dates            
             
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

FinalList<-vector("list")
for (i in 1:(nrow(NOAA_Plymouth_Data)-1)){
    # Use an if statement to make sure there is a multiple of .25 in between the time sums
    if(any(is.whole(round(seq(NOAA_Plymouth_Data[i,"HRS_ELAPSED"],NOAA_Plymouth_Data[i+1,"HRS_ELAPSED"],.01), 2)/.25))){
    QuarterHrs<- seq(round_any(NOAA_Plymouth_Data[i,"HRS_ELAPSED"],.25, ceiling),round_any(NOAA_Plymouth_Data[i+1,"HRS_ELAPSED"], .25, floor), .25)                       
    }
    x<-c(NOAA_Plymouth_Data[i,"HRS_ELAPSED"],NOAA_Plymouth_Data[i+1,"HRS_ELAPSED"])        
    y<-c(NOAA_Plymouth_Data[i,"STP_interp"],NOAA_Plymouth_Data[i+1,"STP_interp"])
    temp<-approx(x,y,xout=QuarterHrs)
    FinalList[[i]]<-rbind(c(NOAA_Plymouth_Data[i,"HRS_ELAPSED"], NOAA_Plymouth_Data[i,"STP_interp"]),cbind(temp$x, temp$y))
    }
              
# Bind the list into a single matrix of STP values
time_col<-unlist(sapply(FinalList, function(x) x[,1])) 
STP_col<-unlist(sapply(FinalList, function(x) x[,2]))         
NOAA_STP<-cbind(time_col, STP_col)                        
              
# Remove rows with NA from FinalList
NOAA_STP<-NOAA_STP[which(!(is.na(NOAA_STP[,2]))),] 
# Remove duplicate rows            
NOAA_STP<-NOAA_STP[-which(duplicated(NOAA_STP[,1])&duplicated(NOAA_STP[,2])),]                       

# Add a column for the day in NOAA_STP
NOAA_STP<-cbind(NOAA_STP, floor(NOAA_STP[,"time_col"]/24))
# Create a key to merge the correct date into the NOAA_STP matrix                       
DateKey<-unique(NOAA_Plymouth_Data[,c("DAY","DATE")])
# Assign colnames to NOAA_STP for merge 
colnames(NOAA_STP)<-c("HRS_ELAPSED","STP","DAY")                       
NOAA_STP<-merge(NOAA_STP, DateKey, by="DAY")              
              
# Convert elapsed time back to time
NOAA_STP[,"DEC_TIME"]<-NOAA_STP[,"HRS_ELAPSED"]-24*floor(NOAA_STP[,"HRS_ELAPSED"]/24)             
# Extract only hours
hours<-floor(NOAA_STP[,"DEC_TIME"])                       
# Extract only minutes
minutes<-round((NOAA_STP[,"DEC_TIME"]-floor(NOAA_STP[,"DEC_TIME"]))*60)
minutes[which(nchar(minutes)==1)]<-paste(0, minutes[which(nchar(minutes)==1)], sep="")                  
# Paste hours and minutes together
times<-paste(hours, minutes, sep=":")                      
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
NOAA_STP[,"DATE_TIME"]<-paste(NOAA_STP[,"DATE"], times, sep=" ") 
                       
# Change date time column from logger files to characters
TE_PZ_AWC1[,"Date.Time..GMT.04.00"]<-as.character(TE_PZ_AWC1[,"Date.Time..GMT.04.00"]) 
# Add a column to sort the data back to original order                       
TE_PZ_AWC1[,"sort"]<-1:nrow(TE_PZ_AWC1)                      
TE_PZ_AWC1<-merge(TE_PZ_AWC1, NOAA_STP[,c("STP","DATE_TIME")], by.x="Date.Time..GMT.04.00", by.y="DATE_TIME", sort="sort", all.x=TRUE)              

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

