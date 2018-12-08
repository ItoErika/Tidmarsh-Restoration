##################################################### LOAD LIBRARIES ##################################################################
# Load packages
library('gmp')
library('plyr')
library('rnoaa')
library('ggplot2')
library('scales')

####################################################### LOAD DATA ####################################################################

# Load Raw Data:

# For data from 8/17 through 10/17
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

# For data from 8/17 through 11/17
TW_PZ_02<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_11_17/TW_PZ_02_2017_11_17.csv", skip=1, row.names=1)
TW_PZ_03<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_11_17/TW_PZ_03_2017_11_17.csv", skip=1, row.names=1)
TW_PZ_04<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_11_17/TW_PZ_04_2017_11_17.csv", skip=1, row.names=1)
TW_PZ_07<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_11_17/TW_PZ_07_2017_11_17.csv", skip=1, row.names=1)
TW_SW_02<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_11_17/TW_SW_02_2017_11_17.csv", skip=1, row.names=1)
TW_SW_03<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_11_17/TW_SW_03_2017_11_17.csv", skip=1, row.names=1)
TW_SW_04<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_11_17/TW_SW_04_2017_11_17.csv", skip=1, row.names=1)
TW_SW_07<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_11_17/TW_SW_07_2017_11_17.csv", skip=1, row.names=1)

# Latest Batch:
# Load Raw Data:
TW_PZ_02_May<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/2018_05_06/TW_PZ_02.csv", skip=1, row.names=1)
TW_PZ_04_May<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/2018_05_06/TW_PZ_04.csv", skip=1, row.names=1)
TW_PZ_09_May<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/2018_05_06/TW_PZ_09.csv", skip=1, row.names=1)
TW_SW_03_May<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/2018_05_06/TW_SW_03.csv", skip=1, row.names=1)

TW_PZ_01_Mar<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_PZ_01_2018_03_04.csv", skip=1, row.names=1)
TW_PZ_02_Nov<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_PZ_02_2017_11_17.csv", skip=1, row.names=1)
TW_PZ_03_Nov<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_PZ_03_2017_11_17.csv", skip=1, row.names=1)
TW_PZ_03_Mar<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_PZ_03_2018_03_03.csv", skip=1, row.names=1)
TW_PZ_04_Nov<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_PZ_04_2017_11_17.csv", skip=1, row.names=1)
TW_PZ_04_Mar<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_PZ_04_2018_03_03.csv", skip=1, row.names=1)
TW_SW_02_Nov<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_SW_02_2017_11_17.csv", skip=1, row.names=1)
TW_SW_02_Mar<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_SW_02_2018_03_03.csv", skip=1, row.names=1)
TW_SW_03_Nov<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_SW_03_2017_11_17.csv", skip=1, row.names=1)
TW_SW_03_Mar<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_SW_03_2018_03_03.csv", skip=1, row.names=1)
TW_SW_04_Nov<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_SW_04_2017_11_17.csv", skip=1, row.names=1)
TW_SW_04_Mar<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_SW_04_2018_03_03.csv", skip=1, row.names=1)
TW_SW_07_Nov<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_SW_07_2017_11_17.csv", skip=1, row.names=1)
TW_SW_07_Mar<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW_SW_07_2018_03_03.csv", skip=1, row.names=1)
TW_PZ_05_Mar<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW-PZ-05_2018_03_03.csv", skip=1, row.names=1)
TW_PZ_06_Mar<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW-PZ-06_2018_03_04.csv", skip=1, row.names=1)
TW_PZ_07_Nov<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW-PZ-07_2017_11_17.csv", skip=1, row.names=1)
TW_PZ_07_Mar<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW-PZ-07_2018_03_03.csv", skip=1, row.names=1)
TW_PZ_08_Mar<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TW-PZ-08_2018_03_03.csv", skip=1, row.names=1)
TE_PZ_AWC1_Mar<-read.csv("file:///C:/Users/erikai94/Documents/TIDMARSH/Hydro_Pressure/TE_PZ_AWC1_2018_03_04.csv", skip=1, row.names=1)

