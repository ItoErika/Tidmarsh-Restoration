##################################################### LOAD LIBRARIES ####################################################################################
# Load packages
library('gmp')
library('plyr')
library('rnoaa')
library('ggplot2')
library('scales')
library('forecast')
library('sf')
library('rdgal')

####################################################### LOAD DATA ######################################################################################

# Load raw data (downloaded from pressure transducers)
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
TW_SW_07_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-SW-07_sn10744415_2018_11_19.csv", skip=1, row.names=1)
TW_SW_10_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-SW-10_2018_11_19_sn_10499233.csv", skip=1, row.names=1)
TW_PZ_05_SAND_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-PZ-05-SAND_sn10499236_2018_11_19.csv", skip=1, row.names=1)
TW_PZ_06_SAND_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-PZ-06-SAND_sn10499231_2018_11_19.csv", skip=1, row.names=1)

# Load data from Plymouth Municipal Airport from NOAA
# This includes barometric pressure data (use to correct logger data) 
NOAA_Plymouth_Data<-read.table("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/NOAA/11_18/4200927813436dat.txt", fill=TRUE, header=TRUE)

####################################################### REFORMAT NOAA DATA ##################################################################################

# Reformat NOAA dates and times
dates<-sapply(NOAA_Plymouth_Data[,"YR..MODAHRMN"], function(x) paste(substr(x,5:6, 6),substr(x,7:8, 8),substr(x,3:4, 4), sep="/"))
times<-sapply(NOAA_Plymouth_Data[,"YR..MODAHRMN"], function (x) paste(substr(x,9:10, 10), (substr(x,11:12, 12)), sep=":"))
#times<-sapply(NOAA_Plymouth_Data[,"YR..MODAHRMN"], function (x) paste(substr(x,9:10, 10), round(as.numeric(as.character((substr(x,11:12, 12))))/15)*15, sep=":"))

# Add a column for exact times in decimal form
dec_times<-sapply(strsplit(times,":"),
        function(x) {
            x <- as.numeric(x)
            x[1]+x[2]/60
            })
              
# Create a column of the times as decimals
NOAA_Plymouth_Data[,"TIME_DEC"]<-dec_times    
              
# Create a column for the sum of hours that have passed since the start of the dataset  
# Create a vector for the differences between times (in decimal form) in the rows              
DiffTimes<-diff(NOAA_Plymouth_Data[,"TIME_DEC"]) 
# Correct for when time jumps crosses the 24 to 0 boundary           
DiffTimes[which(DiffTimes<0)]<-DiffTimes[which(DiffTimes<0)]+24
# Create a column in NOAA data table for the sum of time that has passed (starting with 0 at midnight on the first day of dataset)   
NOAA_Plymouth_Data[1,"HRS_ELAPSED"]<-NOAA_Plymouth_Data[1,"TIME_DEC"]          
# Write a for loop to make a vector of hours elapsed since the beginning of the dataset
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
                                            
# Add :00 at the end of all times for seconds
times<-paste(times, ":00", sep="") 
# Add AM or PM tags
times[AM]<-paste(times[AM], "AM")
times[PM]<-paste(times[PM], "PM")   
                       
# Paste dates and times together as new column in NOAA data
NOAA_STP[,"DATE_TIME"]<-paste(NOAA_STP[,"DATE"], times, sep=" ") 

####################################################### PROCESS LOGGER DATA ##################################################################################
                       
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

