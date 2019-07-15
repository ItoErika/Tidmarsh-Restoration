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

# sn 10499242?
TW_PZ_01_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW-PZ-01_sn10499234.csv", skip=1, row.names=1)
TW_PZ_01_SAND_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW-PZ-01-SAND_sn_10499243.csv", skip=1, row.names=1)
TW_PZ_02_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW_PZ_02.csv", skip=1, row.names=1)
TW_SW_02_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW-SW-02_sn10499246.csv", skip=1, row.names=1)
TW_PZ_03_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW-PZ-03_sn10499228.csv", skip=1, row.names=1)
TW_SW_03_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW_SW_03.csv", skip=1, row.names=1)
TW_PZ_04_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW_PZ_04.csv", skip=1, row.names=1)
TW_SW_04_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW-SW-04_sn10499238.csv", skip=1, row.names=1)
# TW_PZ_05_SAND_TP_PZ_02?
TW_PZ_05_SAND_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW-PZ-05-SAND_sn10499236.csv", skip=1, row.names=1)
TW_PZ_06_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW-PZ-06_sn10499244.csv", skip=1, row.names=1)
TW_PZ_06_SAND_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW-PZ-06-SAND_sn10499231.csv", skip=1, row.names=1)
TW_PZ_07_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW-PZ-07_sn10499240.csv", skip=1, row.names=1)
TW_SW_07_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW-SW-07_sn10744415.csv", skip=1, row.names=1)
TW_PZ_08_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW-PZ-08_sn10499239.csv", skip=1, row.names=1)
TW_PZ_08_SAND_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW_PZ_08_SAND_sn_10499247.csv", skip=1, row.names=1)
TW_PZ_09_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/TW-PZ-09.csv", skip=1, row.names=1)
TW_SW_10_Jun319<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/TW-WL_2019_06_03/sn_10499233.csv", skip=1, row.names=1)


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
NOAA_Plymouth_Data<-read.table("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers/NOAA/8-9-17_to_6-3-2019/9777647952006dat.txt", fill=TRUE, header=TRUE)

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

TW_PZ_01_Jun319<-loggerProcess(TW_PZ_01_Jun319)  
TW_PZ_01_SAND_Jun319<-loggerProcess(TW_PZ_01_SAND_Jun319)
TW_PZ_02_Jun319<-loggerProcess(TW_PZ_02_Jun319)  
TW_SW_02_Jun319<-loggerProcess(TW_SW_02_Jun319)
TW_PZ_03_Jun319<-loggerProcess(TW_PZ_03_Jun319)  
TW_SW_03_Jun319<-loggerProcess(TW_SW_03_Jun319)  
TW_PZ_04_Jun319<-loggerProcess(TW_PZ_04_Jun319)
TW_SW_04_Jun319<-loggerProcess(TW_SW_04_Jun319)  
TW_PZ_05_SAND_Jun319<-loggerProcess(TW_PZ_05_SAND_Jun319)
TW_PZ_06_Jun319<-loggerProcess(TW_PZ_06_Jun319)  
TW_PZ_06_SAND_Jun319<-loggerProcess(TW_PZ_06_SAND_Jun319)
TW_PZ_07_Jun319<-loggerProcess(TW_PZ_07_Jun319)  
TW_SW_07_Jun319<-loggerProcess(TW_SW_07_Jun319)
TW_PZ_08_Jun319<-loggerProcess(TW_PZ_08_Jun319)  
TW_PZ_08_SAND_Jun319<-loggerProcess(TW_PZ_08_SAND_Jun319)  
TW_PZ_09_Jun319<-loggerProcess(TW_PZ_09_Jun319)
TW_SW_10_Jun319<-loggerProcess(TW_SW_10_Jun319)
                      
                    
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
                       