TW_PZ_01_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-PZ-01_sn10499234_2018_11_20.csv", skip=1, row.names=1)
TW_PZ_02_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW_PZ_02_2018_11_20.csv", skip=1, row.names=1)
TW_PZ_03_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-PZ-03_sn10499228_2018_11_20.csv", skip=1, row.names=1)
TW_PZ_04_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW_PZ_04_2018_11_20.csv", skip=1, row.names=1)
TW_PZ_05_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-PZ-05_2018_11_19.csv", skip=1, row.names=1)
TW_PZ_06_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-PZ-06_sn10499244_2018_11_19.csv", skip=1, row.names=1)
TW_PZ_07_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-PZ-07_sn10499240_2018_11_19.csv", skip=1, row.names=1)
TW_PZ_08_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-PZ-08_sn10499239_2018_11_19.csv", skip=1, row.names=1)
TW_PZ_09_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-PZ-09_2018_11_19.csv", skip=1, row.names=1)
TW_SW_02_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-SW-02_sn10499246_2018_11_20.csv", skip=1, row.names=1)
TW_SW_03_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW_SW_03_2018_11_20.csv", skip=1, row.names=1)
TW_SW_04_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-SW-04_sn10499238_2018_11_20.csv", skip=1, row.names=1)
TW_SW_10_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-SW-10_2018_11_19_sn_10499233.csv", skip=1, row.names=1)
TW_PZ_05_SAND_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-PZ-05-SAND_sn10499236_2018_11_19.csv", skip=1, row.names=1)
TW_PZ_06_SAND_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-PZ-06-SAND_sn10499231_2018_11_19.csv", skip=1, row.names=1)



# Information for the Plymouth station: https://www.ncdc.noaa.gov/homr/#ncdcstnid=20009418&tab=MSHR
#ncdc_stations(datasetid='GHCND', locationid='FIPS:12017', stationid='GHCND:USC00084289', token="fvDqAprtAssGRLiLzWpbBfBewLSytetM")
#ncdc_stations(datasetid='GHCND', stationid='GHCND:USW00054769', token="fvDqAprtAssGRLiLzWpbBfBewLSytetM")

# Load data from Plymouth Municipal Airport from NOAA
# For data from 8/17 through 10/17
NOAA_Plymouth_Data<-read.table("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/NOAA/10_17/3974717470584dat.txt", fill=TRUE, header=TRUE)
# For data from 8/17 through 11/17
NOAA_Plymouth_Data<-read.table("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/NOAA/11_17/5486487547073dat.txt", fill=TRUE, header=TRUE)
NOAA_Plymouth_Data<-read.table("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/NOAA/11_18/4200927813436dat.txt", fill=TRUE, header=TRUE)


# Subset the data to only include the Plymouth station (remove Taunton)
NOAA_Plymouth_Data<-subset(NOAA_Plymouth_Data, NOAA_Plymouth_Data[,"USAF"]==725064, select=c(USAF,WBAN,YR..MODAHRMN,SKC,TEMP,DEWP,SLP,ALT,STP,MAX,MIN,PCP01,PCP06,PCP24,PCPXX,SD))

####################################################### REFORMAT DATA ####################################################################

# If any logger columns need to be re-ordered for later processing
# Re-order TW_PZ_04 columns
#TW_PZ_04_May<-as.data.frame(cbind(as.character(TW_PZ_04_May[,1]),as.numeric(as.character(TW_PZ_04_May[,3])),as.numeric(as.character(TW_PZ_04_May[,2]))),row.names=FALSE)
#colnames(TW_PZ_04_May)<-c("Date.Time..GMT.05.00","Abs.Pres..kPa..LGR.S.N..10499227..SEN.S.N..10499227.","Temp..Â.C..LGR.S.N..10499227..SEN.S.N..10499227.")
#TW_PZ_04_May[,3]<-as.numeric(as.character(TW_PZ_04_May[,3]))
#TW_PZ_04_May[,2]<-as.numeric(as.character(TW_PZ_04_May[,2]))

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
# Create a column in NOAA data table for the sum of time that has passed (starting with 0 at midnight on the first day of dataset)   
NOAA_Plymouth_Data[1,"HRS_ELAPSED"]<-NOAA_Plymouth_Data[1,"TIME_DEC"]          
# Write a for loop to make a vector of 
for (i in 1:length(DiffTimes)){
        NOAA_Plymouth_Data[i+1,"HRS_ELAPSED"]<-NOAA_Plymouth_Data[1,"HRS_ELAPSED"]+sum(DiffTimes[1:i])
        }
              
# Add a column for the number of days elapsed
NOAA_Plymouth_Data[,"DAYS_ELAPSED"]<-NOAA_Plymouth_Data[,"HRS_ELAPSED"]/24
# Add a column for a day assignment for each row
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
for (i in 1:length(FirstMeasured)){
    NOAA_Plymouth_Data[LastMeasured[i]:FirstMeasured[i],"STP_interp"]<-seq(NOAA_Plymouth_Data[LastMeasured[i],"STP_interp"], NOAA_Plymouth_Data[FirstMeasured[i],"STP_interp"],length=length(LastMeasured[i]:FirstMeasured[i]))
 } 

# Use the data to estimate the STP value for every quarter hour              
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
# Remove rows with NA from NOAA_STP
NOAA_STP<-NOAA_STP[which(!(is.na(NOAA_STP[,2]))),] 
# Remove duplicate rows            
NOAA_STP<-NOAA_STP[-which(duplicated(NOAA_STP[,1])&duplicated(NOAA_STP[,2])),]                       