# Run this function on the logger file with pressure as kPa                                              
TW_PZ_01_Nov<-loggerProcess(TW_PZ_01_Nov)
TW_PZ_02_Nov<-loggerProcess(TW_PZ_02_Nov)
TW_PZ_03_Nov<-loggerProcess(TW_PZ_03_Nov)
TW_PZ_04_Nov<-loggerProcess(TW_PZ_04_Nov)
TW_PZ_05_Nov<-loggerProcess(TW_PZ_05_Nov)
TW_PZ_06_Nov<-loggerProcess(TW_PZ_06_Nov)
TW_PZ_07_Nov<-loggerProcess(TW_PZ_07_Nov)
TW_PZ_08_Nov<-loggerProcess(TW_PZ_08_Nov)
TW_PZ_09_Nov<-loggerProcess(TW_PZ_09_Nov)
TW_SW_02_Nov<-loggerProcess(TW_SW_02_Nov)
TW_SW_03_Nov<-loggerProcess(TW_SW_03_Nov)
TW_SW_04_Nov<-loggerProcess(TW_SW_04_Nov)
TW_SW_07_Nov<-loggerProcess(TW_SW_07_Nov)
TW_SW_10_Nov<-loggerProcess(TW_SW_10_Nov)
TW_PZ_05_SAND_Nov<-loggerProcess(TW_PZ_05_SAND_Nov)
TW_PZ_06_SAND_Nov<-loggerProcess(TW_PZ_06_SAND_Nov)                      
                       
##################################################### CORRECT BASED ON MANUAL MEASUREMENTS ####################################################################################

