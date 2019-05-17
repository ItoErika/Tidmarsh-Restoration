##################################################### LOAD LIBRARIES ####################################################################################
# Load packages
library('gmp')
library('plyr')
library('rnoaa')
library('ggplot2')
library('scales')
library('forecast')
library('sf')
library('rgdal')
library('raster')
library('gstat')
library('geosphere')
library('plotly')


####################################################### LOAD DATA ######################################################################################

# Load raw data (downloaded from pressure transducers)

TW_PZ_05_3_3<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW_WL_2018_03_04/TW-PZ-05_2018_03_03.csv", skip=1, row.names=1)
TW_PZ_08_3_3<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW_WL_2018_03_04/TW-PZ-08_2018_03_03.csv", skip=1, row.names=1)

TW_SW_07_3_3<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW_WL_2018_03_04/TW_SW_07_2018_03_03.csv", skip=1, row.names=1)

TW_PZ_01_3_19<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW_WL_2018_03_19/TW_PZ_01_2018_03_19.csv", skip=1, row.names=1)
TW_PZ_06_3_19<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW_WL_2018_03_19/TW_PZ_06_2018_03_19.csv", skip=1, row.names=1)
TW_PZ_07_3_19<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW_WL_2018_03_19/TW_PZ_07_2018_03_19.csv", skip=1, row.names=1)

TW_PZ_02_5_6<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW_WL_2018_05_06/TW_PZ_02.csv", skip=1, row.names=1)
TW_PZ_09_5_6<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW_WL_2018_05_06/TW-PZ-09.csv", skip=1, row.names=1)


TW_PZ_01_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-PZ-01_sn10499234_2018_11_20.csv", skip=1, row.names=1)
TW_PZ_02_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW_PZ_02_2018_11_20.csv", skip=1, row.names=1)
TW_PZ_03_Nov<-read.csv("file:///C:/Users/erikai94/Documents/Umass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2018_11_20/TW-PZ-03_sn10499228_2018_11_20.csv", skip=1, row.names=1)
TW_PZ_03_8_17<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/Tidmarsh_TW_WL_2017_08_29/TW_PZ_03.csv", skip=1, row.names=1)
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
NOAA_Plymouth_Data<-read.table("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/NOAA/full/9414367922965dat.txt", fill=TRUE, header=TRUE)

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
        LoggerData[,"water_density"]<-1000*(1-(LoggerData[,"Temp_C"]+288.9414)/(508929.2*(LoggerData[,"Temp_C"]+68.12963))*(LoggerData[,"Temp_C"]-3.9863)^2)      
        # Convert mb to Pa              
        LoggerData[,"STP"]<-LoggerData[,"STP"]*100
        # Convert KPa to Pa
        LoggerData[,"Abs_Pres_Pa"]<-LoggerData[,"Abs_Pres_Pa"]*1000
        # Create a column for m of water above each logger             
        LoggerData[,"m_water"]<-(LoggerData[,"Abs_Pres_Pa"]-LoggerData[,"STP"])/(9.81*LoggerData[,"water_density"])
        return(LoggerData)
        }

# Run this function on the logger file with pressure as kPa    
TW_PZ_05_3_3<-loggerProcess(TW_PZ_05_3_3)
TW_PZ_08_3_3<-loggerProcess(TW_PZ_08_3_3)
TW_SW_07_3_3<-loggerProcess(TW_SW_07_3_3)
                                          
TW_PZ_01_3_19<-loggerProcess(TW_PZ_01_3_19)
TW_PZ_06_3_19<-loggerProcess(TW_PZ_06_3_19)  
TW_PZ_07_3_19<-loggerProcess(TW_PZ_07_3_19) 
 
TW_PZ_09_5_6<-loggerProcess(TW_PZ_09_5_6)  
TW_PZ_02_5_6<-loggerProcess(TW_PZ_02_5_6)
                    