# Create a key to merge the correct date into the NOAA_STP matrix                       
DateKey<-unique(NOAA_Plymouth_Data[,c("DAY","DATE")])                       
# Add a column for the day in NOAA_STP
NOAA_STP<-cbind(NOAA_STP, floor(NOAA_STP[,"time_col"]/24))
# Assign colnames to NOAA_STP for merge 
colnames(NOAA_STP)<-c("HRS_ELAPSED","STP","DAY")                       
NOAA_STP<-merge(NOAA_STP, DateKey, by="DAY")              
              
# Convert elapsed time back to time
NOAA_STP[,"DEC_TIME"]<-NOAA_STP[,"HRS_ELAPSED"]-24*floor(NOAA_STP[,"HRS_ELAPSED"]/24)             
# Extract only hours
hours<-floor(NOAA_STP[,"DEC_TIME"])
# Convert 0s to 24s in hours
hours[which(hours==0)]<-24
# Determine which hours are AM                                              
AM<-which(hours<12|hours==24)                        
# Determine which hours are PM                       
PM<-which(hours>=12&hours!=24)
# Determine which hours are >12                       
Military<-which(hours>12)
# Convert from military to civilian time              
hours[Military]<-hours[Military]-12
# convert hours to character vector so it is easier to paste
hours<-as.character(hours)
# Paste a zero in front of single digit hours
hours[which(nchar(hours)==1)]<-paste("0",hours[which(nchar(hours)==1)], sep="")                       
                       
# Extract only minutes
minutes<-round((NOAA_STP[,"DEC_TIME"]-floor(NOAA_STP[,"DEC_TIME"]))*60)
minutes[which(nchar(minutes)==1)]<-paste(0, minutes[which(nchar(minutes)==1)], sep="")                  
# Paste hours and minutes together
times<-paste(hours, minutes, sep=":")                      
                                            
# add :00 at the end of all times for seconds
times<-paste(times, ":00", sep="") 
                       
# Add AM or PM tags
times[AM]<-paste(times[AM], "AM")
times[PM]<-paste(times[PM], "PM")   
                       
# Paste dates and times together as new column in NOAA data
NOAA_STP[,"DATE_TIME"]<-paste(NOAA_STP[,"DATE"], times, sep=" ") 
                                   
# Write a function to merge STP from NOAA to logger data, and calculate m of water above loggers
loggerProcess<-function(LoggerData) {
        # Change column names for logger files
        colnames(LoggerData)<-c("Date_Time","Abs_Pres_Pa","Temp_C")                
                # Change date time column from logger files to characters
        LoggerData[,"Date_Time"]<-as.character(LoggerData[,"Date_Time"]) 
        # Add a column to sort the data back to original order                       
        LoggerData[,"order"]<-1:nrow(LoggerData)                      
        LoggerData<-merge(LoggerData, NOAA_STP[,c("STP","DATE_TIME")], by.x="Date_Time", by.y="DATE_TIME", all.x=TRUE)
        # re-order matrix
        LoggerData<-LoggerData[order(LoggerData[,"order"]),]                       

        # Add column for water density
        LoggerData[,"water_density"]<-1000*(1-(LoggerData[,"Temp_C"]+2.889414)/(508929.2*(LoggerData[,"Temp_C"]+68.12963))*(LoggerData[,"Temp_C"]-3.9863)^2)      
        # Convert mb to Pa              
        LoggerData[,"STP"]<-LoggerData[,"STP"]*100 
        # Create a column for m of water above each logger             
        LoggerData[,"m_water"]<-(LoggerData[,"Abs_Pres_Pa"]-LoggerData[,"STP"])/(9.81*LoggerData[,"water_density"]) 
        return(LoggerData)
        }                  

# Run this function on the logger file with pressure as Pa                       
TE_PZ_AWC1<-loggerProcess(TE_PZ_AWC1)
                                   