############## TW_PZ_01 ##############
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 25.8 cm
TW_PZ_01_Nov[,"m_below_GS"]<-130/100-(25.8/100+TW_PZ_01_Nov[,"m_water"])
# Smooth the spikes in the data caused by logger removal during data downloading
# Interpolate between the 6/19 spike
Start_Spike<-which(TW_PZ_01_Nov[,"Date_Time"]=="06/19/18 01:00:00 PM")                     
Stop_Spike<-which(TW_PZ_01_Nov[,"Date_Time"]=="06/19/18 02:00:00 PM")     
Smoothed_Spike<-seq(TW_PZ_01_Nov[Start_Spike,"m_below_GS"], TW_PZ_01_Nov[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)
# Replace the spike with the smoothed interpolated data
TW_PZ_01_Nov[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike
# Interpolate between the 7/11 spike                       
Start_Spike<-which(TW_PZ_01_Nov[,"Date_Time"]=="07/11/18 08:45:00 AM")
Stop_Spike<-which(TW_PZ_01_Nov[,"Date_Time"]=="07/11/18 09:45:00 AM")     
Smoothed_Spike<-seq(TW_PZ_01_Nov[Start_Spike,"m_below_GS"], TW_PZ_01_Nov[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)
# Replace the spike with the smoothed interpolated data
TW_PZ_01_Nov[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike  
# Remove the first row of the dataset (the logger was not submerged)
TW_PZ_01_Nov<-TW_PZ_01_Nov[-1,]   
TW_PZ_01_Nov[,"lat"]<-41.91347222 
TW_PZ_01_Nov[,"long"]<--70.57844444               
  
############## TW_PZ_05 ##############       
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 25.75 cm
TW_PZ_05_Nov[,"m_below_GS"]<-157/100-(25.75/100+TW_PZ_05_Nov[,"m_water"])             
# Smooth the spikes in the data caused by logger removal during data downloading
# Interpolate between the 7/11 spike
Start_Spike<-which(TW_PZ_05_Nov[,"Date_Time"]=="07/11/18 02:30:00 PM")                     
Stop_Spike<-which(TW_PZ_05_Nov[,"Date_Time"]=="07/11/18 03:00:00 PM")     
Smoothed_Spike<-seq(TW_PZ_05_Nov[Start_Spike,"m_below_GS"], TW_PZ_05_Nov[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)
# Replace the spike with the smoothed interpolated data
TW_PZ_05_Nov[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike
# Remove the beginning of the dataset (where logger was not submerged) 
TW_PZ_05_Nov<-TW_PZ_05_Nov[which(TW_PZ_05_Nov[,"Date_Time"]=="06/19/18 03:15:00 PM"):nrow(TW_PZ_05_Nov),]
TW_PZ_05_Nov[,"lat"]<-41.91594
TW_PZ_05_Nov[,"long"]<--70.57631
 
############## TW_PZ_06 ##############     
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 32 cm
TW_PZ_06_Nov[,"m_below_GS"]<-152/100-(32/100+TW_PZ_06_Nov[,"m_water"])  
# Smooth the spikes in the data caused by logger removal during data downloading
# Interpolate between the 7/11 spike
Start_Spike<-which(TW_PZ_06_Nov[,"Date_Time"]=="07/11/18 01:30:00 PM")                     
Stop_Spike<-which(TW_PZ_06_Nov[,"Date_Time"]=="07/11/18 02:15:00 PM")     
Smoothed_Spike<-seq(TW_PZ_06_Nov[Start_Spike,"m_below_GS"], TW_PZ_06_Nov[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)
# Replace the spike with the smoothed interpolated data
TW_PZ_06_Nov[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike
# Remove the end of the dataset (where logger was not submerged) 
TW_PZ_06_Nov<-TW_PZ_06_Nov[1:which(TW_PZ_06_Nov[,"Date_Time"]=="11/19/18 04:15:00 PM"),]
TW_PZ_06_Nov[,"lat"]<-41.91573
TW_PZ_06_Nov[,"long"]<--70.57496

############## TW_PZ_08 ##############     
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 28 cm
TW_PZ_08_Nov[,"m_below_GS"]<-116/100-(28/100+TW_PZ_08_Nov[,"m_water"])                       
# Remove the beginning of the dataset (where logger was not submerged) 
TW_PZ_08_Nov<-TW_PZ_08_Nov[-1,]
# Remove last 3 rows of blank data 
TW_PZ_08_Nov<-TW_PZ_08_Nov[1:which(TW_PZ_08_Nov[,"Date_Time"]=="11/19/18 04:45:00 PM"),]
# This data has a lot of noise the ma() function uses a moving average, using an order of 100 smoothed the data well 
TW_PZ_08_Nov[,"denoised"]<-ma(TW_PZ_08_Nov[,"m_below_GS"], order=100)                     
TW_PZ_08_Nov<-TW_PZ_08_Nov[-which(is.na(TW_PZ_08_Nov[,"denoised"])),]
TW_PZ_08_Nov[,"lat"]<-41.91744444
TW_PZ_08_Nov[,"long"]<---70.57794444

############## TW_PZ_09 ##############     
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 28 cm
TW_PZ_09_Nov[,"m_below_GS"]<-156/100-(28/100+TW_PZ_09_Nov[,"m_water"])                       
# Correct the vertical jump in data on 7/11 (date of logger retrieval); logger was in slightly different vertical position upon reinstallation
vert_shift_start<-which(TW_PZ_09_Nov[,"Date_Time"]=="07/11/18 05:30:00 PM")
TW_PZ_09_Nov[vert_shift_start:nrow(TW_PZ_09_Nov),"m_below_GS"]<-TW_PZ_09_Nov[vert_shift_start:nrow(TW_PZ_09_Nov),"m_below_GS"]-0.1153209
# Interpolate between the 7/11 spike
Start_Spike<-which(TW_PZ_09_Nov[,"Date_Time"]=="07/11/18 04:30:00 PM")                     
Stop_Spike<-which(TW_PZ_09_Nov[,"Date_Time"]=="07/11/18 05:30:00 PM")     
Smoothed_Spike<-seq(TW_PZ_09_Nov[Start_Spike,"m_below_GS"], TW_PZ_09_Nov[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)
# Replace the spike with the smoothed interpolated data
TW_PZ_09_Nov[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike
# Remove last few rows of data 
TW_PZ_09_Nov<-TW_PZ_09_Nov[1:which(TW_PZ_09_Nov[,"Date_Time"]=="11/19/18 03:30:00 PM"),]
TW_PZ_09_Nov[,"lat"]<-41.91705556
TW_PZ_09_Nov[,"long"]<--70.57588889

############## TW_PZ_03 ##############    
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 58 cm
TW_PZ_03_Nov[,"m_stage"]<-(150/100-(58/100+TW_PZ_03_Nov[,"m_water"]) )*-1 
# Remove last few rows of data 
TW_PZ_03_Nov<-TW_PZ_03_Nov[1:which(TW_PZ_03_Nov[,"Date_Time"]=="11/20/18 10:15:00 AM"),] 
TW_PZ_03_Nov[,"lat"]<-41.91499167
TW_PZ_03_Nov[,"long"]<--70.57736111

############## TW_PZ_07 ##############    
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 31 cm
TW_PZ_07_Nov[,"m_stage"]<-(153/100-(31/100+TW_PZ_07_Nov[,"m_water"]) )*-1 
# Remove last few rows of data 
TW_PZ_07_Nov<-TW_PZ_07_Nov[1:which(TW_PZ_07_Nov[,"Date_Time"]=="11/19/18 05:00:00 PM"),] 
TW_PZ_07_Nov[,"lat"]<-41.91708333
TW_PZ_07_Nov[,"long"]<--70.57833333

############## TW_SW_02 ##############     
# Remove last few rows of data 
TW_SW_02_Nov<-TW_SW_02_Nov[1:which(TW_SW_02_Nov[,"Date_Time"]=="11/20/18 10:30:00 AM"),]
TW_SW_02_Nov[,"lat"]<-41.91389722
TW_SW_02_Nov[,"long"]<--70.57706944

############## TW_SW_04 ##############     
# Correct based on manual stream measurements
TW_SW_04_Nov[,"m_water"]<-TW_SW_04_Nov[,"m_water"]-(11/100)  
# Remove last few rows of data 
TW_SW_04_Nov<-TW_SW_04_Nov[1:which(TW_SW_04_Nov[,"Date_Time"]=="11/20/18 09:45:00 AM"),] 
TW_SW_04_Nov[,"lat"]<-41.91283611
TW_SW_04_Nov[,"long"]<--70.57670833

############## TW_SW_07 ##############     
# Correct based on manual stream measurements
TW_SW_07_Nov[,"m_water"]<-TW_SW_07_Nov[,"m_water"]-(13/100)  
# Remove last few rows of data 
TW_SW_07_Nov<-TW_SW_07_Nov[1:which(TW_SW_07_Nov[,"Date_Time"]=="11/19/18 05:00:00 PM"),] 
TW_SW_07_Nov[,"lat"]<-41.91708333
TW_SW_07_Nov[,"long"]<--70.57833333

############## TW_PZ_05_SAND ##############    
TW_PZ_05_SAND_Nov[,"m_below_GS"]<-150/100-(105.5/100+TW_PZ_05_SAND_Nov[,"m_water"])  
# Remove last few rows of data 
TW_PZ_05_SAND_Nov<-TW_PZ_05_SAND_Nov[1:which(TW_PZ_05_SAND_Nov[,"Date_Time"]=="11/19/18 03:45:00 PM"),]
TW_PZ_05_SAND_Nov[,"lat"]<-41.91594
TW_PZ_05_SAND_Nov[,"long"]<--70.57631

############## TW_PZ_06_SAND ##############    
TW_PZ_06_SAND_Nov[,"m_below_GS"]<-150/100-(102/100+TW_PZ_06_SAND_Nov[,"m_water"])  
# Remove last few rows of data 
TW_PZ_06_SAND_Nov<-TW_PZ_06_SAND_Nov[1:which(TW_PZ_06_SAND_Nov[,"Date_Time"]=="11/19/18 04:15:00 PM"),]                 
 # Remove last first row of data 
TW_PZ_06_SAND_Nov<-TW_PZ_06_SAND_Nov[-1,] 
# This data has a lot of noise the ma() function uses a moving average, using an order of 75 smoothed the data well 
TW_PZ_06_SAND_Nov[,"denoised"]<-ma(TW_PZ_06_SAND_Nov[,"m_below_GS"], order=75)                     
TW_PZ_06_SAND_Nov<-TW_PZ_06_SAND_Nov[-which(is.na(TW_PZ_06_SAND_Nov[,"denoised"])),]  
TW_PZ_06_SAND_Nov[,"lat"]<-41.91573
TW_PZ_06_SAND_Nov[,"long"]<--70.57496
                     
##################################################### MAKE PLOTS ####################################################################################

# TW_PZ_01
Plot_Times<-as.POSIXct(TW_PZ_01_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_Nov, aes(Plot_Times, TW_PZ_01_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.2,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_Nov.pdf", width = 12, height = 6)

# TW_PZ_05
Plot_Times<-as.POSIXct(TW_PZ_05_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_Nov, aes(Plot_Times, TW_PZ_05_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.8,-.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_05_Nov.pdf", width = 12, height = 6)

# TW_PZ_06
Plot_Times<-as.POSIXct(TW_PZ_06_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_Nov, aes(Plot_Times, TW_PZ_06_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_06_Nov.pdf", width = 12, height = 6)

# TW_PZ_08
Plot_Times<-as.POSIXct(TW_PZ_08_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_Nov, aes(Plot_Times, TW_PZ_08_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_line(aes(x=Plot_Times, y=TW_PZ_08_Nov[,"denoised"]), color="orange3", size=.6)                       
ggsave("TW_PZ_08_Nov.pdf", width = 12, height = 6)

# TW_PZ_09
Plot_Times<-as.POSIXct(TW_PZ_09_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_09_Nov, aes(Plot_Times, TW_PZ_09_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_09")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                       
ggsave("TW_PZ_09_Nov.pdf", width = 12, height = 6)

# TW_PZ_03
Plot_Times<-as.POSIXct(TW_PZ_03_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_03_Nov, aes(Plot_Times, TW_PZ_03_Nov[,"m_stage"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_PZ_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_PZ_03_Nov.pdf", width = 12, height = 6)

# TW_PZ_07
Plot_Times<-as.POSIXct(TW_PZ_07_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_Nov, aes(Plot_Times, TW_PZ_07_Nov[,"m_stage"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_PZ_07_Nov.pdf", width = 12, height = 6)

# TW_SW_02
Plot_Times<-as.POSIXct(TW_SW_02_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_02_Nov, aes(Plot_Times, TW_SW_02_Nov[,"m_water"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_02_Nov.pdf", width = 12, height = 6)
                      
# TW_SW_04
Plot_Times<-as.POSIXct(TW_SW_04_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_Nov, aes(Plot_Times, TW_SW_04_Nov[,"m_water"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_04_Nov.pdf", width = 12, height = 6)
                                            
# TW_SW_07
Plot_Times<-as.POSIXct(TW_SW_07_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_Nov, aes(Plot_Times, TW_SW_07_Nov[,"m_water"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_07_Nov.pdf", width = 12, height = 6)                       
                       
# TW_PZ_05_SAND
Plot_Times<-as.POSIXct(TW_PZ_05_SAND_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_SAND_Nov, aes(Plot_Times, TW_PZ_05_SAND_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05_SAND_Nov")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                       
ggsave("TW_PZ_05_SAND_Nov.pdf", width = 12, height = 6)     

# TW_PZ_06_SAND
Plot_Times<-as.POSIXct(TW_PZ_06_SAND_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_SAND_Nov, aes(Plot_Times, TW_PZ_06_SAND_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06_SAND_Nov")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_line(aes(x=Plot_Times, y=TW_PZ_06_SAND_Nov[,"denoised"]), color="orange3", size=.6)                                       
ggsave("TW_PZ_06_SAND_Nov.pdf", width = 12, height = 6)                       
                                         
                       
                       
setwd('C:/Users/erikai94/Documents/UMass/Tidmarsh/elevations/elevations/Data')  
allpts<-readOGR(dsn = ".", layer="allpts")     
ditches<-readOGR(dsn = ".", layer="Ditches")                       
                  
                       