TW_PZ_01_Nov<-loggerProcess(TW_PZ_01_Nov)
TW_PZ_02_Nov<-loggerProcess(TW_PZ_02_Nov)
TW_PZ_03_Nov<-loggerProcess(TW_PZ_03_Nov)
TW_PZ_03_8_17<-loggerProcess(TW_PZ_03_8_17)                      
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
TW_PZ_01_3_19[,"m_below_GS"]<-163.4/100-(25.8/100+TW_PZ_01_3_19[,"m_water"]) 
# Remove blank rows from logger extractions
TW_PZ_01_3_19<-TW_PZ_01_3_19[-which(is.na(TW_PZ_01_3_19[,"m_below_GS"])),]
# Interpolate between the 8/29 spike
Start_Spike<-which(TW_PZ_01_3_19[,"Date_Time"]=="08/29/17 01:00:00 PM")                     
Stop_Spike<-which(TW_PZ_01_3_19[,"Date_Time"]=="08/29/17 02:30:00 PM")     
Smoothed_Spike<-seq(TW_PZ_01_3_19[Start_Spike,"m_below_GS"], TW_PZ_01_3_19[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)  
# Replace the spike with the smoothed interpolated data
TW_PZ_01_3_19[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike
# Interpolate between the 10/23 spike
Start_Spike<-which(TW_PZ_01_3_19[,"Date_Time"]=="10/23/17 02:30:00 PM")                     
Stop_Spike<-which(TW_PZ_01_3_19[,"Date_Time"]=="10/23/17 03:00:00 PM")     
Smoothed_Spike<-seq(TW_PZ_01_3_19[Start_Spike,"m_below_GS"], TW_PZ_01_3_19[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)  
# Replace the spike with the smoothed interpolated data
TW_PZ_01_3_19[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike                       
# Correct the vertical jump in data on 3/4 (date of logger retrieval); logger was in slightly different vertical position upon reinstallation
vert_shift_start<-which(TW_PZ_01_3_19[,"Date_Time"]=="03/04/18 10:30:00 AM")
TW_PZ_01_3_19[vert_shift_start:nrow(TW_PZ_01_3_19),"m_below_GS"]<-TW_PZ_01_3_19[vert_shift_start:nrow(TW_PZ_01_3_19),"m_below_GS"]- 0.034                         
# Remove the last rows of the data set where the logger was not submerged (after 3/19)
Logger_not_Submerged<-which(TW_PZ_01_3_19[,"Date_Time"]=="03/19/18 09:30:00 AM")
TW_PZ_01_3_19<-TW_PZ_01_3_19[-(Logger_not_Submerged:nrow(TW_PZ_01_3_19)),]                                           
# Remove the first row of the dataset (the logger was not submerged)
TW_PZ_01_3_19<-TW_PZ_01_3_19[-1,]                 
# Save as CSV  
write.csv(TW_PZ_01_3_19, file="TWPZ01_8-10-17_to_33-19-18.csv", row.names=FALSE)           
                       
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 25.8 cm
TW_PZ_01_Nov[,"m_below_GS"]<-131/100-(25.8/100+TW_PZ_01_Nov[,"m_water"])
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
# Add manual data
TW_PZ_01_Nov[which(TW_PZ_01_Nov[,"Date_Time"]=="06/19/18 01:00:00 PM"),"m_manual"]<-0.158                       
TW_PZ_01_Nov[which(TW_PZ_01_Nov[,"Date_Time"]=="07/11/18 09:00:00 AM"),"m_manual"]<-0.06
TW_PZ_01_Nov[which(TW_PZ_01_Nov[,"Date_Time"]=="11/20/18 10:00:00 AM"),"m_manual"]<-0.037 
TW_PZ_01_Nov[,"lat"]<-41.91347222 
TW_PZ_01_Nov[,"long"]<--70.57844444    
# Save as CSV  
write.csv(TW_PZ_01_Nov, file="TWPZ01_6-18-18_to_11-20-18.csv", row.names=FALSE)  

############## TW_PZ_02 ##############       
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 19 cm
TW_PZ_02_5_6[,"m_above_GS"]<-(TW_PZ_02_5_6[,"m_water"])-.8
# Remove the first rows of the data set where the logger was not submerged 
Logger_not_Submerged<-which(TW_PZ_02_5_6[,"Date_Time"]=="08/10/17 11:15:00 AM")
TW_PZ_02_5_6<-TW_PZ_02_5_6[-(1:Logger_not_Submerged),]        
# Correct the vertical jump in data on 3/3 - logger was dropped down the piezometer! (chopped off with saw on accident)
vert_shift_start<-which(TW_PZ_02_5_6[,"Date_Time"]=="03/03/18 02:30:00 PM")
TW_PZ_02_5_6[vert_shift_start:nrow(TW_PZ_02_5_6),"m_above_GS"]<-TW_PZ_02_5_6[vert_shift_start:nrow(TW_PZ_02_5_6),"m_above_GS"]+ 0.5565902                        
# Interpolate between the 3/3 drop spike                       
Start_Spike<-which(TW_PZ_02_5_6[,"Date_Time"]=="03/03/18 01:00:00 PM")
Stop_Spike<-which(TW_PZ_02_5_6[,"Date_Time"]=="03/03/18 02:30:00 PM")     
Smoothed_Spike<-seq(TW_PZ_02_5_6[Start_Spike,"m_above_GS"], TW_PZ_02_5_6[Stop_Spike,"m_above_GS"], length=Stop_Spike-Start_Spike+1)
# Replace the spike with the smoothed interpolated data
TW_PZ_02_5_6[Start_Spike:Stop_Spike,"m_above_GS"]<-Smoothed_Spike  
# Add manual data
TW_PZ_02_5_6[which(TW_PZ_02_5_6[,"Date_Time"]=="10/23/17 03:15:00 PM"),"m_manual"]<-0.384
TW_PZ_02_5_6[which(TW_PZ_02_5_6[,"Date_Time"]=="03/03/18 01:00:00 PM"),"m_manual"]<-0.45  
TW_PZ_02_5_6[which(TW_PZ_02_5_6[,"Date_Time"]=="03/24/18 06:15:00 AM"),"m_manual"]<-0.372 
write.csv(TW_PZ_02_5_6, file="TWPZ02_8-10-17_to_3-24-18.csv", row.names=FALSE)   
    
############## TW_PZ_05 ##############       
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 30.9 cm
TW_PZ_05_3_3[,"m_below_GS"]<-159.1/100-(30.9/100+TW_PZ_05_3_3[,"m_water"]) 
TW_PZ_05_3_3[which(TW_PZ_05_3_3[,"Date_Time"]=="03/03/18 04:00:00 PM"),"m_manual"]<-0.178 
# Remove the last rows of the data set where the logger was not submerged
Logger_not_Submerged<-which(TW_PZ_05_3_3[,"Date_Time"]=="03/03/18 04:15:00 PM")
TW_PZ_05_3_3<-TW_PZ_05_3_3[-(Logger_not_Submerged:nrow(TW_PZ_05_3_3)),] 
# Save as CSV  
write.csv(TW_PZ_05_3_3, file="TWPZ05_8-29-17_to_3-3-18.csv", row.names=FALSE)    
 
           
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
# Add manual data
TW_PZ_05_Nov[which(TW_PZ_05_Nov[,"Date_Time"]=="07/11/18 02:30:00 PM"),"m_manual"]<-0.298
TW_PZ_05_Nov[which(TW_PZ_05_Nov[,"Date_Time"]=="11/19/18 03:00:00 PM"),"m_manual"]<-0.114
# Save as CSV  
write.csv(TW_PZ_05_Nov, file="TWPZ05_6-19-18_to_11-19-18.csv", row.names=FALSE)    
TW_PZ_05_Nov[,"lat"]<-41.91594
TW_PZ_05_Nov[,"long"]<--70.57631
 
############## TW_PZ_06 ##############     
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 32 cm
TW_PZ_06_3_19[,"m_below_GS"]<-151.9/100-(32/100+TW_PZ_06_3_19[,"m_water"])  
# Remove blank rows from logger extractions                    
TW_PZ_06_3_19<-TW_PZ_06_3_19[-which(is.na(TW_PZ_06_3_19[,"m_below_GS"])),]   
# Interpolate between the 10/23 spike
Start_Spike<-which(TW_PZ_06_3_19[,"Date_Time"]=="10/23/17 11:45:00 AM")                     
Stop_Spike<-which(TW_PZ_06_3_19[,"Date_Time"]=="10/23/17 12:15:00 PM")     
Smoothed_Spike<-seq(TW_PZ_06_3_19[Start_Spike,"m_below_GS"], TW_PZ_06_3_19[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)  
# Replace the spike with the smoothed interpolated data
TW_PZ_06_3_19[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike                       
# Remove the last rows of the data set where the logger was not submerged (after 3/19)
Logger_not_Submerged<-which(TW_PZ_06_3_19[,"Date_Time"]=="03/19/18 10:00:00 AM")
TW_PZ_06_3_19<-TW_PZ_06_3_19[-(Logger_not_Submerged:nrow(TW_PZ_06_3_19)),]                                           
# Save as CSV  
write.csv(TW_PZ_06_3_19, file="TWPZ06_8-19-17_to_33-19-18.csv", row.names=FALSE)                          
                       
                       
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 32 cm
TW_PZ_06_Nov[,"m_below_GS"]<-153/100-(32/100+TW_PZ_06_Nov[,"m_water"])  
# Smooth the spikes in the data caused by logger removal during data downloading
# Interpolate between the 7/11 spike
Start_Spike<-which(TW_PZ_06_Nov[,"Date_Time"]=="07/11/18 01:30:00 PM")                     
Stop_Spike<-which(TW_PZ_06_Nov[,"Date_Time"]=="07/11/18 02:15:00 PM")     
Smoothed_Spike<-seq(TW_PZ_06_Nov[Start_Spike,"m_below_GS"], TW_PZ_06_Nov[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)
# Replace the spike with the smoothed interpolated data
TW_PZ_06_Nov[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike
# Remove the end of the dataset (where logger was not submerged) 
TW_PZ_06_Nov<-TW_PZ_06_Nov[1:which(TW_PZ_06_Nov[,"Date_Time"]=="11/19/18 04:15:00 PM"),]
# Add manual data
TW_PZ_06_Nov[which(TW_PZ_06_Nov[,"Date_Time"]=="06/19/18 02:45:00 PM"),"m_manual"]<-0.297
TW_PZ_06_Nov[which(TW_PZ_06_Nov[,"Date_Time"]=="07/11/18 01:30:00 PM"),"m_manual"]<-0.36
TW_PZ_06_Nov[which(TW_PZ_06_Nov[,"Date_Time"]=="11/19/18 03:30:00 PM"),"m_manual"]<-0.063
TW_PZ_06_Nov[,"lat"]<-41.91573
TW_PZ_06_Nov[,"long"]<--70.57496
# Save as CSV  
write.csv(TW_PZ_06_Nov, file="TWPZ06_6-18-18_to_11-19-18.csv", row.names=FALSE)                                       

############## TW_PZ_07 ##############    
# Create a column for height of water above stream bed
# The top of piezometer casing to ground surface = 28 cm
TW_PZ_07_3_19[,"m_above_GS"]<-(132.1/100-(28/100+TW_PZ_07_3_19[,"m_water"]))*-1    
# Remove blank rows from logger extractions
TW_PZ_07_3_19<-TW_PZ_07_3_19[-which(is.na(TW_PZ_07_3_19[,"m_above_GS"])),] 
# Interpolate between the 10/23 spike
Start_Spike<-which(TW_PZ_07_3_19[,"Date_Time"]=="10/23/17 11:15:00 AM")                     
Stop_Spike<-which(TW_PZ_07_3_19[,"Date_Time"]=="10/23/17 11:45:00 AM")     
Smoothed_Spike<-seq(TW_PZ_07_3_19[Start_Spike,"m_above_GS"], TW_PZ_07_3_19[Stop_Spike,"m_above_GS"], length=Stop_Spike-Start_Spike+1)  
# Replace the spike with the smoothed interpolated data
TW_PZ_07_3_19[Start_Spike:Stop_Spike,"m_above_GS"]<-Smoothed_Spike  
# Interpolate between the 3/3 spike
Start_Spike<-which(TW_PZ_07_3_19[,"Date_Time"]=="03/03/18 05:45:00 PM")                     
Stop_Spike<-which(TW_PZ_07_3_19[,"Date_Time"]=="03/03/18 06:15:00 PM")     
Smoothed_Spike<-seq(TW_PZ_07_3_19[Start_Spike,"m_above_GS"], TW_PZ_07_3_19[Stop_Spike,"m_above_GS"], length=Stop_Spike-Start_Spike+1)  
# Replace the spike with the smoothed interpolated data
TW_PZ_07_3_19[Start_Spike:Stop_Spike,"m_above_GS"]<-Smoothed_Spike  
# Remove the first rows of the data set where the logger was not submerged 
Logger_not_Submerged<-which(TW_PZ_07_3_19[,"Date_Time"]=="08/29/17 03:30:00 PM")
TW_PZ_07_3_19<-TW_PZ_07_3_19[-(1:Logger_not_Submerged),]          
# Remove the last rows of the data set where the logger was not submerged (after 3/19)
Logger_not_Submerged<-which(TW_PZ_07_3_19[,"Date_Time"]=="03/19/18 10:30:00 AM")
TW_PZ_07_3_19<-TW_PZ_07_3_19[-(Logger_not_Submerged:nrow(TW_PZ_07_3_19)),]  
# Add manual data
TW_PZ_07_3_19[which(TW_PZ_07_3_19[,"Date_Time"]=="11/17/17 05:45:00 PM"),"m_manual"]<-0.239                       
TW_PZ_07_3_19[which(TW_PZ_07_3_19[,"Date_Time"]=="03/03/18 05:45:00 PM"),"m_manual"]<-0.181
TW_PZ_07_3_19[which(TW_PZ_07_3_19[,"Date_Time"]=="03/19/18 10:15:00 AM"),"m_manual"]<-0.155 
# Save as CSV  
write.csv(TW_PZ_07_3_19, file="TWPZ07_8-29-17_to_3-19-18.csv", row.names=FALSE)                        

############## TW_PZ_08 ##############     
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 28 cm
TW_PZ_08_3_3[,"m_below_GS"]<-131.9/100-(28/100+TW_PZ_08_3_3[,"m_water"])                       
# Remove the last rows of the data set where the logger was not submerged (after 3/19)
Logger_not_Submerged<-which(TW_PZ_08_3_3[,"Date_Time"]=="03/03/18 04:15:00 PM")
TW_PZ_08_3_3<-TW_PZ_08_3_3[-(Logger_not_Submerged:nrow(TW_PZ_08_3_3)),]  
write.csv(TW_PZ_08_3_3, file="TWPZ08_8-29-17_to_3-3-18_MALFUNC.csv", row.names=FALSE)                        

# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 28 cm
TW_PZ_08_Nov[,"m_below_GS"]<-116/100-(28/100+TW_PZ_08_Nov[,"m_water"])                       
# Remove the beginning of the dataset (where logger was not submerged) 
TW_PZ_08_Nov<-TW_PZ_08_Nov[-1,]
# Remove last 3 rows of blank data 
TW_PZ_08_Nov<-TW_PZ_08_Nov[1:which(TW_PZ_08_Nov[,"Date_Time"]=="11/19/18 04:45:00 PM"),]
# This data has a lot of noise the ma() function uses a moving average, using an order of 100 smoothed the data well 
#TW_PZ_08_Nov[,"denoised"]<-ma(TW_PZ_08_Nov[,"m_below_GS"], order=100)                     
#TW_PZ_08_Nov<-TW_PZ_08_Nov[-which(is.na(TW_PZ_08_Nov[,"denoised"])),]
# Add manual data
TW_PZ_08_Nov[which(TW_PZ_08_Nov[,"Date_Time"]=="06/19/18 03:15:00 PM"),"m_manual"]<-0.149
TW_PZ_08_Nov[which(TW_PZ_08_Nov[,"Date_Time"]=="07/11/18 05:00:00 PM"),"m_manual"]<-0.106
TW_PZ_08_Nov[which(TW_PZ_08_Nov[,"Date_Time"]=="11/19/18 03:45:00 PM"),"m_manual"]<-0.114
TW_PZ_08_Nov[,"lat"]<-41.91744444
TW_PZ_08_Nov[,"long"]<---70.57794444
write.csv(TW_PZ_08_Nov, file="TWPZ08_6-18-18_to_11-19-18_MALFUNC.csv", row.names=FALSE)    

############## TW_PZ_09 ##############    
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 28.4 cm
TW_PZ_09_5_6[,"m_below_GS"]<-140.3/100-(28.4/100+TW_PZ_09_5_6[,"m_water"]) 
# Remove the first two rows before the logger was submerged
TW_PZ_09_5_6<-TW_PZ_09_5_6[which(TW_PZ_09_5_6[,"Date_Time"]=="08/29/17 03:30:00 PM"):nrow(TW_PZ_09_5_6),]
# Correct the vertical jump in data on 3/19 (date of logger retrieval); logger was in slightly different vertical position upon reinstallation
vert_shift_start<-which(TW_PZ_09_5_6[,"Date_Time"]=="03/19/18 10:45:00 AM")
TW_PZ_09_5_6[vert_shift_start:nrow(TW_PZ_09_5_6),"m_below_GS"]<-TW_PZ_09_5_6[vert_shift_start:nrow(TW_PZ_09_5_6),"m_below_GS"]+ 0.209547                      
# Interpolate between the 3/19 spike
Start_Spike<-which(TW_PZ_09_5_6[,"Date_Time"]=="03/19/18 10:00:00 AM")                     
Stop_Spike<-which(TW_PZ_09_5_6[,"Date_Time"]=="03/19/18 10:45:00 AM")     
Smoothed_Spike<-seq(TW_PZ_09_5_6[Start_Spike,"m_below_GS"], TW_PZ_09_5_6[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)  
# Replace the spike with the smoothed interpolated data
TW_PZ_09_5_6[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike   
TW_PZ_09_5_6[which(TW_PZ_09_5_6[,"Date_Time"]=="03/19/18 10:00:00 AM"),"m_manual"]<-0.198 
write.csv(TW_PZ_09_5_6, file="TWPZ09_8-29-17_to_4-12-18.csv", row.names=FALSE)                           
 
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 28 cm
TW_PZ_09_Nov[,"m_below_GS"]<-172/100-(28/100+TW_PZ_09_Nov[,"m_water"])                       
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
TW_PZ_09_Nov[which(TW_PZ_09_Nov[,"Date_Time"]=="07/11/18 04:45:00 PM"),"m_manual"]<-0.513
TW_PZ_09_Nov[which(TW_PZ_09_Nov[,"Date_Time"]=="11/19/18 03:30:00 PM"),"m_manual"]<-0.403
write.csv(TW_PZ_09_Nov, file="TWPZ09_6-18-18_to_11-19-18.csv", row.names=FALSE)    

############## TW_PZ_03 ##############    
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 58 cm
TW_PZ_03_Nov[,"m_above_GS"]<-(151/100-(58/100+TW_PZ_03_Nov[,"m_water"]) )*-1 
# Remove last few rows of data 
TW_PZ_03_Nov<-TW_PZ_03_Nov[1:which(TW_PZ_03_Nov[,"Date_Time"]=="11/20/18 10:15:00 AM"),]
# Add manual data
TW_PZ_03_Nov[which(TW_PZ_03_Nov[,"Date_Time"]=="07/12/18 11:30:00 AM"),"m_manual"]<-0.383
TW_PZ_03_Nov[which(TW_PZ_03_Nov[,"Date_Time"]=="11/20/18 09:15:00 AM"),"m_manual"]<-0.382                    
TW_PZ_03_Nov[,"lat"]<-41.91499167
TW_PZ_03_Nov[,"long"]<--70.57736111   
write.csv(TW_PZ_03_Nov, file="TWPZ03_7-12-18_to_11-20-18.csv", row.names=FALSE)    

############## TW_PZ_07 ##############    
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 31 cm
TW_PZ_07_Nov[,"m_above_GS"]<-(153/100-(31/100+TW_PZ_07_Nov[,"m_water"]) )*-1 
# Remove last few rows of data 
TW_PZ_07_Nov<-TW_PZ_07_Nov[1:which(TW_PZ_07_Nov[,"Date_Time"]=="11/19/18 05:00:00 PM"),] 
# Remove blank rows from logger extractions                    
TW_PZ_07_Nov<-TW_PZ_07_Nov[-which(is.na(TW_PZ_07_Nov[,"m_above_GS"])),]   
# Add manual data
TW_PZ_07_Nov[which(TW_PZ_07_Nov[,"Date_Time"]=="11/19/18 04:15:00 PM"),"m_manual"]<-0.228
TW_PZ_07_Nov[which(TW_PZ_07_Nov[,"Date_Time"]=="07/12/18 12:30:00 PM"),"m_manual"]<-0.26
TW_PZ_07_Nov[,"lat"]<-41.91708333
TW_PZ_07_Nov[,"long"]<--70.57833333
write.csv(TW_PZ_07_Nov, file="TWPZ07_6-18-18_to_11-19-18.csv", row.names=FALSE) 

############## TW_SW_02 ##############     
# Remove last few rows of data 
TW_SW_02_Nov<-TW_SW_02_Nov[1:which(TW_SW_02_Nov[,"Date_Time"]=="11/20/18 10:30:00 AM"),]
TW_SW_02_Nov[,"lat"]<-41.91389722
TW_SW_02_Nov[,"long"]<--70.57706944

############## TW_SW_03 ##############     
# Correct based on manual stream measurements

############## TW_SW_04 ##############     
# Correct based on manual stream measurements
TW_SW_04_Nov[,"m_water"]<-TW_SW_04_Nov[,"m_water"]-(11/100)  
# Remove last few rows of data 
TW_SW_04_Nov<-TW_SW_04_Nov[1:which(TW_SW_04_Nov[,"Date_Time"]=="11/20/18 09:45:00 AM"),] 
TW_SW_04_Nov[,"lat"]<-41.91283611
TW_SW_04_Nov[,"long"]<--70.57670833

############## TW_SW_07 ##############     
# Correct based on manual stream measurements
# Create a column for height of water above stream bed
TW_SW_07_3_3[,"m_above_GS"]<-TW_SW_07_3_3[,"m_water"]-.10
# Remove the first rows of the data set where the logger was not submerged 
Logger_not_Submerged<-which(TW_SW_07_3_3[,"Date_Time"]=="08/10/17 03:00:00 PM")
TW_SW_07_3_3<-TW_SW_07_3_3[-(1:Logger_not_Submerged),] 
# Add manual data
TW_SW_07_3_3[which(TW_SW_07_3_3[,"Date_Time"]=="03/03/18 05:45:00 PM"),"m_manual"]<-0.105
# Save as CSV  
write.csv(TW_SW_07_3_3, file="TWSW07_8-10-17_to_3-3-18.csv", row.names=FALSE)         

# Remove blank rows from logger extractions
TW_PZ_07_3_19<-TW_PZ_07_3_19[-which(is.na(TW_PZ_07_3_19[,"m_above_GS"])),] 
# Interpolate between the 10/23 spike
Start_Spike<-which(TW_PZ_07_3_19[,"Date_Time"]=="10/23/17 11:15:00 AM")                     
Stop_Spike<-which(TW_PZ_07_3_19[,"Date_Time"]=="10/23/17 11:45:00 AM")     
Smoothed_Spike<-seq(TW_PZ_07_3_19[Start_Spike,"m_above_GS"], TW_PZ_07_3_19[Stop_Spike,"m_above_GS"], length=Stop_Spike-Start_Spike+1)  
# Replace the spike with the smoothed interpolated data
TW_PZ_07_3_19[Start_Spike:Stop_Spike,"m_above_GS"]<-Smoothed_Spike  
# Interpolate between the 3/3 spike
Start_Spike<-which(TW_PZ_07_3_19[,"Date_Time"]=="03/03/18 05:45:00 PM")                     
Stop_Spike<-which(TW_PZ_07_3_19[,"Date_Time"]=="03/03/18 06:15:00 PM")     
Smoothed_Spike<-seq(TW_PZ_07_3_19[Start_Spike,"m_above_GS"], TW_PZ_07_3_19[Stop_Spike,"m_above_GS"], length=Stop_Spike-Start_Spike+1)  
# Replace the spike with the smoothed interpolated data
TW_PZ_07_3_19[Start_Spike:Stop_Spike,"m_above_GS"]<-Smoothed_Spike  
# Remove the first rows of the data set where the logger was not submerged 
Logger_not_Submerged<-which(TW_PZ_07_3_19[,"Date_Time"]=="08/29/17 03:30:00 PM")
TW_PZ_07_3_19<-TW_PZ_07_3_19[-(1:Logger_not_Submerged),]          
# Remove the last rows of the data set where the logger was not submerged (after 3/19)
Logger_not_Submerged<-which(TW_PZ_07_3_19[,"Date_Time"]=="03/19/18 10:30:00 AM")
TW_PZ_07_3_19<-TW_PZ_07_3_19[-(Logger_not_Submerged:nrow(TW_PZ_07_3_19)),]  
# Add manual data
TW_PZ_07_3_19[which(TW_PZ_07_3_19[,"Date_Time"]=="11/17/17 05:45:00 PM"),"m_manual"]<-0.239                       
TW_PZ_07_3_19[which(TW_PZ_07_3_19[,"Date_Time"]=="03/03/18 05:45:00 PM"),"m_manual"]<-0.181
TW_PZ_07_3_19[which(TW_PZ_07_3_19[,"Date_Time"]=="03/19/18 10:15:00 AM"),"m_manual"]<-0.155 
# Save as CSV  
write.csv(TW_PZ_07_3_19, file="TWPZ07_8-29-17_to_33-19-18.csv", row.names=FALSE)           

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
Plot_Times<-as.POSIXct(TW_PZ_01_3_19[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_3_19, aes(Plot_Times, TW_PZ_01_3_19[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1.2,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_3_19.pdf", width = 12, height = 6)  
  
# cut off slow rise
Plot_Times<-as.POSIXct(TW_PZ_01_3_19[which(TW_PZ_01_3_19[,"Date_Time"]=="08/24/17 12:00:00 AM"):nrow(TW_PZ_01_3_19)    ,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_3_19[which(TW_PZ_01_3_19[,"Date_Time"]=="08/24/17 12:00:00 AM"):nrow(TW_PZ_01_3_19),], aes(Plot_Times, TW_PZ_01_3_19[which(TW_PZ_01_3_19[,"Date_Time"]=="08/24/17 12:00:00 AM"):nrow(TW_PZ_01_3_19),"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.4,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_3_19_2.pdf", width = 12, height = 6)                         
                   
Plot_Times<-as.POSIXct(TW_PZ_01_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_Nov, aes(Plot_Times, TW_PZ_01_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.2,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_Nov.pdf", width = 12, height = 6)

# TW_PZ_02
Plot_Times<-as.POSIXct(TW_PZ_02_5_6[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_5_6, aes(Plot_Times, TW_PZ_02_5_6[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0.2,.6) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_02_3_24.pdf", width = 12, height = 6)  

# TW_PZ_05
Plot_Times<-as.POSIXct(TW_PZ_05_3_3[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_3_3, aes(Plot_Times, TW_PZ_05_3_3[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1,-.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_05_3_3.pdf", width = 12, height = 6)

Plot_Times<-as.POSIXct(TW_PZ_05_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_Nov, aes(Plot_Times, TW_PZ_05_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.8,-.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_05_Nov.pdf", width = 12, height = 6)

# TW_PZ_06
Plot_Times<-as.POSIXct(TW_PZ_06_3_19[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_3_19, aes(Plot_Times, TW_PZ_06_3_19[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_06_3_19.pdf", width = 12, height = 6) 
                                        
Plot_Times<-as.POSIXct(TW_PZ_06_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_Nov, aes(Plot_Times, TW_PZ_06_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_06_Nov.pdf", width = 12, height = 6)
 

# TW_PZ_08
Plot_Times<-as.POSIXct(TW_PZ_08_3_3[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_3_3, aes(Plot_Times, TW_PZ_08_3_3[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.8,-.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))              
ggsave("TW_PZ_08_3_3.pdf", width = 12, height = 6)

Plot_Times<-as.POSIXct(TW_PZ_08_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_Nov, aes(Plot_Times, TW_PZ_08_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                      
ggsave("TW_PZ_08_Nov.pdf", width = 12, height = 6)

#Plot_Times<-as.POSIXct(TW_PZ_08_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
#ggplot(TW_PZ_08_Nov, aes(Plot_Times, TW_PZ_08_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_line(aes(x=Plot_Times, y=TW_PZ_08_Nov[,"denoised"]), color="orange3", size=.6)                       
#ggsave("TW_PZ_08_Nov.pdf", width = 12, height = 6)

# TW_PZ_09
Plot_Times<-as.POSIXct(TW_PZ_09_5_6[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_09_5_6, aes(Plot_Times, TW_PZ_09_5_6[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_09")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1,0)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_09_5_6.pdf", width = 12, height = 6)

Plot_Times<-as.POSIXct(TW_PZ_09_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_09_Nov, aes(Plot_Times, TW_PZ_09_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_09")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.8,0)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                       
ggsave("TW_PZ_09_Nov.pdf", width = 12, height = 6)

# TW_PZ_03
Plot_Times<-as.POSIXct(TW_PZ_03_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_03_Nov, aes(Plot_Times, TW_PZ_03_Nov[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_PZ_03_Nov.pdf", width = 12, height = 6)

# TW_PZ_07
Plot_Times<-as.POSIXct(TW_PZ_07_3_19[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_3_19, aes(Plot_Times, TW_PZ_07_3_19[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0,.3) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_07_3_19.pdf", width = 12, height = 6)  

Plot_Times<-as.POSIXct(TW_PZ_07_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_Nov, aes(Plot_Times, TW_PZ_07_Nov[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_PZ_07_Nov.pdf", width = 12, height = 6)

#Plot_Times<-as.POSIXct(TW_PZ_07_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
#ggplot(TW_PZ_07_Nov, aes(Plot_Times, TW_PZ_07_Nov[,"m_stage"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
#ggsave("TW_PZ_07_Nov.pdf", width = 12, height = 6)

# TW_SW_02
Plot_Times<-as.POSIXct(TW_SW_02_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_02_Nov, aes(Plot_Times, TW_SW_02_Nov[,"m_water"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_02_Nov.pdf", width = 12, height = 6)
                      
# TW_SW_04
Plot_Times<-as.POSIXct(TW_SW_04_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_Nov, aes(Plot_Times, TW_SW_04_Nov[,"m_water"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_04_Nov.pdf", width = 12, height = 6)
                                            
# TW_SW_07
Plot_Times<-as.POSIXct(TW_SW_07_3_3[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_3_3, aes(Plot_Times, TW_SW_07_3_3[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.4) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_07_3_3.pdf", width = 12, height = 6)       

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
                                         
##################################################### GET SPATIAL DATA ####################################################################################

# Load Lidar data from mass gis for the Tidmarsh site region:
# https://docs.digital.mass.gov/dataset/massgis-data-digital-elevation-model-15000                                         
setwd('C:/Users/erikai94/Desktop/19TCG690410.img') 
Ground_Surface<-raster('19TCG690410.img')
# Tighten the border around the bog
TW_border <- extent(369000, 369600, 4641200, 4642000)
Ground_Surface<-crop(Ground_Surface, TW_border)

# Load spatial data for the piezometers 
setwd('C:/Users/erikai94/Desktop') 
PZ_latlong<- readOGR(dsn = ".", layer = "TESt2")
plot(Ground_Surface, zlim=c(0,12))
plot(PZ_latlong, add=TRUE) 
# Extract the elevation data for each piezometer point
PZ_position<-as.data.frame(cbind(PZ_latlong[,c("Piezometer", "Lat","Long")], extract(Ground_Surface, PZ_latlong)))   
colnames(PZ_position)<-c("PZ", "Lat","Long", "Elev_m", "coordsx1", "coordsx2")

# Load spatial data for peat depth 
setwd('C:/Users/erikai94/Documents/UMass/Tidmarsh/elevations/elevations/Data') 
peat<- readOGR(dsn = ".", layer = "DEPTH_TO_PEAT")
plot(Ground_Surface, zlim=c(0,12))
plot(peat, add=TRUE) 
# Extract the elevation data for each peat depth point
Peat<-as.data.frame(cbind(peat, extract(Ground_Surface, peat)))  
colnames(Peat)<-c("Depth","Elev","x","y")
Peat[,"m_below_GS"]<-as.numeric(as.character(Peat[,"Elev"]))-(as.numeric(as.character(Peat[,"Depth"]))*0.3048)
      
##################################################### CONVERT WATER LEVEL DATA TO WATER ELEVATION DATA ####################################################################################
                     
# TW_PZ_01
PZ1<-which(PZ_position[,"PZ"]=="TW_PZ_01")
TW_PZ_01_Nov[,"coordsx1"]<-PZ_position[PZ1,"coordsx1"]
TW_PZ_01_Nov[,"coordsx2"]<-PZ_position[PZ1,"coordsx2"]
TW_PZ_01_Nov[,"PZ_Elev_m"]<-PZ_position[PZ1,"Elev_m"]                    
TW_PZ_01_Nov[,"WL_Elev_m"]<-TW_PZ_01_Nov[,"PZ_Elev_m"]-TW_PZ_01_Nov[,"m_below_GS"] 

# TW_PZ_05
PZ5<-which(PZ_position[,"PZ"]=="TW_PZ_05")
TW_PZ_05_Nov[,"coordsx1"]<-PZ_position[PZ5,"coordsx1"]
TW_PZ_05_Nov[,"coordsx2"]<-PZ_position[PZ5,"coordsx2"]
TW_PZ_05_Nov[,"PZ_Elev_m"]<-PZ_position[PZ5,"Elev_m"]                    
TW_PZ_05_Nov[,"WL_Elev_m"]<-TW_PZ_05_Nov[,"PZ_Elev_m"]-TW_PZ_05_Nov[,"m_below_GS"]    

# TW_PZ_06
PZ6<-which(PZ_position[,"PZ"]=="TW_PZ_06")
TW_PZ_06_Nov[,"coordsx1"]<-PZ_position[PZ6,"coordsx1"]
TW_PZ_06_Nov[,"coordsx2"]<-PZ_position[PZ6,"coordsx2"]
TW_PZ_06_Nov[,"PZ_Elev_m"]<-PZ_position[PZ6,"Elev_m"]                    
TW_PZ_06_Nov[,"WL_Elev_m"]<-TW_PZ_06_Nov[,"PZ_Elev_m"]-TW_PZ_06_Nov[,"m_below_GS"]       

# TW_PZ_08
PZ8<-which(PZ_position[,"PZ"]=="TW_PZ_08")
TW_PZ_08_Nov[,"coordsx1"]<-PZ_position[PZ8,"coordsx1"]
TW_PZ_08_Nov[,"coordsx2"]<-PZ_position[PZ8,"coordsx2"]
TW_PZ_08_Nov[,"PZ_Elev_m"]<-PZ_position[PZ8,"Elev_m"]                    
TW_PZ_08_Nov[,"WL_Elev_m"]<-TW_PZ_08_Nov[,"PZ_Elev_m"]-TW_PZ_08_Nov[,"denoised"]              
                   
# TW_PZ_09
PZ9<-which(PZ_position[,"PZ"]=="TW_PZ_09")
TW_PZ_09_Nov[,"coordsx1"]<-PZ_position[PZ9,"coordsx1"]
TW_PZ_09_Nov[,"coordsx2"]<-PZ_position[PZ9,"coordsx2"]
TW_PZ_09_Nov[,"PZ_Elev_m"]<-PZ_position[PZ9,"Elev_m"]                    
TW_PZ_09_Nov[,"WL_Elev_m"]<-TW_PZ_09_Nov[,"PZ_Elev_m"]-TW_PZ_09_Nov[,"m_below_GS"]  

# TW_PZ_03
PZ3<-which(PZ_position[,"PZ"]=="TW_PZ_03")
TW_PZ_03_Nov[,"coordsx1"]<-PZ_position[PZ3,"coordsx1"]
TW_PZ_03_Nov[,"coordsx2"]<-PZ_position[PZ3,"coordsx2"]
TW_PZ_03_Nov[,"PZ_Elev_m"]<-PZ_position[PZ3,"Elev_m"]                    
TW_PZ_03_Nov[,"WL_Elev_m"]<-TW_PZ_03_Nov[,"PZ_Elev_m"]+TW_PZ_03_Nov[,"m_stage"]  

# TW_PZ_07
PZ7<-which(PZ_position[,"PZ"]=="TW_PZ_07")
TW_PZ_07_Nov[,"coordsx1"]<-PZ_position[PZ7,"coordsx1"]
TW_PZ_07_Nov[,"coordsx2"]<-PZ_position[PZ7,"coordsx2"]
TW_PZ_07_Nov[,"PZ_Elev_m"]<-PZ_position[PZ7,"Elev_m"]                    
TW_PZ_07_Nov[,"WL_Elev_m"]<-TW_PZ_07_Nov[,"PZ_Elev_m"]+TW_PZ_07_Nov[,"m_stage"]       

# TW_SW_02
SW2<-which(PZ_position[,"PZ"]=="TW_SW_02")
TW_SW_02_Nov[,"coordsx1"]<-PZ_position[SW2,"coordsx1"]
TW_SW_02_Nov[,"coordsx2"]<-PZ_position[SW2,"coordsx2"]
TW_SW_02_Nov[,"PZ_Elev_m"]<-PZ_position[SW2,"Elev_m"]                    
TW_SW_02_Nov[,"WL_Elev_m"]<-TW_SW_02_Nov[,"PZ_Elev_m"]+TW_SW_02_Nov[,"m_water"]    

# TW_SW_04
SW4<-which(PZ_position[,"PZ"]=="TW_SW_04")
TW_SW_04_Nov[,"coordsx1"]<-PZ_position[SW4,"coordsx1"]
TW_SW_04_Nov[,"coordsx2"]<-PZ_position[SW4,"coordsx2"]
TW_SW_04_Nov[,"PZ_Elev_m"]<-PZ_position[SW4,"Elev_m"]                    
TW_SW_04_Nov[,"WL_Elev_m"]<-TW_SW_04_Nov[,"PZ_Elev_m"]+TW_SW_04_Nov[,"m_water"] 
                       
# TW_SW_07
SW7<-which(PZ_position[,"PZ"]=="TW_SW_07")
TW_SW_07_Nov[,"coordsx1"]<-PZ_position[SW7,"coordsx1"]
TW_SW_07_Nov[,"coordsx2"]<-PZ_position[SW7,"coordsx2"]
TW_SW_07_Nov[,"PZ_Elev_m"]<-PZ_position[SW7,"Elev_m"]                    
TW_SW_07_Nov[,"WL_Elev_m"]<-TW_SW_07_Nov[,"PZ_Elev_m"]+TW_SW_07_Nov[,"m_water"]    
                       
# TW_PZ_05_SAND
SND5<-which(PZ_position[,"PZ"]=="TW_PZ_05_SAND")
TW_PZ_05_SAND_Nov[,"coordsx1"]<-PZ_position[SND5,"coordsx1"]
TW_PZ_05_SAND_Nov[,"coordsx2"]<-PZ_position[SND5,"coordsx2"]
TW_PZ_05_SAND_Nov[,"PZ_Elev_m"]<-PZ_position[SND5,"Elev_m"]                    
TW_PZ_05_SAND_Nov[,"WL_Elev_m"]<-TW_PZ_05_SAND_Nov[,"PZ_Elev_m"]-TW_PZ_05_SAND_Nov[,"m_below_GS"]                                         
                         
# TW_PZ_06_SAND
SND6<-which(PZ_position[,"PZ"]=="TW_PZ_06_SAND")
TW_PZ_06_SAND_Nov[,"coordsx1"]<-PZ_position[SND6,"coordsx1"]
TW_PZ_06_SAND_Nov[,"coordsx2"]<-PZ_position[SND6,"coordsx2"]
TW_PZ_06_SAND_Nov[,"PZ_Elev_m"]<-PZ_position[SND6,"Elev_m"]                    
TW_PZ_06_SAND_Nov[,"WL_Elev_m"]<-TW_PZ_06_SAND_Nov[,"PZ_Elev_m"]-TW_PZ_06_SAND_Nov[,"denoised"]                                         
                       


# Set the same start and end dates for all piezometers                                          
TW_PZ_01_Nov<-TW_PZ_01_Nov[which(TW_PZ_01_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_PZ_01_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_PZ_02_Nov<-TW_PZ_02_Nov[which(TW_PZ_02_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_PZ_02_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_PZ_03_Nov<-TW_PZ_03_Nov[which(TW_PZ_03_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_PZ_03_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_PZ_04_Nov<-TW_PZ_04_Nov[which(TW_PZ_04_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_PZ_04_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_PZ_05_Nov<-TW_PZ_05_Nov[which(TW_PZ_05_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_PZ_05_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_PZ_06_Nov<-TW_PZ_06_Nov[which(TW_PZ_06_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_PZ_06_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_PZ_07_Nov<-TW_PZ_07_Nov[which(TW_PZ_07_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_PZ_07_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_PZ_08_Nov<-TW_PZ_08_Nov[which(TW_PZ_08_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_PZ_08_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_PZ_09_Nov<-TW_PZ_09_Nov[which(TW_PZ_09_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_PZ_09_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_SW_02_Nov<-TW_SW_02_Nov[which(TW_SW_02_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_SW_02_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_SW_03_Nov<-TW_SW_03_Nov[which(TW_SW_03_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_SW_03_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_SW_04_Nov<-TW_SW_04_Nov[which(TW_SW_04_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_SW_04_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_SW_07_Nov<-TW_SW_07_Nov[which(TW_SW_07_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_SW_07_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_PZ_05_SAND_Nov<-TW_PZ_05_SAND_Nov[which(TW_PZ_05_SAND_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_PZ_05_SAND_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]
TW_PZ_06_SAND_Nov<-TW_PZ_06_SAND_Nov[which(TW_PZ_06_SAND_Nov[,"Date_Time"]=="08/05/18 02:00:00 PM"):which(TW_PZ_06_SAND_Nov[,"Date_Time"]=="11/15/18 02:00:00 PM"),]       
  
# Subset matrices to only sample every fourth hour 
# Deep piezometers                    
TW_PZ_01_Nov<-TW_PZ_01_Nov[seq(1,9793,16),]
TW_PZ_02_Nov<-TW_PZ_02_Nov[seq(1,9793,16),]
TW_PZ_03_Nov<-TW_PZ_03_Nov[seq(1,9793,16),]
TW_PZ_04_Nov<-TW_PZ_04_Nov[seq(1,9793,16),]
TW_PZ_05_Nov<-TW_PZ_05_Nov[seq(1,9793,16),]
TW_PZ_06_Nov<-TW_PZ_06_Nov[seq(1,9793,16),]
TW_PZ_07_Nov<-TW_PZ_07_Nov[seq(1,9793,16),]
TW_PZ_08_Nov<-TW_PZ_08_Nov[seq(1,9793,16),]
TW_PZ_09_Nov<-TW_PZ_09_Nov[seq(1,9793,16),]

# Shallow piezometers
TW_SW_02_Nov<-TW_SW_02_Nov[seq(1,9793,16),]
TW_SW_03_Nov<-TW_SW_03_Nov[seq(1,9793,16),]
TW_SW_04_Nov<-TW_SW_04_Nov[seq(1,9793,16),]
TW_SW_07_Nov<-TW_SW_07_Nov[seq(1,9793,16),]
TW_PZ_05_SAND_Nov<-TW_PZ_05_SAND_Nov[seq(1,9793,16),]
TW_PZ_06_SAND_Nov<-TW_PZ_06_SAND_Nov[seq(1,9793,16),]       

# Bind all of the water elevation columns from each well into a single time series matrix
PZ_Surface<-as.data.frame(cbind(TW_PZ_01_Nov[,"Date_Time"], TW_PZ_01_Nov[,"WL_Elev_m"], TW_PZ_03_Nov[,"WL_Elev_m"], TW_PZ_05_Nov[,"WL_Elev_m"], TW_PZ_06_Nov[,"WL_Elev_m"], TW_PZ_07_Nov[,"WL_Elev_m"], TW_PZ_08_Nov[,"WL_Elev_m"], TW_PZ_09_Nov[,"WL_Elev_m"]))
colnames(PZ_Surface)<-c("Date_Time", "01_WL_Elev_m", "03_WL_Elev_m", "05_WL_Elev_m", "06_WL_Elev_m", "07_WL_Elev_m", "08_WL_Elev_m", "09_WL_Elev_m")
WT_Surface<-as.data.frame(cbind(TW_SW_02_Nov[,"Date_Time"], TW_SW_02_Nov[,"WL_Elev_m"], TW_SW_04_Nov[,"WL_Elev_m"], TW_SW_07_Nov[,"WL_Elev_m"], TW_PZ_05_SAND_Nov[,"WL_Elev_m"], TW_PZ_06_SAND_Nov[,"WL_Elev_m"]))
colnames(WT_Surface)<-c("Date_Time", "02_WT_Elev_m", "04_WT_Elev_m", "07_WT_Elev_m", "05_WT_Elev_m", "06_WT_Elev_m")

setwd('C:/Users/erikai94/Documents/UMass/Tidmarsh/elevations/elevations')   
# Transpose PZ_Surface in excel and add lat/long data
PZ_Surface2<-read.csv('PZ_Surface2.csv')
WT_Surface2<-read.csv('WT_Surface_2.csv')

                    
YValues<-seq(41.913,41.918,0.001)
XValues<-seq(-70.58,-70.57,0.001)


# PZ GRID
Grid1<-expand.grid(XValues,YValues)
Grid1<-cbind(Grid1,matrix(NA,nrow=nrow(Grid1),ncol=length(3:ncol(PZ_Surface2))))
colnames(Grid1)<-c("x","y",colnames(PZ_Surface2)[3:ncol(PZ_Surface2)])

for (i in 1:ncol(PZ_Surface2)) {
        print(i)
        Surface<-vector("numeric",length=nrow(Grid1))
        for(j in 1:nrow(Grid1)) {
                Weights<-vector("numeric",length=nrow(PZ_Surface2))
                for (q in 1:nrow(PZ_Surface2)) {
                        Weights[q]<-1/(geosphere::distGeo(Grid1[j,1:2],PZ_Surface2[q,c("x","y")])^2)
                        }
                Percentages<-Weights/sum(Weights)
                Surface[j]<-sum(Percentages*PZ_Surface2[,i])
                }
        Grid1[,i]<-Surface
        }

vals <- unique(scales::rescale(c(volcano)))
o <- order(vals, decreasing = FALSE)
cols <- scales::col_numeric("Blues", domain = NULL)(vals)
colz <- setNames(data.frame(vals[o], cols[o]), NULL)

for (i in 3:ncol(Grid1)){
     p<-plot_ly(x = Grid1$x, y = Grid1$y, z = Grid1[,i], type="contour", colorscale=colz)  %>% layout(title=TW_PZ_01_Nov[i-2,"Date_Time"])
    orca(p, paste("C:/Users/erikai94/Documents/UMass/Tidmarsh/elevations/elevations/PZ_Plots/surface-plot", i-2,".png",sep=""))
}


for (i in 3:ncol(Grid)){
p<-plot_ly(x = Grid$x, y = Grid$y, z = Grid[,i], type="contour", colorscale=colz)  %>% layout(title=TW_PZ_01_Nov[i-2,"Date_Time"])
plotly_IMAGE(p, format = "png", out_file = paste("C:/Users/erikai94/Documents/UMass/Tidmarsh/elevations/elevations/PZ_Plots/surface-plot.png",i-1,sep=""))
 }
  

YValues<-seq(41.913,41.918,0.001)
XValues<-seq(-70.58,-70.57,0.001)


# PZ GRID
Grid<-expand.grid(XValues,YValues)
Grid<-cbind(Grid,matrix(NA,nrow=nrow(Grid),ncol=length(3:ncol(WT_Surface2))))
colnames(Grid)<-c("x","y",colnames(WT_Surface2)[3:ncol(WT_Surface2)])

for (i in 1:ncol(WT_Surface2)) {
        print(i)
        Surface<-vector("numeric",length=nrow(Grid))
        for(j in 1:nrow(Grid)) {
                Weights<-vector("numeric",length=nrow(WT_Surface2))
                for (q in 1:nrow(WT_Surface2)) {
                        Weights[q]<-1/(geosphere::distGeo(Grid[j,1:2],WT_Surface2[q,c("x","y")])^2)
                        }
                Percentages<-Weights/sum(Weights)
                Surface[j]<-sum(Percentages*WT_Surface2[,i])
                }
        Grid[,i]<-Surface
        }

for (i in 3:ncol(Grid)){
     p<-plot_ly(x = Grid$x, y = Grid$y, z = Grid[,i], type="contour", colorscale=colz)  %>% layout(title=TW_PZ_01_Nov[i-2,"Date_Time"])
    orca(p, paste("C:/Users/erikai94/Documents/UMass/Tidmarsh/elevations/elevations/PZ_Plots/surface-plot", i-2,".png",sep=""))
}

which(TW_PZ_01_Nov[,"Date_Time"]=="08/11/18 02:00:00 AM")                       
plot_ly(x = Grid$y, y = Grid$x, z = Grid[,34+2], type="contour", colorscale=colz)  %>% layout(title=TW_PZ_01_Nov[34,"Date_Time"])                       
                       
Grid3<-Grid1-Grid