# Write a function to merge STP from NOAA to logger data, and calculate m of water above loggers
loggerProcess<-function(LoggerData) {
        # Change column names for logger files
        colnames(LoggerData)<-c("Date_Time","Abs_Pres_Pa","Temp_C")                
                # Change date time column from logger files to characters
        LoggerData[,"Date_Time"]<-as.character(LoggerData[,"Date_Time"]) 
        # Add a column to sort the data back to original order                       
        LoggerData[,"order"]<-1:nrow(LoggerData)                      
        LoggerData<-merge(LoggerData, NOAA_STP[,c("STP","DATE_TIME")], by.x="Date_Time", by.y="DATE_TIME", all.x=TRUE)
        # re-order matrix
        LoggerData<-LoggerData[order(LoggerData[,"order"]),]                       

        # Add column for water density
        LoggerData[,"water_density"]<-1000*(1-(LoggerData[,"Temp_C"]+2.889414)/(508929.2*(LoggerData[,"Temp_C"]+68.12963))*(LoggerData[,"Temp_C"]-3.9863)^2)      
        # Convert mb to Pa              
        LoggerData[,"STP"]<-LoggerData[,"STP"]*100
        # Convert KPa to Pa
        LoggerData[,"Abs_Pres_Pa"]<-LoggerData[,"Abs_Pres_Pa"]*1000
        # Create a column for m of water above each logger             
        LoggerData[,"m_water"]<-(LoggerData[,"Abs_Pres_Pa"]-LoggerData[,"STP"])/(9.81*LoggerData[,"water_density"])
        return(LoggerData)
        }                            
                       
TW_PZ_01<-loggerProcess(TW_PZ_01)
TW_PZ_02<-loggerProcess(TW_PZ_02)
TW_PZ_03<-loggerProcess(TW_PZ_03)
TW_PZ_04<-loggerProcess(TW_PZ_04)
TW_PZ_05<-loggerProcess(TW_PZ_05)
TW_PZ_06<-loggerProcess(TW_PZ_06)
TW_PZ_07<-loggerProcess(TW_PZ_07)
TW_PZ_08<-loggerProcess(TW_PZ_08)
TW_PZ_09<-loggerProcess(TW_PZ_09)
TW_SW_02<-loggerProcess(TW_SW_02)
TW_SW_03<-loggerProcess(TW_SW_03)
TW_SW_04<-loggerProcess(TW_SW_04)
TW_SW_07<-loggerProcess(TW_SW_07)
#TW_WARM<-loggerProcess(TW_WARM)
#TW_ICE<-loggerProcess(TW_ICE) 

# MAKE PLOTS  (depth to water below GS)

#TW_PZ_02_May
Plot_Times<-as.POSIXct(TW_PZ_02_May[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_May, aes(Plot_Times, 165/100-(19/100+TW_PZ_02_May[,"m_water"])))+geom_point(color='royalblue3', size=.2)+ ylim(0,1) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%d %b")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))  
#TW_PZ_AWC1_Mar
Plot_Times<-as.POSIXct(TW_PZ_AWC1_Mar[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_AWC1_Mar, aes(Plot_Times, 166.5/100-(59.1/100+TE_PZ_AWC1_Mar[,"m_water"])))+geom_point(color='royalblue3', size=.2)+ ylim(0,0.4) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_AWC1")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%d %b")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))          
#TW_PZ_07_Nov
Plot_Times<-as.POSIXct(TW_PZ_07_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_Nov, aes(Plot_Times, 166/100-(28/100+TW_PZ_07_Nov[,"m_water"])))+geom_point(color='royalblue3', size=.2)+ ylim(0.0,0.7) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%d %b")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))  
#TW_PZ_07_Mar
Plot_Times<-as.POSIXct(TW_PZ_07_Mar[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_Mar, aes(Plot_Times, 166/100-(28/100+TW_PZ_07_Mar[,"m_water"])))+geom_point(color='royalblue3', size=.2)+ ylim(0.0,0.3) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%d %b")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                       
#TW_PZ_04_May
Plot_Times<-as.POSIXct(TW_PZ_04_May[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_May, aes(Plot_Times, 165.5/100-(59.5/100+TW_PZ_04_May[,"m_water"])))+geom_point(color='royalblue3', size=.2)+ ylim(-0.5,0.2) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%d %b")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))      
#TW_PZ_04_May ABOVE GROUND SURFACE
Plot_Times<-as.POSIXct(TW_PZ_04_May[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_May, aes(Plot_Times, -165.5/100+(59.5/100+TW_PZ_04_May[,"m_water"])))+geom_point(color='royalblue3', size=.2)+ ylim(-0.2,0.5) + xlab("Date") + ylab("Water Level Above Ground Surface (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%d %b")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                            
#TW_PZ_09_May
Plot_Times<-as.POSIXct(TW_PZ_09_May[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_09_May, aes(Plot_Times, 166/100-(28.4/100+TW_PZ_09_May[,"m_water"])))+geom_point(color='royalblue3', size=.2)+ ylim(0.2,1.2) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_09")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%d %b")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                           

                                          
# MAKE PLOTS  (water column height)                         
Plot_Times<-as.POSIXct(T_PZ_02_May[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TE_PZ_02_May, aes(Plot_Times, TE_PZ_02_May[,"m_water"]))+geom_point(color='royalblue3', size=.2)+ ylim(0.5, 1.4) + xlab("Date") + ylab("Water Column above Logger (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%d %b")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                         
                       