# JUNE
TW_PZ_01_Jun319[,"m_below_GS"]<-130.4/100-(25.8/100+TW_PZ_01_Jun319[,"m_water"]) 
# Smooth the spikes in the data caused by logger removal during data downloading
# Interpolate between the 7/11 spike                       
Start_Spike<-which(TW_PZ_01_Jun319[,"Date_Time"]=="03/30/19 12:30:00 PM")
Stop_Spike<-which(TW_PZ_01_Jun319[,"Date_Time"]=="03/31/19 04:00:00 AM")     
Smoothed_Spike<-seq(TW_PZ_01_Jun319[Start_Spike,"m_below_GS"], TW_PZ_01_Jun319[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)
# Replace the spike with the smoothed interpolated data
TW_PZ_01_Jun319[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike 
# Add manual data
TW_PZ_01_Jun319[which(TW_PZ_01_Jun319[,"Date_Time"]=="03/30/19 12:30:00 PM"),"m_manual"]<-0.155 
TW_PZ_01_Jun319[which(TW_PZ_01_Jun319[,"Date_Time"]=="06/03/19 12:45:00 PM"),"m_manual"]<-0.106 
# Save as CSV  
write.csv(TW_PZ_01_Jun319, file="TWPZ01_11-20-18_to_6-3-19.csv", row.names=FALSE)                         
  

############## TW_PZ_01_SAND ############## 
            
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 130 cm
TW_PZ_01_SAND_Jun319[,"m_below_GS"]<-152.9/100-(130/100+TW_PZ_01_SAND_Jun319[,"m_water"]) 
# Add manual data
TW_PZ_01_SAND_Jun319[which(TW_PZ_01_SAND_Jun319[,"Date_Time"]=="03/30/19 12:15:00 PM"),"m_manual"]<-0.07
TW_PZ_01_SAND_Jun319[which(TW_PZ_01_SAND_Jun319[,"Date_Time"]=="06/03/19 01:00:00 PM"),"m_manual"]<-0.102
write.csv(TW_PZ_01_SAND_Jun319, file="TWPZ01_SAND_11-20-18_to_6-3-19.csv", row.names=FALSE)                         
                       
############## TW_PZ_02 ##############       
# Create a column for the depth to water below ground surface
TW_PZ_02_Nov[,"m_above_GS"]<-(TW_PZ_02_Nov[,"m_water"])-.6
# Remove the beginning of the dataset (where logger was not submerged) 
TW_PZ_02_Nov<-TW_PZ_02_Nov[which(TW_PZ_02_Nov[,"Date_Time"]=="07/12/18 11:00:00 AM"):nrow(TW_PZ_02_Nov),]
# Remove blank rows from logger extractions
TW_PZ_02_Nov<-TW_PZ_02_Nov[-which(is.na(TW_PZ_02_Nov[,"m_above_GS"])),] 
# Add manual data
TW_PZ_02_Nov[which(TW_PZ_02_Nov[,"Date_Time"]=="11/20/18 09:45:00 AM"),"m_manual"]<-0.562
# Save as CSV  
write.csv(TW_PZ_02_Nov, file="TWPZ02_7-12-18_to_11-20-18.csv", row.names=FALSE)  

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

# Create a column for the depth to water above ground surface
TW_PZ_02_Jun319[,"m_above_GS"]<-(TW_PZ_02_Jun319[,"m_water"])-.64 
# Add manual data
TW_PZ_02_Jun319[which(TW_PZ_02_Jun319[,"Date_Time"]=="03/30/19 04:45:00 PM"),"m_manual"]<-0.279
TW_PZ_02_Jun319[which(TW_PZ_02_Jun319[,"Date_Time"]=="06/03/19 12:15:00 PM"),"m_manual"]<-0.449 
# Save as CSV  
write.csv(TW_PZ_02_Jun319, file="TWPZ02_11-20-18_to_6-3-19.csv", row.names=FALSE)
                       
############## TW_SW_02 ##############     
# Create a column for the depth to water below ground surface
TW_SW_02_Nov[,"m_above_GS"]<-TW_SW_02_Nov[,"m_water"]-.15
# Remove last few rows of data 
TW_SW_02_Nov<-TW_SW_02_Nov[1:which(TW_SW_02_Nov[,"Date_Time"]=="11/20/18 10:30:00 AM"),]
# Add manual data
TW_SW_02_Nov[which(TW_SW_02_Nov[,"Date_Time"]=="06/19/18 02:45:00 PM"),"m_manual"]<-0.233 
TW_SW_02_Nov[which(TW_SW_02_Nov[,"Date_Time"]=="07/11/18 10:45:00 AM"),"m_manual"]<-0.33 
TW_SW_02_Nov[which(TW_SW_02_Nov[,"Date_Time"]=="11/20/18 10:00:00 AM"),"m_manual"]<-0.334
TW_SW_02_Nov[,"lat"]<-41.91389722
TW_SW_02_Nov[,"long"]<--70.57706944
# Save as CSV  
write.csv(TW_SW_02_Nov, file="TWSW02_6-18-18_to_11-20-18.csv", row.names=FALSE) 

#JUNE 3, 19                       
# Create a column for the depth to water above ground surface
TW_SW_02_Jun319[,"m_above_GS"]<-TW_SW_02_Jun319[,"m_water"]-.035
# Add manual data
TW_SW_02_Jun319[which(TW_SW_02_Jun319[,"Date_Time"]=="03/30/19 04:45:00 PM"),"m_manual"]<-0.224
TW_SW_02_Jun319[which(TW_SW_02_Jun319[,"Date_Time"]=="06/03/19 12:15:00 PM"),"m_manual"]<-0.22      
# Save as CSV  
write.csv(TW_SW_02_Jun319, file="TWSW02_11-20-18_to_6-3-19.csv", row.names=FALSE)    

############## TW_Grad_02 ##############
# Calculate the vertical gradient between PZ_02 and SW_02     
# Join the pz and sw files together by the "Date_Time" column
TW_Grad_02_Jun319<-join(TW_PZ_02_Jun319[,c("Date_Time","m_above_GS")], TW_SW_02_Jun319[,c("Date_Time","m_above_GS")], by="Date_Time")
# Rename the columns to designate between pz and sw water level values
 colnames(TW_Grad_02_Jun319)<-c( "Date_Time", "PZ_m_above_GS", "SW_m_above_GS")
# Define dh (difference in head values)
TW_Grad_02_Jun319[,"dh"]<--(TW_Grad_02_Jun319[,"PZ_m_above_GS"]-TW_Grad_02_Jun319[,"SW_m_above_GS"])
# Define dz (vertical distance between midpoint of screens)
TW_Grad_02_Jun319[,"dz"]<-1.29-0         
# Calculate the gradient (dh/dz) such that a positive gradient indicates downward flow
TW_Grad_02_Jun319[,"dh/dz"]<-TW_Grad_02_Jun319[,"dh"]/TW_Grad_02_Jun319[,"dz"]         
# Save as CSV  
write.csv(TW_Grad_02_Jun319, file="TWGrad02_11-20-18_to_6-3-19.csv", row.names=FALSE)    

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
   
# Create a column for the depth to water below ground surface
TW_PZ_03_Jun319[,"m_above_GS"]<-(TW_PZ_03_Jun319[,"m_water"])-.46
# Interpolate between the 3/30 spike                     
Start_Spike<-which(TW_PZ_03_Jun319[,"Date_Time"]=="03/30/19 03:45:00 PM")
Stop_Spike<-which(TW_PZ_03_Jun319[,"Date_Time"]=="03/30/19 04:15:00 PM")     
Smoothed_Spike<-seq(TW_PZ_03_Jun319[Start_Spike,"m_above_GS"], TW_PZ_03_Jun319[Stop_Spike,"m_above_GS"], length=Stop_Spike-Start_Spike+1) 
# Replace the spike with the smoothed interpolated data
TW_PZ_03_Jun319[Start_Spike:Stop_Spike,"m_above_GS"]<-Smoothed_Spike 
# Correct the vertical jump in data on 3/30
vert_shift_start<-which(TW_PZ_03_Jun319[,"Date_Time"]=="03/31/19 10:15:00 PM")
TW_PZ_03_Jun319[vert_shift_start:nrow(TW_PZ_03_Jun319),"m_above_GS"]<-TW_PZ_03_Jun319[vert_shift_start:nrow(TW_PZ_03_Jun319),"m_above_GS"]- 0.514                       
# Replace the portion of the data during the rise on 3/30 with NA 
Start_Blank<-which(TW_PZ_03_Jun319[,"Date_Time"]=="03/30/19 04:15:00 PM")
Stop_Blank<-which(TW_PZ_03_Jun319[,"Date_Time"]=="03/31/19 10:00:00 PM") 
TW_PZ_03_Jun319[Start_Blank:Stop_Blank,"m_above_GS"]<-NA
# Add manual data
TW_PZ_03_Jun319[which(TW_PZ_03_Jun319[,"Date_Time"]=="03/30/19 03:45:00 PM"),"m_manual"]<-0.279
TW_PZ_03_Jun319[which(TW_PZ_03_Jun319[,"Date_Time"]=="06/03/19 12:30:00 PM"),"m_manual"]<-0.29
# Save as CSV  
write.csv(TW_PZ_03_Jun319, file="TWPZ03_11-20-18_to_6-3-19.csv", row.names=FALSE)                         

############## TW_PZ_04 ##############  
# Create a column for the depth to water below ground surface
TW_PZ_04_Jun319[,"m_above_GS"]<-(TW_PZ_04_Jun319[,"m_water"])-1.03
# Correct the vertical jump in data on 3/30
vert_shift_start<-which(TW_PZ_04_Jun319[,"Date_Time"]=="03/30/19 03:15:00 PM")
TW_PZ_04_Jun319[vert_shift_start:nrow(TW_PZ_04_Jun319),"m_above_GS"]<-TW_PZ_04_Jun319[vert_shift_start:nrow(TW_PZ_04_Jun319),"m_above_GS"]- 0.05620621                      
# Make first and last row blank where logger was out of water
TW_PZ_04_Jun319[which(TW_PZ_04_Jun319[,"Date_Time"]=="11/20/18 09:15:00 AM"),"m_above_GS"]<-NA                      
TW_PZ_04_Jun319[which(TW_PZ_04_Jun319[,"Date_Time"]=="06/03/19 10:15:00 AM"),"m_above_GS"]<-NA                      
# Add manual data
TW_PZ_04_Jun319[which(TW_PZ_04_Jun319[,"Date_Time"]=="03/30/19 03:00:00 PM"),"m_manual"]<-0.29
TW_PZ_04_Jun319[which(TW_PZ_04_Jun319[,"Date_Time"]=="06/03/19 10:00:00 AM"),"m_manual"]<-0.292                       
# Save as CSV  
write.csv(TW_PZ_04_Jun319, file="TWPZ04_11-20-18_to_6-3-19_RISE.csv", row.names=FALSE)   

# Save another CSV without the rise 
TW_PZ_04_Jun319_norise<-TW_PZ_04_Jun319
# Replace the portion of the data during the rise on 3/30 with NA 
Start_Blank<-which(TW_PZ_04_Jun319_norise[,"Date_Time"]=="03/30/19 03:15:00 PM")
Stop_Blank<-which(TW_PZ_04_Jun319_norise[,"Date_Time"]=="04/23/19 12:00:00 AM") 
TW_PZ_04_Jun319_norise[Start_Blank:Stop_Blank,"m_above_GS"]<-NA
# Save as CSV  
write.csv(TW_PZ_04_Jun319_norise, file="TWPZ04_11-20-18_to_6-3-19.csv", row.names=FALSE)   

############## TW_SW_04 ##############     

# November 2018
# Correct based on manual stream measurements
TW_SW_04_Nov[,"m_above_GS"]<-TW_SW_04_Nov[,"m_water"]-.075
# Remove last few rows of data 
TW_SW_04_Nov<-TW_SW_04_Nov[1:which(TW_SW_04_Nov[,"Date_Time"]=="11/20/18 09:45:00 AM"),] 
# Add manual data
TW_SW_04_Nov[which(TW_SW_04_Nov[,"Date_Time"]=="08/16/18 08:45:00 AM"),"m_manual"]<-0.36
TW_SW_04_Nov[which(TW_SW_04_Nov[,"Date_Time"]=="11/20/18 09:15:00 AM"),"m_manual"]<-0.273 
TW_SW_04_Nov[,"lat"]<-41.91283611
TW_SW_04_Nov[,"long"]<--70.57670833
# Save as CSV  
write.csv(TW_SW_04_Nov, file="TWSW04_7-12-18_to_11-20-18.csv", row.names=FALSE) 

# June 2019
# Correct based on manual stream measurements
TW_SW_04_Jun319[,"m_above_GS"]<-TW_SW_04_Jun319[,"m_water"]-.075
# Add manual data
TW_SW_04_Jun319[which(TW_SW_04_Jun319[,"Date_Time"]=="03/30/19 03:00:00 PM"),"m_manual"]<-0.238
TW_SW_04_Jun319[which(TW_SW_04_Jun319[,"Date_Time"]=="06/03/19 10:00:00 AM"),"m_manual"]<-0.225 
# Save as CSV  
write.csv(TW_SW_04_Jun319, file="TWSW04_11-20-18_to_6-3-19.csv", row.names=FALSE) 

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

############## TW_PZ_05_SAND ##############    
TW_PZ_05_SAND_Nov[,"m_below_GS"]<-160/100-(105.5/100+TW_PZ_05_SAND_Nov[,"m_water"])  
# Remove last few rows of data 
TW_PZ_05_SAND_Nov<-TW_PZ_05_SAND_Nov[1:which(TW_PZ_05_SAND_Nov[,"Date_Time"]=="11/19/18 03:45:00 PM"),]
# Correct the vertical jump in data on 6/19 (date of logger retrieval); logger was in slightly different vertical position upon reinstallation
vert_shift_start<-which(TW_PZ_05_SAND_Nov[,"Date_Time"]=="06/19/18 03:15:00 PM")
TW_PZ_05_SAND_Nov[vert_shift_start:nrow(TW_PZ_05_SAND_Nov),"m_below_GS"]<-TW_PZ_05_SAND_Nov[vert_shift_start:nrow(TW_PZ_05_SAND_Nov),"m_below_GS"]-0.0970146
TW_PZ_05_SAND_Nov[,"lat"]<-41.91594
TW_PZ_05_SAND_Nov[,"long"]<--70.57631
# Interpolate between the 7/11 spike
Start_Spike<-which(TW_PZ_05_SAND_Nov[,"Date_Time"]=="07/11/18 02:30:00 PM")                     
Stop_Spike<-which(TW_PZ_05_SAND_Nov[,"Date_Time"]=="07/11/18 03:00:00 PM")     
Smoothed_Spike<-seq(TW_PZ_05_SAND_Nov[Start_Spike,"m_below_GS"], TW_PZ_05_SAND_Nov[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)  
# Replace the spike with the smoothed interpolated data
TW_PZ_05_SAND_Nov[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike  
# Add manual data
TW_PZ_05_SAND_Nov[which(TW_PZ_05_SAND_Nov[,"Date_Time"]=="06/19/18 03:00:00 PM"),"m_manual"]<-0.224                    
TW_PZ_05_SAND_Nov[which(TW_PZ_05_SAND_Nov[,"Date_Time"]=="07/11/18 02:30:00 PM"),"m_manual"]<-0.398
TW_PZ_05_SAND_Nov[which(TW_PZ_05_SAND_Nov[,"Date_Time"]=="11/19/18 03:00:00 PM"),"m_manual"]<-0.127 
# Save as CSV  
write.csv(TW_PZ_05_SAND_Nov, file="TWPZ05_SAND_6-18-18_to_11-19-18.csv", row.names=FALSE)  

# JUNE 
# This logger appeared to have filled or stopped logging before it was downloaded                      
TW_PZ_05_SAND_Jun319[,"m_below_GS"]<-150.2985/100-(105.5/100+TW_PZ_05_SAND_Jun319[,"m_water"])  
# Save as CSV  
write.csv(TW_PZ_05_SAND_Jun319, file="TWPZ05_SAND_11-19-18.csv", row.names=FALSE)  
                       
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

# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 32 cm
TW_PZ_06_Jun319[,"m_below_GS"]<-153/100-(31/100+TW_PZ_06_Jun319[,"m_water"])  
# Add manual data
TW_PZ_06_Jun319[which(TW_PZ_06_Jun319[,"Date_Time"]=="03/30/19 12:30:00 PM"),"m_manual"]<-0.152
TW_PZ_06_Jun319[which(TW_PZ_06_Jun319[,"Date_Time"]=="06/03/19 10:45:00 AM"),"m_manual"]<-0.145
# Save as CSV  
write.csv(TW_PZ_06_Jun319, file="TWPZ06_11-19-18_to_6-3-19_rise.csv", row.names=FALSE) 

# Save another file without the rise (WL recovery)
TW_PZ_06_Jun319_norise<-TW_PZ_06_Jun319
# Replace the portion of the data during the rise on 3/30 with NA 
Start_Blank<-which(TW_PZ_06_Jun319_norise[,"Date_Time"]=="03/30/19 03:15:00 PM")
Stop_Blank<-which(TW_PZ_06_Jun319_norise[,"Date_Time"]=="04/01/19 12:00:00 AM") 
TW_PZ_06_Jun319_norise[Start_Blank:Stop_Blank,"m_below_GS"]<-NA  
# Save as CSV  
write.csv(TW_PZ_06_Jun319_norise, file="TWPZ06_11-19-18_to_6-3-19.csv", row.names=FALSE)  


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
# Save as CSV  
write.csv(TW_PZ_06_SAND_Nov, file="TWPZ06_SAND_6-18-18_to_11-19-18.csv", row.names=FALSE)    

# June
TW_PZ_06_SAND_Jun319[,"m_below_GS"]<-150/100-(99/100+TW_PZ_06_SAND_Jun319[,"m_water"])  
# Add manual data
TW_PZ_06_SAND_Jun319[which(TW_PZ_06_SAND_Jun319[,"Date_Time"]=="03/30/19 12:30:00 PM"),"m_manual"]<-0.083
TW_PZ_06_SAND_Jun319[which(TW_PZ_06_SAND_Jun319[,"Date_Time"]=="06/03/19 10:45:00 AM"),"m_manual"]<-0.165
# Correct the vertical jump in data on 3/30
vert_shift_start<-which(TW_PZ_06_SAND_Jun319[,"Date_Time"]=="03/30/19 03:15:00 PM")
TW_PZ_06_SAND_Jun319[vert_shift_start:nrow(TW_PZ_06_SAND_Jun319),"m_below_GS"]<-TW_PZ_06_SAND_Jun319[vert_shift_start:nrow(TW_PZ_06_SAND_Jun319),"m_below_GS"]- 0.156                     
# Save as CSV  
write.csv(TW_PZ_06_SAND_Jun319, file="TWPZ06_SAND_11-19-18_to_6-3-19.csv", row.names=FALSE)                                         

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


# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 31 cm
TW_PZ_07_Jun319[,"m_above_GS"]<-(153/100-(31/100+TW_PZ_07_Jun319[,"m_water"]) )*-1   
# Interpolate between the 10/23 spike
Start_Spike<-which(TW_PZ_07_Jun319[,"Date_Time"]=="03/30/19 01:45:00 PM")                     
Stop_Spike<-which(TW_PZ_07_Jun319[,"Date_Time"]=="03/30/19 02:15:00 PM")     
Smoothed_Spike<-seq(TW_PZ_07_Jun319[Start_Spike,"m_above_GS"], TW_PZ_07_Jun319[Stop_Spike,"m_above_GS"], length=Stop_Spike-Start_Spike+1)  
# Replace the spike with the smoothed interpolated data
TW_PZ_07_Jun319[Start_Spike:Stop_Spike,"m_above_GS"]<-Smoothed_Spike  
# Remove last row of data where logger was not submerged
TW_PZ_07_Jun319[which(TW_PZ_07_Jun319[,"Date_Time"]=="06/03/19 09:30:00 AM"),"m_above_GS"]<-NA    
# Add manual data
TW_PZ_07_Jun319[which(TW_PZ_07_Jun319[,"Date_Time"]=="03/30/19 01:45:00 PM"),"m_manual"]<-0.111
TW_PZ_07_Jun319[which(TW_PZ_07_Jun319[,"Date_Time"]=="06/03/19 09:15:00 AM"),"m_manual"]<-0.185 
write.csv(TW_PZ_07_Jun319, file="TWPZ07_11-19-18_to_6-3-19.csv", row.names=FALSE) 
                  
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

# Correct based on manual stream measurements
TW_SW_07_Nov[,"m_above_GS"]<-TW_SW_07_Nov[,"m_water"]-.14
# Add manual data
TW_SW_07_Nov[which(TW_SW_07_Nov[,"Date_Time"]=="07/11/18 12:15:00 PM"),"m_manual"]<-0.28                     
TW_SW_07_Nov[which(TW_SW_07_Nov[,"Date_Time"]=="11/19/18 03:15:00 PM"),"m_manual"]<-0.21
# Remove last few rows of data 
TW_SW_07_Nov<-TW_SW_07_Nov[1:which(TW_SW_07_Nov[,"Date_Time"]=="11/19/18 05:00:00 PM"),]
# Remove blank rows from logger extractions
TW_SW_07_Nov<-TW_SW_07_Nov[-which(is.na(TW_SW_07_Nov[,"m_above_GS"])),]  
TW_SW_07_Nov[,"lat"]<-41.91708333
TW_SW_07_Nov[,"long"]<--70.57833333
write.csv(TW_SW_07_Nov, file="TWSW07_6-18-18_to_11-19-18.csv", row.names=FALSE) 

# Correct based on manual stream measurements
TW_SW_07_Jun319[,"m_above_GS"]<-TW_SW_07_Jun319[,"m_water"]-.1
# Add manual data
TW_SW_07_Jun319[which(TW_SW_07_Jun319[,"Date_Time"]=="03/30/19 01:45:00 PM"),"m_manual"]<-0.077                      
TW_SW_07_Jun319[which(TW_SW_07_Jun319[,"Date_Time"]=="06/03/19 09:15:00 AM"),"m_manual"]<-0.109
# Save as CSV
write.csv(TW_SW_07_Nov, file="TWSW07_6-18-18_to_11-19-18.csv", row.names=FALSE) 

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

# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 28 cm
TW_PZ_08_Jun319[,"m_below_GS"]<-116/100-(28/100+TW_PZ_08_Jun319[,"m_water"])
# Add manual data   
TW_PZ_08_Jun319[which(TW_PZ_08_Jun319[,"Date_Time"]=="06/03/19 09:00:00 AM"),"m_manual"]<-0.106
# Save as CSV
write.csv(TW_PZ_08_Jun319, file="TWPZ08_11-19-18_to_6-3-19_MALFUNC.csv", row.names=FALSE)    

############## TW_PZ_08_SAND ############## 

# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 110.7 cm
TW_PZ_08_SAND_Jun319[,"m_below_GS"]<-1.698-(110.7/100+TW_PZ_08_SAND_Jun319[,"m_water"])
# Correct the vertical jump in data on 6/19 (date of logger retrieval); logger was in slightly different vertical position upon reinstallation
vert_shift_start<-which(TW_PZ_08_SAND_Jun319[,"Date_Time"]=="03/30/19 02:30:00 PM")
TW_PZ_08_SAND_Jun319[vert_shift_start:nrow(TW_PZ_08_SAND_Jun319),"m_below_GS"]<-TW_PZ_08_SAND_Jun319[vert_shift_start:nrow(TW_PZ_08_SAND_Jun319),"m_below_GS"]+1.347573
# Add manual data   
TW_PZ_08_SAND_Jun319[which(TW_PZ_08_SAND_Jun319[,"Date_Time"]=="06/03/19 09:00:00 AM"),"m_manual"]<-0.18
# Save as CSV
write.csv(TW_PZ_08_SAND_Jun319, file="TWPZ08_SAND_11-19-18_to_6-3-19.csv", row.names=FALSE)                        

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
TW_PZ_09_Nov[,"m_below_GS"]<-163.5/100-(28/100+TW_PZ_09_Nov[,"m_water"])                       
# Note that there is a vertical shift in data on 7/11 due to an isotope extraction 
# Replace the portion of the data where logger was out of water on 7/11 with NA 
Start_Blank<-which(TW_PZ_09_Nov[,"Date_Time"]=="07/11/18 04:45:00 PM")
Stop_Blank<-which(TW_PZ_09_Nov[,"Date_Time"]=="07/11/18 05:15:00 PM") 
TW_PZ_09_Nov[Start_Blank:Stop_Blank,"m_below_GS"]<-NA   
# Correct the vertical jump in data on 7/11 (date of logger retrieval); logger was in slightly different vertical position upon reinstallation
vert_shift_start<-which(TW_PZ_09_Nov[,"Date_Time"]=="07/11/18 05:30:00 PM")
TW_PZ_09_Nov[vert_shift_start:nrow(TW_PZ_09_Nov),"m_below_GS"]<-TW_PZ_09_Nov[vert_shift_start:nrow(TW_PZ_09_Nov),"m_below_GS"]+ 0.04                                 
# Remove last few rows of data 
TW_PZ_09_Nov<-TW_PZ_09_Nov[1:which(TW_PZ_09_Nov[,"Date_Time"]=="11/19/18 03:30:00 PM"),]
TW_PZ_09_Nov[,"lat"]<-41.91705556
TW_PZ_09_Nov[,"long"]<--70.57588889
# Note that logger had to be removed for WL measurement on 7/11
TW_PZ_09_Nov[which(TW_PZ_09_Nov[,"Date_Time"]=="07/11/18 04:30:00 PM"),"m_manual"]<-0.513
TW_PZ_09_Nov[which(TW_PZ_09_Nov[,"Date_Time"]=="11/19/18 03:00:00 PM"),"m_manual"]<-0.403
# Save as CSV
write.csv(TW_PZ_09_Nov, file="TWPZ09_6-18-18_to_11-19-18.csv", row.names=FALSE) 

# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 28 cm
TW_PZ_09_Jun319[,"m_below_GS"]<-165/100-(28/100+TW_PZ_09_Jun319[,"m_water"])  
# Replace the portion of the data where logger was out of water on 3/30 with NA
TW_PZ_09_Jun319[which(TW_PZ_09_Jun319[,"Date_Time"]=="03/30/19 02:45:00 PM"),"m_below_GS"]<-NA    
# Correct the vertical jump in data on 3/30 (date of logger retrieval); logger was in slightly different vertical position upon reinstallation
vert_shift_start<-which(TW_PZ_09_Jun319[,"Date_Time"]=="03/30/19 03:00:00 PM")
TW_PZ_09_Jun319[vert_shift_start:nrow(TW_PZ_09_Jun319),"m_below_GS"]<-TW_PZ_09_Jun319[vert_shift_start:nrow(TW_PZ_09_Jun319),"m_below_GS"]-.114
# Remove the last row where logger was not submerged
TW_PZ_09_Jun319[which(TW_PZ_09_Jun319[,"Date_Time"]=="06/03/19 08:00:00 AM"),"m_below_GS"]<-NA    
# Add manual data
TW_PZ_09_Jun319[which(TW_PZ_09_Jun319[,"Date_Time"]=="03/30/19 02:30:00 PM"),"m_manual"]<-0.39
TW_PZ_09_Jun319[which(TW_PZ_09_Jun319[,"Date_Time"]=="06/03/19 07:45:00 AM"),"m_manual"]<-0.133     
# Save as CSV
write.csv(TW_PZ_09_Jun319, file="TWPZ09_11-19-18_to_6-3-19.csv", row.names=FALSE) 


############## TW_SW_10 ##############   
# Correct based on manual stream measurements
# Create a column for height of water above stream bed
TW_SW_10_Jun319[,"m_above_GS"]<-TW_SW_10_Jun319[,"m_water"]-.015 
# Remove the rows where logger was not submerged on 3/30
Start_Blank<-which(TW_SW_10_Jun319[,"Date_Time"]=="03/30/19 04:45:00 PM")
Stop_Blank<-which(TW_SW_10_Jun319[,"Date_Time"]=="03/30/19 05:00:00 PM") 
TW_SW_10_Jun319[Start_Blank:Stop_Blank,"m_above_GS"]<-NA   
# Add manual data
TW_SW_10_Jun319[which(TW_SW_10_Jun319[,"Date_Time"]=="03/30/19 04:30:00 PM"),"m_manual"]<-0.21
TW_SW_10_Jun319[which(TW_SW_10_Jun319[,"Date_Time"]=="06/03/19 12:00:00 PM"),"m_manual"]<-0.20    
# Save as CSV
write.csv(TW_SW_10_Jun319, file="TWSW10_11-19-18_to_6-3-19.csv", row.names=FALSE)                       
                       

############## TW_SW_03 ##############     
# Correct based on manual stream measurements
TW_SW_03_Jun319[,"m_above_GS"]<-TW_SW_03_Jun319[,"m_water"]-2
# Add manual data
TW_SW_03_Jun319[which(TW_SW_03_Jun319[,"Date_Time"]=="03/30/19 04:00:00 PM"),"m_manual"]<-0.204
TW_SW_03_Jun319[which(TW_SW_03_Jun319[,"Date_Time"]=="06/03/19 12:30:00 PM"),"m_manual"]<-0.245 
# Save as CSV  
write.csv(TW_SW_03_Jun319, file="TWSW03_11-20-18_to_6-3-19.csv", row.names=FALSE)                           

                     
##################################################### MAKE PLOTS ####################################################################################

#### TW_PZ_01 ####
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
                       
#June                       
Plot_Times<-as.POSIXct(TW_PZ_01_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_Jun319, aes(Plot_Times, TW_PZ_01_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_11-20-18_to_6-3-19.pdf", width = 12, height = 6)  
# With manual
Plot_Times<-as.POSIXct(TW_PZ_01_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_Jun319, aes(Plot_Times, TW_PZ_01_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_01_Jun319[,"m_manual"]), color="orange3", size=3)                            
ggsave("TW_PZ_01_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)

#### TW_PZ_01_SAND ####
Plot_Times<-as.POSIXct(TW_PZ_01_SAND_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_SAND_Jun319, aes(Plot_Times, TW_PZ_01_SAND_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.3,-.3)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_SAND_11-20-18_to_6-3-19.pdf", width = 12, height = 6)  
# With manual
Plot_Times<-as.POSIXct(TW_PZ_01_SAND_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_SAND_Jun319, aes(Plot_Times, TW_PZ_01_SAND_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.3,-.3)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_01_SAND_Jun319[,"m_manual"]), color="orange3", size=3)                            
ggsave("TW_PZ_01_SAND_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)  

# TW_PZ_02
Plot_Times<-as.POSIXct(TW_PZ_02_5_6[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_5_6, aes(Plot_Times, TW_PZ_02_5_6[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0.2,.6) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_02_3_24.pdf", width = 12, height = 6)  

Plot_Times<-as.POSIXct(TW_PZ_02_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_Nov, aes(Plot_Times, TW_PZ_02_Nov[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0,.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_02_Nov.pdf", width = 12, height = 6)  

Plot_Times<-as.POSIXct(TW_PZ_02_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_Jun319, aes(Plot_Times, TW_PZ_02_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0,.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_02_11-20-18_to_6-3-19.pdf", width = 12, height = 6) 

Plot_Times<-as.POSIXct(TW_PZ_02_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_Jun319, aes(Plot_Times, TW_PZ_02_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0,.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_02_Jun319[,"m_manual"]), color="orange3", size=3)                            
ggsave("TW_PZ_02_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)  

# TW_Grad_02
Plot_Times<-as.POSIXct(TW_Grad_02_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_02_Jun319, aes(Plot_Times, TW_Grad_02_Jun319[,"dh/dz"]))+geom_line(color='black', size=.6) + xlab("Date") + ylab("Vertical Hydraulic Gradient")+ scale_y_reverse(limits =c(0,-.3))+ ggtitle("TW_Gradient_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_Grad_02_11-20-18_to_6-3-19.pdf", width = 12, height = 6) 

# TW_PZ_03
Plot_Times<-as.POSIXct(TW_PZ_03_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_03_Nov, aes(Plot_Times, TW_PZ_03_Nov[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_PZ_03_Nov.pdf", width = 12, height = 6)

Plot_Times<-as.POSIXct(TW_PZ_03_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_03_Jun319, aes(Plot_Times, TW_PZ_03_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_PZ_03_11-20-18_to_6-3-19.pdf", width = 12, height = 6)

Plot_Times<-as.POSIXct(TW_PZ_03_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_03_Jun319, aes(Plot_Times, TW_PZ_03_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_03_Jun319[,"m_manual"]), color="orange3", size=3)                                                                           
ggsave("TW_PZ_03_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)

# TW_PZ_04
# uncorrected rise                        
Plot_Times<-as.POSIXct(TW_PZ_04_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_Jun319, aes(Plot_Times, TW_PZ_04_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(-.75,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))     
ggsave("TW_PZ_04_11-20-18_to_6-3-19_RISE.pdf", width = 12, height = 6)
# Add manual data
Plot_Times<-as.POSIXct(TW_PZ_04_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_Jun319, aes(Plot_Times, TW_PZ_04_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(-.75,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_04_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                
ggsave("TW_PZ_04_11-20-18_to_6-3-19_RISE_manual.pdf", width = 12, height = 6)

# removed rise
Plot_Times<-as.POSIXct(TW_PZ_04_Jun319_norise[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_Jun319_norise, aes(Plot_Times, TW_PZ_04_Jun319_norise[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                                                         
ggsave("TW_PZ_04_11-20-18_to_6-3-19.pdf", width = 12, height = 6)
# Add manual data
Plot_Times<-as.POSIXct(TW_PZ_04_Jun319_norise[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_Jun319_norise, aes(Plot_Times, TW_PZ_04_Jun319_norise[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_04_Jun319_norise[,"m_manual"]), color="orange3", size=3)                                                                           
ggsave("TW_PZ_04_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)

# TW_SW_04
Plot_Times<-as.POSIXct(TW_SW_04_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_Nov, aes(Plot_Times, TW_SW_04_Nov[,"m_water"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_04_Nov.pdf", width = 12, height = 6)

#June
Plot_Times<-as.POSIXct(TW_SW_04_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_Jun319, aes(Plot_Times, TW_SW_04_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_04_11-20-18_to_6-3-19.pdf", width = 12, height = 6)
# Add manual data
Plot_Times<-as.POSIXct(TW_SW_04_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_Jun319, aes(Plot_Times, TW_SW_04_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_04_Jun319[,"m_manual"]), color="orange3", size=3)                                                                           
ggsave("TW_SW_04_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)                                           


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

Plot_Times<-as.POSIXct(TW_PZ_06_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_Jun319, aes(Plot_Times, TW_PZ_06_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.8,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_06_11-19-18_to_6-3-19_RISE.pdf", width = 12, height = 6) 

Plot_Times<-as.POSIXct(TW_PZ_06_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_Jun319, aes(Plot_Times, TW_PZ_06_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.8,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_06_Jun319[,"m_manual"]), color="orange3", size=3)                                                                           
ggsave("TW_PZ_06_11-19-18_to_6-3-19_RISE_manual.pdf", width = 12, height = 6) 

Plot_Times<-as.POSIXct(TW_PZ_06_Jun319_norise[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_Jun319_norise, aes(Plot_Times, TW_PZ_06_Jun319_norise[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_06_11-19-18_to_6-3-19.pdf", width = 12, height = 6) 

Plot_Times<-as.POSIXct(TW_PZ_06_Jun319_norise[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_Jun319_norise, aes(Plot_Times, TW_PZ_06_Jun319_norise[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_06_Jun319_norise[,"m_manual"]), color="orange3", size=3)                                                                           
ggsave("TW_PZ_06_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6) 


# TW_PZ_06_SAND
Plot_Times<-as.POSIXct(TW_PZ_06_SAND_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_SAND_Nov, aes(Plot_Times, TW_PZ_06_SAND_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06_SAND_Nov")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_line(aes(x=Plot_Times, y=TW_PZ_06_SAND_Nov[,"denoised"]), color="orange3", size=.6)                                       
ggsave("TW_PZ_06_SAND_Nov.pdf", width = 12, height = 6)        

Plot_Times<-as.POSIXct(TW_PZ_06_SAND_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_SAND_Jun319, aes(Plot_Times, TW_PZ_06_SAND_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06_SAND_Nov")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1,-.5)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) 
ggsave("TW_PZ_06_SAND_11-19-18_to_6-3-19.pdf", width = 12, height = 6)   

Plot_Times<-as.POSIXct(TW_PZ_06_SAND_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_SAND_Jun319, aes(Plot_Times, TW_PZ_06_SAND_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06_SAND_Nov")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1,-.5)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_06_SAND_Jun319[,"m_manual"]), color="orange3", size=3)                                                                           
ggsave("TW_PZ_06_SAND_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6)  

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

Plot_Times<-as.POSIXct(TW_PZ_07_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_Jun319, aes(Plot_Times, TW_PZ_07_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_PZ_07_11-19-18_to_6-3-19.pdf", width = 12, height = 6)     

Plot_Times<-as.POSIXct(TW_PZ_07_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_Jun319, aes(Plot_Times, TW_PZ_07_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))  + geom_point(aes(x=Plot_Times, y=TW_PZ_07_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_PZ_07_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6)                
                                                      
# TW_SW_07
Plot_Times<-as.POSIXct(TW_SW_07_3_3[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_3_3, aes(Plot_Times, TW_SW_07_3_3[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.4) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_07_3_3.pdf", width = 12, height = 6)       

Plot_Times<-as.POSIXct(TW_SW_07_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_Nov, aes(Plot_Times, TW_SW_07_Nov[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_07_Nov.pdf", width = 12, height = 6) 

Plot_Times<-as.POSIXct(TW_SW_07_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_Nov, aes(Plot_Times, TW_SW_07_Nov[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_07_Nov[,"m_manual"]), color="orange3", size=3)                                                                                                                         
                                              
                                           

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

Plot_Times<-as.POSIXct(TW_PZ_08_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_Jun319, aes(Plot_Times, TW_PZ_08_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.8,-.4)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                      
ggsave("TW_PZ_08_11-19-18_to_6-3-19.pdf", width = 12, height = 6)

Plot_Times<-as.POSIXct(TW_PZ_08_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_Jun319, aes(Plot_Times, TW_PZ_08_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.8,-.4)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))   + geom_point(aes(x=Plot_Times, y=TW_PZ_08_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_PZ_08_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6)                 

# TW_PZ_08_SAND
Plot_Times<-as.POSIXct(TW_PZ_08_SAND_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_SAND_Jun319, aes(Plot_Times, TW_PZ_08_SAND_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.7,-0.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                                                                                      
ggsave("TW_PZ_08_SAND_11-19-18_to_6-3-19.pdf", width = 12, height = 6) 

Plot_Times<-as.POSIXct(TW_PZ_08_SAND_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_SAND_Jun319, aes(Plot_Times, TW_PZ_08_SAND_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.7,-0.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))   + geom_point(aes(x=Plot_Times, y=TW_PZ_08_SAND_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_PZ_08_SAND_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6)                 


# TW_PZ_09
Plot_Times<-as.POSIXct(TW_PZ_09_5_6[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_09_5_6, aes(Plot_Times, TW_PZ_09_5_6[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_09")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1,0)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_09_5_6.pdf", width = 12, height = 6)

Plot_Times<-as.POSIXct(TW_PZ_09_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_09_Nov, aes(Plot_Times, TW_PZ_09_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_09")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.9,0)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                       
ggsave("TW_PZ_09_6-18-18_to_11-19-18.pdf", width = 12, height = 6)

Plot_Times<-as.POSIXct(TW_PZ_09_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_09_Nov, aes(Plot_Times, TW_PZ_09_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_09")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.9,0)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))   + geom_point(aes(x=Plot_Times, y=TW_PZ_09_Nov[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_PZ_09_6-18-18_to_11-19-18_manual.pdf", width = 12, height = 6)   

Plot_Times<-as.POSIXct(TW_PZ_09_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_09_Jun319, aes(Plot_Times, TW_PZ_09_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_09")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1,0)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                       
ggsave("TW_PZ_09_11-19-18_to_6-3-19.pdf", width = 12, height = 6)

Plot_Times<-as.POSIXct(TW_PZ_09_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_09_Jun319, aes(Plot_Times, TW_PZ_09_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_09")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1,0)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))   + geom_point(aes(x=Plot_Times, y=TW_PZ_09_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_PZ_09_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6)                    
                 
# TW_SW_10
Plot_Times<-as.POSIXct(TW_SW_10_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_10_Jun319, aes(Plot_Times, TW_SW_10_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_10")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_10_11-19-18_to_6-3-19.pdf", width = 12, height = 6)       

Plot_Times<-as.POSIXct(TW_SW_10_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_10_Jun319, aes(Plot_Times, TW_SW_10_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_10")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_10_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_SW_10_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6) 



# TW_SW_02
Plot_Times<-as.POSIXct(TW_SW_02_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_02_Nov, aes(Plot_Times, TW_SW_02_Nov[,"m_water"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_02_Nov.pdf", width = 12, height = 6)

Plot_Times<-as.POSIXct(TW_SW_02_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_02_Nov, aes(Plot_Times, TW_SW_02_Nov[,"m_water"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_02_Nov.pdf", width = 12, height = 6)
                       
Plot_Times<-as.POSIXct(TW_SW_02_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_02_Jun319, aes(Plot_Times, TW_SW_02_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.7) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_02_11-20-18_to_6-3-19.pdf.pdf", width = 12, height = 6)

Plot_Times<-as.POSIXct(TW_SW_02_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_02_Jun319, aes(Plot_Times, TW_SW_02_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.7) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))   + geom_point(aes(x=Plot_Times, y=TW_SW_02_Jun319[,"m_manual"]), color="orange3", size=3)                                                                        
ggsave("TW_SW_02_11-20-18_to_6-3-19_manual.pdf.pdf", width = 12, height = 6)

# TW_SW_03
Plot_Times<-as.POSIXct(TW_SW_03_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_03_Jun319, aes(Plot_Times, TW_SW_03_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(-1,3) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_03_11-20-18_to_6-3-19.pdf", width = 12, height = 6)

Plot_Times<-as.POSIXct(TW_SW_03_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_03_Jun319, aes(Plot_Times, TW_SW_03_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(-1,3) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_03_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                                                      
ggsave("TW_SW_03_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)
                                      
                       
# TW_PZ_05_SAND
Plot_Times<-as.POSIXct(TW_PZ_05_SAND_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_SAND_Nov, aes(Plot_Times, TW_PZ_05_SAND_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05_SAND_Nov")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                       
ggsave("TW_PZ_05_SAND_Nov.pdf", width = 12, height = 6)     
##################################################### GET SPATIAL DATA ######################################

# Load LiDAR elevation / terrain data from MassGIS:
# Bare-earth Digital Surface Model (DSM) rasters (aka DEMs): 
# https://docs.digital.mass.gov/dataset/massgis-data-lidar-terrain-data#download
TW_LiDAR <- raster("C:/Users/erikai94/Documents/UMass/Tidmarsh/LiDAR/19_03694641.tif")
# Tighten the border around the bog
TW_border <- extent(369000, 369600, 4641200, 4642000)
TW_LiDAR<-crop(TW_LiDAR, TW_border)
# Reproject the raster into lat long (from UTM) 
projected_TW_LiDAR <- projectRaster(TW_LiDAR, crs = "+proj=longlat +datum=WGS84")
# Plot the piezometer points onto the raster
                       
                       
                       
