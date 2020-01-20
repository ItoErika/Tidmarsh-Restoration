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

# Set working directory
setwd('C:/Users/erikai94/Documents/UMass/Tidmarsh/PZ_Loggers')

# Load raw data (downloaded from pressure transducers)
TW_PZ_05_3_3<-read.csv("TW_WL_2018_03_04/TW-PZ-05_2018_03_03.csv", skip=1, row.names=1)
TW_PZ_08_3_3<-read.csv("TW_WL_2018_03_04/TW-PZ-08_2018_03_03.csv", skip=1, row.names=1)

TW_SW_07_3_3<-read.csv("TW_WL_2018_03_04/TW_SW_07_2018_03_03.csv", skip=1, row.names=1)

TW_PZ_01_3_19<-read.csv("TW_WL_2018_03_19/TW_PZ_01_2018_03_19.csv", skip=1, row.names=1)
TW_PZ_06_3_19<-read.csv("TW_WL_2018_03_19/TW_PZ_06_2018_03_19.csv", skip=1, row.names=1)
TW_PZ_07_3_19<-read.csv("TW_WL_2018_03_19/TW_PZ_07_2018_03_19.csv", skip=1, row.names=1)

TW_PZ_02_5_6<-read.csv("TW_WL_2018_05_06/TW_PZ_02.csv", skip=1, row.names=1)
TW_PZ_09_5_6<-read.csv("TW_WL_2018_05_06/TW-PZ-09.csv", skip=1, row.names=1)

# MAY 2018 LOGGER RETRIEVAL
TW_PZ_02_May2018<-read.csv("TW_WL_2018_05_06/TW_PZ_02.csv", skip=1, row.names=1)

# JUNE 18, 2018 LOGGER RETRIEVAL
TW_PZ_01_Jun2018<-read.csv("TW_WL_2018_06_18/TW-PZ-01_sn10499234.csv", skip=1, row.names=1)
TW_PZ_02_Jun2018<-read.csv("TW_WL_2018_06_18/TW_PZ_02.csv", skip=1, row.names=1)
TW_SW_02_Jun2018<-read.csv("TW_WL_2018_06_18/TW-SW-02_sn10499246.csv", skip=1, row.names=1)
TW_PZ_03_Jun2018<-read.csv("TW_WL_2018_06_18/TW-PZ-03_sn10499228.csv", skip=1, row.names=1)
TW_SW_03_Jun2018<-read.csv("TW_WL_2018_06_18/TW_SW_03.csv", skip=1, row.names=1)
TW_PZ_04_Jun2018<-read.csv("TW_WL_2018_06_18/TW_PZ_04.csv", skip=1, row.names=1)
TW_SW_04_Jun2018<-read.csv("TW_WL_2018_06_18/TW-SW-04_sn10499238.csv", skip=1, row.names=1)
TW_PZ_05_SAND_Jun2018<-read.csv("TW_WL_2018_06_18/TW-PZ-05-SAND_sn10499236.csv", skip=1, row.names=1)
TW_PZ_06_Jun2018<-read.csv("TW_WL_2018_06_18/TW-PZ-06_sn10499244.csv", skip=1, row.names=1)
TW_PZ_06_SAND_Jun2018<-read.csv("TW_WL_2018_06_18/TW-PZ-06-SAND_sn10499231.csv", skip=1, row.names=1)
TW_PZ_07_Jun2018<-read.csv("TW_WL_2018_06_18/TW-PZ-07_sn10499240.csv", skip=1, row.names=1)
TW_SW_07_Jun2018<-read.csv("TW_WL_2018_06_18/TW-SW-07_sn10744415.csv", skip=1, row.names=1)
TW_PZ_08_Jun2018<-read.csv("TW_WL_2018_06_18/TW-PZ-08_sn10499239.csv", skip=1, row.names=1)

# JULY 18, 2018 LOGGER RETRIEVAL
TW_PZ_02_Jul2018<-read.csv("TW_WL_2018_07_11/TW_PZ_02.csv", skip=1, row.names=1)
# There is an error in the PZ_03 (time stamps are all the same)
#TW_PZ_03_Jul2018<-read.csv("TW_WL_2018_07_11/TW-PZ-03_sn10499228.csv", skip=1, row.names=1)
TW_SW_04_Jul2018<-read.csv("TW_WL_2018_07_11/TW-SW-04_sn10499238.csv", skip=1, row.names=1)

# NOVEMBER 20, 2018 LOGGER RETRIEVAL
TW_PZ_01_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW-PZ-01_sn10499234_2018_11_20.csv", skip=1, row.names=1)
TW_PZ_02_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW_PZ_02_2018_11_20.csv", skip=1, row.names=1)
TW_SW_02_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW-SW-02_sn10499246_2018_11_20.csv", skip=1, row.names=1)
TW_PZ_03_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW-PZ-03_sn10499228_2018_11_20.csv", skip=1, row.names=1)
TW_SW_03_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW_SW_03_2018_11_20.csv", skip=1, row.names=1)
TW_PZ_03_8_17<-read.csv("Tidmarsh_TW_WL_2017_08_29/TW_PZ_03.csv", skip=1, row.names=1)
TW_PZ_04_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW_PZ_04_2018_11_20.csv", skip=1, row.names=1)
TW_SW_04_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW-SW-04_sn10499238_2018_11_20.csv", skip=1, row.names=1)
TW_PZ_05_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW-PZ-05_2018_11_19.csv", skip=1, row.names=1)
TW_PZ_05_SAND_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW-PZ-05-SAND_sn10499236_2018_11_19.csv", skip=1, row.names=1)
TW_PZ_06_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW-PZ-06_sn10499244_2018_11_19.csv", skip=1, row.names=1)
TW_PZ_06_SAND_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW-PZ-06-SAND_sn10499231_2018_11_19.csv", skip=1, row.names=1)
TW_PZ_07_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW-PZ-07_sn10499240_2018_11_19.csv", skip=1, row.names=1)
TW_SW_07_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW-SW-07_sn10744415_2018_11_19.csv", skip=1, row.names=1)
TW_PZ_08_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW-PZ-08_sn10499239_2018_11_19.csv", skip=1, row.names=1)
TW_PZ_09_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW-PZ-09_2018_11_19.csv", skip=1, row.names=1)
TW_SW_10_Nov2018<-read.csv("Tidmarsh_TW_WL_2018_11_20/TW-SW-10_2018_11_19_sn_10499233.csv", skip=1, row.names=1)

# JUNE 3, 2019 LOGGER RETRIEVAL
# sn 10499242?
TW_PZ_01_Jun319<-read.csv("TW-WL_2019_06_03/TW-PZ-01_sn10499234.csv", skip=1, row.names=1)
TW_PZ_01_SAND_Jun319<-read.csv("TW-WL_2019_06_03/TW-PZ-01-SAND_sn_10499243.csv", skip=1, row.names=1)
TW_PZ_02_Jun319<-read.csv("TW-WL_2019_06_03/TW_PZ_02.csv", skip=1, row.names=1)
TW_SW_02_Jun319<-read.csv("TW-WL_2019_06_03/TW-SW-02_sn10499246.csv", skip=1, row.names=1)
TW_PZ_03_Jun319<-read.csv("TW-WL_2019_06_03/TW-PZ-03_sn10499228.csv", skip=1, row.names=1)
TW_SW_03_Jun319<-read.csv("TW-WL_2019_06_03/TW_SW_03.csv", skip=1, row.names=1)
TW_PZ_04_Jun319<-read.csv("TW-WL_2019_06_03/TW_PZ_04.csv", skip=1, row.names=1)
TW_SW_04_Jun319<-read.csv("TW-WL_2019_06_03/TW-SW-04_sn10499238.csv", skip=1, row.names=1)
TW_PZ_05_Jun319<-read.csv("TW-WL_2019_06_03/TW-PZ-05_TP-PZ-02_sn1136668.csv", skip=1, row.names=1)
TW_PZ_05_SAND_Jun319<-read.csv("TW-WL_2019_06_03/TW-PZ-05-SAND_sn10499236.csv", skip=1, row.names=1)
TW_PZ_06_Jun319<-read.csv("TW-WL_2019_06_03/TW-PZ-06_sn10499244.csv", skip=1, row.names=1)
TW_PZ_06_SAND_Jun319<-read.csv("TW-WL_2019_06_03/TW-PZ-06-SAND_sn10499231.csv", skip=1, row.names=1)
TW_PZ_07_Jun319<-read.csv("TW-WL_2019_06_03/TW-PZ-07_sn10499240.csv", skip=1, row.names=1)
TW_SW_07_Jun319<-read.csv("TW-WL_2019_06_03/TW-SW-07_sn10744415.csv", skip=1, row.names=1)
TW_PZ_08_Jun319<-read.csv("TW-WL_2019_06_03/TW-PZ-08_sn10499239.csv", skip=1, row.names=1)
TW_PZ_08_SAND_Jun319<-read.csv("TW-WL_2019_06_03/TW_PZ_08_SAND_sn_10499247.csv", skip=1, row.names=1)
TW_PZ_09_Jun319<-read.csv("TW-WL_2019_06_03/TW-PZ-09.csv", skip=1, row.names=1)
TW_SW_10_Jun319<-read.csv("TW-WL_2019_06_03/sn_10499233.csv", skip=1, row.names=1)

# Load data from Plymouth Municipal Airport from NOAA
# This includes barometric pressure data (use to correct logger data) 
NOAA_Plymouth_Data<-read.table("NOAA/8-9-17_to_6-3-2019/9777647952006dat.txt", fill=TRUE, header=TRUE)

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
 
# MAY 2018 DATA
#TW_PZ_02_May2018<-loggerProcess(TW_PZ_02_May2018)
                       
# JUNE 2018 DATA                       
TW_PZ_01_Jun2018<-loggerProcess(TW_PZ_01_Jun2018)
TW_PZ_02_Jun2018<-loggerProcess(TW_PZ_02_Jun2018)
TW_SW_02_Jun2018<-loggerProcess(TW_SW_02_Jun2018)
TW_PZ_03_Jun2018<-loggerProcess(TW_PZ_03_Jun2018)
TW_SW_03_Jun2018<-loggerProcess(TW_SW_03_Jun2018)
TW_PZ_04_Jun2018<-loggerProcess(TW_PZ_04_Jun2018)
TW_SW_04_Jun2018<-loggerProcess(TW_SW_04_Jun2018)
TW_PZ_05_SAND_Jun2018<-loggerProcess(TW_PZ_05_SAND_Jun2018)
TW_PZ_06_Jun2018<-loggerProcess(TW_PZ_06_Jun2018)
TW_PZ_06_SAND_Jun2018<-loggerProcess(TW_PZ_06_SAND_Jun2018)
TW_PZ_07_Jun2018<-loggerProcess(TW_PZ_07_Jun2018)
TW_SW_07_Jun2018<-loggerProcess(TW_SW_07_Jun2018)
TW_PZ_08_Jun2018<-loggerProcess(TW_PZ_08_Jun2018)

# JULY 2018 DATA
TW_PZ_02_Jul2018<-loggerProcess(TW_PZ_02_Jul2018)
#TW_PZ_03_Jul2018<-loggerProcess(TW_PZ_03_Jul2018)
TW_SW_04_Jul2018<-loggerProcess(TW_SW_04_Jul2018)

# NOVEMBER 2018 DATA                      
TW_PZ_01_Nov2018<-loggerProcess(TW_PZ_01_Nov2018)
TW_PZ_02_Nov2018<-loggerProcess(TW_PZ_02_Nov2018)
TW_PZ_03_Nov2018<-loggerProcess(TW_PZ_03_Nov2018)
TW_PZ_03_8_17<-loggerProcess(TW_PZ_03_8_17)                      
TW_PZ_04_Nov2018<-loggerProcess(TW_PZ_04_Nov2018)
TW_PZ_05_Nov2018<-loggerProcess(TW_PZ_05_Nov2018)
TW_PZ_06_Nov2018<-loggerProcess(TW_PZ_06_Nov2018)
TW_PZ_07_Nov2018<-loggerProcess(TW_PZ_07_Nov2018)
TW_PZ_08_Nov2018<-loggerProcess(TW_PZ_08_Nov2018)
TW_PZ_09_Nov2018<-loggerProcess(TW_PZ_09_Nov2018)
TW_SW_02_Nov2018<-loggerProcess(TW_SW_02_Nov2018)
TW_SW_03_Nov2018<-loggerProcess(TW_SW_03_Nov2018)
TW_SW_04_Nov2018<-loggerProcess(TW_SW_04_Nov2018)
TW_SW_07_Nov2018<-loggerProcess(TW_SW_07_Nov2018)
TW_SW_10_Nov2018<-loggerProcess(TW_SW_10_Nov2018)
TW_PZ_05_SAND_Nov2018<-loggerProcess(TW_PZ_05_SAND_Nov2018)
TW_PZ_06_SAND_Nov2018<-loggerProcess(TW_PZ_06_SAND_Nov2018)                                     

# JUNE 2019 DATA
TW_PZ_01_Jun319<-loggerProcess(TW_PZ_01_Jun319)  
TW_PZ_01_SAND_Jun319<-loggerProcess(TW_PZ_01_SAND_Jun319)
TW_PZ_02_Jun319<-loggerProcess(TW_PZ_02_Jun319)  
TW_SW_02_Jun319<-loggerProcess(TW_SW_02_Jun319)
TW_PZ_03_Jun319<-loggerProcess(TW_PZ_03_Jun319)  
TW_SW_03_Jun319<-loggerProcess(TW_SW_03_Jun319)  
TW_PZ_04_Jun319<-loggerProcess(TW_PZ_04_Jun319)
TW_SW_04_Jun319<-loggerProcess(TW_SW_04_Jun319)  
TW_PZ_05_Jun319<-loggerProcess(TW_PZ_05_Jun319)
TW_PZ_05_SAND_Jun319<-loggerProcess(TW_PZ_05_SAND_Jun319)
TW_PZ_06_Jun319<-loggerProcess(TW_PZ_06_Jun319)  
TW_PZ_06_SAND_Jun319<-loggerProcess(TW_PZ_06_SAND_Jun319)
TW_PZ_07_Jun319<-loggerProcess(TW_PZ_07_Jun319)  
TW_SW_07_Jun319<-loggerProcess(TW_SW_07_Jun319)
TW_PZ_08_Jun319<-loggerProcess(TW_PZ_08_Jun319)  
TW_PZ_08_SAND_Jun319<-loggerProcess(TW_PZ_08_SAND_Jun319)  
TW_PZ_09_Jun319<-loggerProcess(TW_PZ_09_Jun319)
TW_SW_10_Jun319<-loggerProcess(TW_SW_10_Jun319)
                                               
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
                       
# JUNE 2018 
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 25.8 cm
TW_PZ_01_Jun2018[,"m_below_GS"]<-128.3/100-(25.8/100+TW_PZ_01_Jun2018[,"m_water"]) 
# Remove the beginning of the dataset (where logger was not submerged) 
TW_PZ_01_Jun2018<-TW_PZ_01_Jun2018[which(TW_PZ_01_Jun2018[,"Date_Time"]=="05/06/18 05:15:00 PM"):nrow(TW_PZ_01_Jun2018),]                       
# Remove the last rows of the data set where the logger was not submerged
Logger_not_Submerged<-which(TW_PZ_01_Jun2018[,"Date_Time"]=="06/18/18 10:00:00 AM")
TW_PZ_01_Jun2018<-TW_PZ_01_Jun2018[-(Logger_not_Submerged:nrow(TW_PZ_01_Jun2018)),]         
# Add manual data
TW_PZ_01_Jun2018[which(TW_PZ_01_Jun2018[,"Date_Time"]=="06/18/18 09:45:00 AM"),"m_manual"]<-.145    
# Save as CSV  
write.csv(TW_PZ_01_Jun2018, file="TW_WL_2018_06_18/processed/TWPZ01_5-6-18_to_6-18-18.csv", row.names=FALSE)          
                       
# NOVEMBER 2018                       
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 25.8 cm
TW_PZ_01_Nov2018[,"m_below_GS"]<-131/100-(25.8/100+TW_PZ_01_Nov2018[,"m_water"])
# Smooth the spikes in the data caused by logger removal during data downloading
# Interpolate between the 6/19 spike
Start_Spike<-which(TW_PZ_01_Nov2018[,"Date_Time"]=="06/19/18 01:00:00 PM")                     
Stop_Spike<-which(TW_PZ_01_Nov2018[,"Date_Time"]=="06/19/18 02:00:00 PM")     
Smoothed_Spike<-seq(TW_PZ_01_Nov2018[Start_Spike,"m_below_GS"], TW_PZ_01_Nov2018[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)
# Replace the spike with the smoothed interpolated data
TW_PZ_01_Nov2018[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike
# Interpolate between the 7/11 spike                       
Start_Spike<-which(TW_PZ_01_Nov2018[,"Date_Time"]=="07/11/18 08:45:00 AM")
Stop_Spike<-which(TW_PZ_01_Nov2018[,"Date_Time"]=="07/11/18 09:45:00 AM")     
Smoothed_Spike<-seq(TW_PZ_01_Nov2018[Start_Spike,"m_below_GS"], TW_PZ_01_Nov2018[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)
# Replace the spike with the smoothed interpolated data
TW_PZ_01_Nov2018[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike  
# Remove the first row of the dataset (the logger was not submerged)
TW_PZ_01_Nov2018<-TW_PZ_01_Nov2018[-1,]     
# Add manual data
TW_PZ_01_Nov2018[which(TW_PZ_01_Nov2018[,"Date_Time"]=="06/19/18 01:00:00 PM"),"m_manual"]<-0.158                       
TW_PZ_01_Nov2018[which(TW_PZ_01_Nov2018[,"Date_Time"]=="07/11/18 09:00:00 AM"),"m_manual"]<-0.06
TW_PZ_01_Nov2018[which(TW_PZ_01_Nov2018[,"Date_Time"]=="11/20/18 10:00:00 AM"),"m_manual"]<-0.037 
#TW_PZ_01_Nov2018[,"lat"]<-41.91347222 
#TW_PZ_01_Nov2018[,"long"]<--70.57844444    
# Save as CSV  
write.csv(TW_PZ_01_Nov2018, file="TWPZ01_6-18-18_to_11-20-18.csv", row.names=FALSE)  
                       
# JUNE 2019
TW_PZ_01_Jun319[,"m_below_GS"]<-130.4/100-(25.8/100+TW_PZ_01_Jun319[,"m_water"]) 
# Smooth the spikes in the data caused by logger removal during data downloading
# Will now leave 3/30 spike because it is a real dip due isotope sample retrieval
# Interpolate between the 3/30 spike                       
#Start_Spike<-which(TW_PZ_01_Jun319[,"Date_Time"]=="03/30/19 12:30:00 PM")
#Stop_Spike<-which(TW_PZ_01_Jun319[,"Date_Time"]=="03/31/19 04:00:00 AM")     
#Smoothed_Spike<-seq(TW_PZ_01_Jun319[Start_Spike,"m_below_GS"], TW_PZ_01_Jun319[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)
# Replace the spike with the smoothed interpolated data
#TW_PZ_01_Jun319[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike 
# Add manual data
TW_PZ_01_Jun319[which(TW_PZ_01_Jun319[,"Date_Time"]=="03/30/19 12:30:00 PM"),"m_manual"]<-0.155 
TW_PZ_01_Jun319[which(TW_PZ_01_Jun319[,"Date_Time"]=="06/03/19 12:45:00 PM"),"m_manual"]<-0.106   
# Remove last few rows of erroneous data
TW_PZ_01_Jun319<-TW_PZ_01_Jun319[1:which(TW_PZ_01_Jun319[,"Date_Time"]=="06/03/19 12:45:00 PM"),]                     
# Create a copy without the isotope sample dip:    
TW_PZ_01_Jun319_NO_ISO <-TW_PZ_01_Jun319 
Start_Iso<-which(TW_PZ_01_Jun319_NO_ISO[,"Date_Time"]=="03/30/19 12:30:00 PM")
Stop_Iso<-which(TW_PZ_01_Jun319_NO_ISO[,"Date_Time"]=="03/31/19 04:00:00 AM") 
# Replace the isotope dip with NA
TW_PZ_01_Jun319_NO_ISO[Start_Spike:Stop_Spike,"m_below_GS"]<-NA   
# Save as CSV  
write.csv(TW_PZ_01_Jun319, file="TW-WL_2019_06_03/June_6_19_Processed/TWPZ01_11-20-18_to_6-3-19.csv", row.names=FALSE)                         
write.csv(TW_PZ_01_Jun319_NO_ISO, file="TW-WL_2019_06_03/June_6_19_Processed/TWPZ01_11-20-18_to_6-3-19.csv", row.names=FALSE)                         

# Bind all of the data frames together...                  
TW_PZ_01_FULL<-rbind(TW_PZ_01_Jun2018, TW_PZ_01_Nov2018, TW_PZ_01_Jun319[1:which(TW_PZ_01_Jun319[,"Date_Time"]=="06/03/19 12:45:00 PM"),])                        
# Add tag in notes for where WL was recovering from isotope sampling
TW_PZ_01_FULL[which(TW_PZ_01_FULL[,"Date_Time"]=="03/30/19 12:45:00 PM"):which(TW_PZ_01_FULL[,"Date_Time"]=="03/31/19 04:00:00 AM"),"Notes"]<-"sampling recovery"
# Calculate mean depth below GS and the standard deviation of the depth below GS:  
# NOTE: we are ignoring the rows that are tagged with "sampling recovery" 
mean(na.omit(TW_PZ_01_FULL[-which(TW_PZ_01_FULL[,"Notes"]=="sampling recovery"),"m_below_GS"])) # 0.0746857 m
sd(na.omit(TW_PZ_01_FULL[-which(TW_PZ_01_FULL[,"Notes"]=="sampling recovery"),"m_below_GS"])) # 0.04852482 m 
# Save as CSV  
write.csv(TW_PZ_01_FULL, file="TWPZ01_FULL.csv", row.names=FALSE)     

# Bind without dips from isotope samples:      
TW_PZ_01_FULL_NO_ISO<-rbind(TW_PZ_01_Jun2018, TW_PZ_01_Nov2018, TW_PZ_01_Jun319_NO_ISO[1:which(TW_PZ_01_Jun319_NO_ISO[,"Date_Time"]=="06/03/19 12:45:00 PM"),])                        
# Save as CSV  
write.csv(TW_PZ_01_FULL_NO_ISO, file="TWPZ01_FULL_NO_ISO.csv", row.names=FALSE)    
                      
############## TW_PZ_01_SAND ############## 
   
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 130 cm
TW_PZ_01_SAND_Jun319[,"m_below_GS"]<-152.9/100-(130/100+TW_PZ_01_SAND_Jun319[,"m_water"]) 
# Add manual data
TW_PZ_01_SAND_Jun319[which(TW_PZ_01_SAND_Jun319[,"Date_Time"]=="03/30/19 12:15:00 PM"),"m_manual"]<-0.07
TW_PZ_01_SAND_Jun319[which(TW_PZ_01_SAND_Jun319[,"Date_Time"]=="06/03/19 01:00:00 PM"),"m_manual"]<-0.102
write.csv(TW_PZ_01_SAND_Jun319, file="TWPZ01_SAND_11-20-18_to_6-3-19.csv", row.names=FALSE)           

# Make full dataset csv
TW_PZ_01_SAND_FULL<-TW_PZ_01_SAND_Jun319
# Add tag in notes for where WL was recovering from isotope sampling
TW_PZ_01_SAND_FULL[which(TW_PZ_01_SAND_FULL[,"Date_Time"]=="03/30/19 12:45:00 PM"):which(TW_PZ_01_SAND_FULL[,"Date_Time"]=="04/01/19 05:30:00 AM"),"Notes"]<-"sampling recovery"
# Save as CSV  
write.csv(TW_PZ_01_SAND_FULL, file="TWPZ01_SAND_FULL.csv", row.names=FALSE)   
# Calculate mean depth below GS and the standard deviation of the depth below GS:  
# NOTE: we are ignoring the rows that are tagged with "sampling recovery" 
mean(na.omit(TW_PZ_01_SAND_FULL[-which(TW_PZ_01_SAND_FULL[,"Notes"]=="sampling recovery"),"m_below_GS"])) # 0.02085052 m
sd(na.omit(TW_PZ_01_SAND_FULL[-which(TW_PZ_01_SAND_FULL[,"Notes"]=="sampling recovery"),"m_below_GS"])) # 0.0705873 m 

############## TW_Grad_01 ##############  
# FULL
# Calculate the vertical gradient between PZ_01 and PZ_01_SAND     
# Join the pz and sw files together by the "Date_Time" column
TW_Grad_01_FULL<-join(TW_PZ_01_FULL[,c("Date_Time","m_below_GS", "m_manual", "Notes")], TW_PZ_01_SAND_FULL[,c("Date_Time","m_below_GS", "m_manual","Notes")], by="Date_Time")
# Rename the columns to designate between pz and sw water level values
colnames(TW_Grad_01_FULL)<-c( "Date_Time", "Peat_m_below_GS", "Peat_manual", "Peat_notes", "Sand_m_below_GS", "Sand_manual", "Sand_notes")
# Multiply m_below_GS columns by -1 to get head values with proper signage
TW_Grad_01_FULL[,"Peat_head_m"]<-TW_Grad_01_FULL[,"Peat_m_below_GS"]*-1
TW_Grad_01_FULL[,"Sand_head_m"]<-TW_Grad_01_FULL[,"Sand_m_below_GS"]*-1
# Multiply manual data by -1 as well
TW_Grad_01_FULL[,"Peat_manual"]<-TW_Grad_01_FULL[,"Peat_manual"]*-1
TW_Grad_01_FULL[,"Sand_manual"]<-TW_Grad_01_FULL[,"Sand_manual"]*-1
# Define dh (difference in head values)
TW_Grad_01_FULL[,"dh"]<-(TW_Grad_01_FULL[,"Peat_head_m"]-TW_Grad_01_FULL[,"Sand_head_m"])
# Define dz (vertical distance between midpoint of screens)
TW_Grad_01_FULL[,"dz"]<--1.2295--.202         
# Calculate the gradient (dh/dz) such that a positive gradient indicates downward flow
TW_Grad_01_FULL[,"dh/dz"]<-TW_Grad_01_FULL[,"dh"]/TW_Grad_01_FULL[,"dz"]    
# Add the missing manual data into the data frame 
TW_Grad_01_FULL[which(TW_Grad_01_FULL[,"Date_Time"]=="06/19/18 01:00:00 PM"),"Sand_manual"]<--0.195
TW_Grad_01_FULL[which(TW_Grad_01_FULL[,"Date_Time"]=="07/11/18 09:00:00 AM"),"Sand_manual"]<--0.201
TW_Grad_01_FULL[which(TW_Grad_01_FULL[,"Date_Time"]=="06/03/19 12:45:00 PM"),"Sand_manual"]<--0.102
TW_Grad_01_FULL[which(TW_Grad_01_FULL[,"Date_Time"]=="11/20/18 10:15:00 AM"),"Sand_manual"]<--0.016
# Write CSV
write.csv(TW_Grad_01_FULL, file="TWGrad01_FULL.csv", row.names=FALSE)                

# Calculate the mean gradient
# Note: Ignore the sections of data where the WL is recovering from isotope sampling!
TW_Grad_01_FULL2<-subset(TW_Grad_01_FULL, is.na(TW_Grad_01_FULL[,"Peat_notes"])& is.na(TW_Grad_01_FULL[,"Sand_notes"]))
# Calculate average gradient
mean(na.omit(TW_Grad_01_FULL2[,"dh/dz"])) # 0.05302487 m
# Calculate standard deviation of gradient		       
sd(na.omit(TW_Grad_01_FULL2[,"dh/dz"])) # 0.05791932 m                       
############## TW_PZ_02 ##############   

# MAY 2018
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 19 cm
TW_PZ_02_5_6[,"m_above_GS"]<-(TW_PZ_02_5_6[,"m_water"])-.8
      
# Correct the vertical jump in data on 3/3 - PZ was lengthened
vert_shift_start<-which(TW_PZ_02_5_6[,"Date_Time"]=="03/03/18 02:30:00 PM")
TW_PZ_02_5_6[vert_shift_start:nrow(TW_PZ_02_5_6),"m_above_GS"]<-TW_PZ_02_5_6[vert_shift_start:nrow(TW_PZ_02_5_6),"m_above_GS"]+ 0.5565902                        
# Interpolate between the spike                       
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

# MAY 2018 
#TW_PZ_02_May2018[,"m_above_GS"]<-(TW_PZ_02_May2018[,"m_water"])-.8
# Remove the first rows of the data set where the logger was not submerged 
#Logger_not_Submerged<-which(TW_PZ_02_May2018[,"Date_Time"]=="08/10/17 11:15:00 AM")
#TW_PZ_02_May2018<-TW_PZ_02_May2018[-(1:Logger_not_Submerged),]  
# Correct the vertical jump in data on 3/3 - PZ was lengthened
#vert_shift_start<-which(TW_PZ_02_May2018[,"Date_Time"]=="03/03/18 02:30:00 PM")
#TW_PZ_02_May2018[vert_shift_start:nrow(TW_PZ_02_May2018),"m_above_GS"]<-TW_PZ_02_May2018[vert_shift_start:nrow(TW_PZ_02_May2018),"m_above_GS"]+ 0.5565902                        
# Add manual data
#TW_PZ_02_May2018[which(TW_PZ_02_May2018[,"Date_Time"]=="10/23/17 03:15:00 PM"),"m_manual"]<-0.384
#TW_PZ_02_May2018[which(TW_PZ_02_May2018[,"Date_Time"]=="03/03/18 01:00:00 PM"),"m_manual"]<-0.45  
#TW_PZ_02_May2018[which(TW_PZ_02_May2018[,"Date_Time"]=="03/24/18 06:15:00 AM"),"m_manual"]<-0.372 

# JUNE 2018 
TW_PZ_02_Jun2018[,"m_above_GS"]<-(TW_PZ_02_Jun2018[,"m_water"])-.166
# Remove first and last rows of data where logger was not submerged                       
TW_PZ_02_Jun2018<-TW_PZ_02_Jun2018[which(TW_PZ_02_Jun2018[,"Date_Time"]=="05/06/18 04:15:00 PM"):which(TW_PZ_02_Jun2018[,"Date_Time"]=="06/18/18 10:15:00 AM"),]                       
# Add manual data
TW_PZ_02_Jun2018[which(TW_PZ_02_Jun2018[,"Date_Time"]=="05/06/18 04:15:00 PM"),"m_manual"]<-0.394
TW_PZ_02_Jun2018[which(TW_PZ_02_Jun2018[,"Date_Time"]=="06/18/18 10:15:00 AM"),"m_manual"]<-0.437  
# Save as CSV  
write.csv(TW_PZ_02_Jun2018, file="TW_WL_2018_06_18/processed/TWPZ02_5-6-18_to_6-18-18.csv", row.names=FALSE)     

# JULY 2018
TW_PZ_02_Jul2018[,"m_above_GS"]<-(TW_PZ_02_Jul2018[,"m_water"])-.186
# Correct logger for when it was dropped when it was shortened on 6/19
vert_shift_start<-which(TW_PZ_02_Jul2018[,"Date_Time"]=="06/19/18 02:00:00 PM")
TW_PZ_02_Jul2018[vert_shift_start:nrow(TW_PZ_02_Jul2018),"m_above_GS"]<-TW_PZ_02_Jul2018[vert_shift_start:nrow(TW_PZ_02_Jul2018),"m_above_GS"]-0.87                       
# Remove the last rows of the data set where the logger was not submerged
Logger_not_Submerged<-which(TW_PZ_02_Jul2018[,"Date_Time"]=="07/11/18 06:15:00 PM")
TW_PZ_02_Jul2018<-TW_PZ_02_Jul2018[-(Logger_not_Submerged:nrow(TW_PZ_02_Jul2018)),]      
# Add manual data
TW_PZ_02_Jul2018[which(TW_PZ_02_Jul2018[,"Date_Time"]=="06/19/18 02:15:00 PM"),"m_manual"]<-0.488                  
TW_PZ_02_Jul2018[which(TW_PZ_02_Jul2018[,"Date_Time"]=="07/11/18 06:00:00 PM"),"m_manual"]<-0.48        
# Save as CSV  
write.csv(TW_PZ_02_Jul2018, file="TW_WL_2018_07_11/processed/TWPZ02_6-18-18_to_7-11-18.csv", row.names=FALSE)     
                       
# NOVEMBER 2018
# Create a column for the depth to water below ground surface
TW_PZ_02_Nov2018[,"m_above_GS"]<-(TW_PZ_02_Nov2018[,"m_water"])-.63
# Remove the beginning of the dataset (where logger was not submerged) 
TW_PZ_02_Nov2018<-TW_PZ_02_Nov2018[which(TW_PZ_02_Nov2018[,"Date_Time"]=="07/12/18 11:00:00 AM"):nrow(TW_PZ_02_Nov2018),]
# Add manual data
TW_PZ_02_Nov2018[which(TW_PZ_02_Nov2018[,"Date_Time"]=="11/20/18 09:45:00 AM"),"m_manual"]<-0.562
# Remove the last rows of the data 
TW_PZ_02_Nov2018<-TW_PZ_02_Nov2018[1:which(TW_PZ_02_Nov2018[,"Date_Time"]=="11/20/18 10:30:00 AM"),]                       
# Save as CSV  
write.csv(TW_PZ_02_Nov2018, file="TWPZ02_7-11-18_to_11-20-18.csv", row.names=FALSE)  

# JUNE 2019
# Create a column for the depth to water above ground surface
TW_PZ_02_Jun319[,"m_above_GS"]<-(TW_PZ_02_Jun319[,"m_water"])-.63 
# Remove first few rows of data that overlap with previous November dataset
TW_PZ_02_Jun319<-TW_PZ_02_Jun319[which(TW_PZ_02_Jun319[,"Date_Time"]=="11/20/18 10:45:00 AM"):which(TW_PZ_02_Jun319[,"Date_Time"]=="06/03/19 12:15:00 PM"),]                       
# Add manual data
# 3/30 data may be wrong - was taken by first timer WL measurer on field trip
#TW_PZ_02_Jun319[which(TW_PZ_02_Jun319[,"Date_Time"]=="03/30/19 04:45:00 PM"),"m_manual"]<-0.279
TW_PZ_02_Jun319[which(TW_PZ_02_Jun319[,"Date_Time"]=="06/03/19 12:15:00 PM"),"m_manual"]<-0.449 
# Save as CSV  
write.csv(TW_PZ_02_Jun319, file="TWPZ02_11-20-18_to_6-3-19.csv", row.names=FALSE)
                       
# Bind all of the data frames together...                  
TW_PZ_02_FULL<-rbind(TW_PZ_02_Jun2018, TW_PZ_02_Jul2018, TW_PZ_02_Nov2018, TW_PZ_02_Jun319)   
# Save as CSV  
write.csv(TW_PZ_02_FULL, file="TWPZ02_FULL.csv", row.names=FALSE)
# Calculate mean height above GS and the standard deviation of the height above GS:  
mean(TW_PZ_02_FULL[,"m_above_GS"]) # 0.511118 m
sd(TW_PZ_02_FULL[,"m_above_GS"]) # 0.05466867 m                      
    
############## TW_SW_02 ##############     
                       
# Create a column for the depth to water below ground surface
TW_SW_02_Jun2018[,"m_above_GS"]<-TW_SW_02_Jun2018[,"m_water"]-.037
# Remove first and last few rows of erroneous data
TW_SW_02_Jun2018<-TW_SW_02_Jun2018[which(TW_SW_02_Jun2018[,"Date_Time"]=="05/06/18 04:00:00 PM"):which(TW_SW_02_Jun2018[,"Date_Time"]=="06/18/18 10:15:00 AM"),]
# Manual data for this period is not correct! 
TW_SW_02_Jun2018[,"m_manual"]<-NA
# Save as CSV  
write.csv(TW_SW_02_Jun2018, file="TWSW02_5-6-18_to_6-18-18.csv", row.names=FALSE) 	

# Create a column for the depth to water below ground surface
TW_SW_02_Nov2018[,"m_above_GS"]<-TW_SW_02_Nov2018[,"m_water"]-.04
# Remove last few rows of data 
TW_SW_02_Nov2018<-TW_SW_02_Nov2018[1:which(TW_SW_02_Nov2018[,"Date_Time"]=="11/20/18 10:30:00 AM"),]
# Add manual data
TW_SW_02_Nov2018[which(TW_SW_02_Nov2018[,"Date_Time"]=="06/19/18 02:45:00 PM"),"m_manual"]<-0.233 
TW_SW_02_Nov2018[which(TW_SW_02_Nov2018[,"Date_Time"]=="07/11/18 10:45:00 AM"),"m_manual"]<-0.33 
TW_SW_02_Nov2018[which(TW_SW_02_Nov2018[,"Date_Time"]=="11/20/18 10:00:00 AM"),"m_manual"]<-0.334
#TW_SW_02_Nov2018[,"lat"]<-41.91389722
#TW_SW_02_Nov2018[,"long"]<--70.57706944
# Save as CSV  
write.csv(TW_SW_02_Nov2018, file="TWSW02_6-18-18_to_11-20-18.csv", row.names=FALSE) 

#JUNE 3, 19                       
# Create a column for the depth to water above ground surface
TW_SW_02_Jun319[,"m_above_GS"]<-TW_SW_02_Jun319[,"m_water"]-.035
# Remove first few rows of data that overlap with previous dataset
TW_SW_02_Jun319<-TW_SW_02_Jun319[which(TW_SW_02_Jun319[,"Date_Time"]=="11/20/18 10:45:00 AM"):nrow(TW_SW_02_Jun319),]
# Add manual data
TW_SW_02_Jun319[which(TW_SW_02_Jun319[,"Date_Time"]=="03/30/19 04:45:00 PM"),"m_manual"]<-0.224
TW_SW_02_Jun319[which(TW_SW_02_Jun319[,"Date_Time"]=="06/03/19 12:15:00 PM"),"m_manual"]<-0.22      
# Save as CSV  
write.csv(TW_SW_02_Jun319, file="TWSW02_11-20-18_to_6-3-19.csv", row.names=FALSE)    

# Bind all of the data frames together...                  
TW_SW_02_FULL<-rbind(TW_SW_02_Jun2018, TW_SW_02_Nov2018, TW_SW_02_Jun319)   
# Save as CSV  
write.csv(TW_SW_02_FULL, file="TWSW02_FULL.csv", row.names=FALSE)     
# Calculate mean height above GS and the standard deviation of the height above GS:  
mean(na.omit(TW_SW_02_FULL[,"m_above_GS"])) # 0.2959142 m
sd(na.omit(TW_SW_02_FULL[,"m_above_GS"])) # 0.0595174 m     

############## TW_Grad_02 ##############
# November 2018
# Calculate the vertical gradient between PZ_02 and SW_02     
# Join the pz and sw files together by the "Date_Time" column
TW_Grad_02_Nov2018<-join(TW_PZ_02_Nov2018[,c("Date_Time","m_above_GS")], TW_SW_02_Nov2018[,c("Date_Time","m_above_GS")], by="Date_Time")
# Rename the columns to designate between pz and sw water level values
 colnames(TW_Grad_02_Nov2018)<-c( "Date_Time", "PZ_m_above_GS", "SW_m_above_GS")
# Define dh (difference in head values)
TW_Grad_02_Nov2018[,"dh"]<--(TW_Grad_02_Nov2018[,"PZ_m_above_GS"]-TW_Grad_02_Nov2018[,"SW_m_above_GS"])
# Define dz (vertical distance between midpoint of screens)
TW_Grad_02_Nov2018[,"dz"]<-1.29-0         
# Calculate the gradient (dh/dz) such that a positive gradient indicates downward flow
TW_Grad_02_Nov2018[,"dh/dz"]<-TW_Grad_02_Nov2018[,"dh"]/TW_Grad_02_Nov2018[,"dz"]         
# Save as CSV  
write.csv(TW_Grad_02_Nov2018, file="TWGrad02_7-12-18_to_11-20-18.csv", row.names=FALSE)    

# June 2019
# Calculate the vertical gradient between PZ_02 and SW_02     
# Join the pz and sw files together by the "Date_Time" column
TW_Grad_02_Jun319<-join(TW_PZ_02_Jun319[,c("Date_Time","m_above_GS", "m_manual")], TW_SW_02_Jun319[,c("Date_Time","m_above_GS","m_manual")], by="Date_Time")
# Rename the columns to designate between pz and sw water level values
 colnames(TW_Grad_02_Jun319)<-c( "Date_Time", "PZ_m_above_GS", "PZ_manual","SW_m_above_GS","PZ_manual")
# Define dh (difference in head values)
TW_Grad_02_Jun319[,"dh"]<--(TW_Grad_02_Jun319[,"PZ_m_above_GS"]-TW_Grad_02_Jun319[,"SW_m_above_GS"])
# Define dz (vertical distance between midpoint of screens)
TW_Grad_02_Jun319[,"dz"]<-1.29-0         
# Calculate the gradient (dh/dz) such that a positive gradient indicates downward flow
TW_Grad_02_Jun319[,"dh/dz"]<-TW_Grad_02_Jun319[,"dh"]/TW_Grad_02_Jun319[,"dz"]         
# Save as CSV  
write.csv(TW_Grad_02_Jun319, file="TWGrad02_11-20-18_to_6-3-19.csv", row.names=FALSE)    

# FULL
# Calculate the vertical gradient between PZ_02 and SW_02    
# Join the pz and sw files together by the "Date_Time" column
TW_Grad_02_FULL<-join(TW_PZ_02_FULL[,c("Date_Time","m_above_GS", "m_manual")], TW_SW_02_FULL[,c("Date_Time","m_above_GS", "m_manual")], by="Date_Time")
# Rename the columns to designate between pz and sw water level values
colnames(TW_Grad_02_FULL)<-c( "Date_Time", "PZ_m_above_GS", "PZ_manual", "SW_m_above_GS", "SW_manual")
# Define dh (difference in head values)
TW_Grad_02_FULL[,"dh"]<--(TW_Grad_02_FULL[,"PZ_m_above_GS"]-TW_Grad_02_FULL[,"SW_m_above_GS"])
# Define dz (vertical distance between midpoint of screens)
TW_Grad_02_FULL[,"dz"]<-1.29-0         
# Calculate the gradient (dh/dz) such that a positive gradient indicates downward flow
TW_Grad_02_FULL[,"dh/dz"]<-TW_Grad_02_FULL[,"dh"]/TW_Grad_02_FULL[,"dz"]    
# Save file as CSV
write.csv(TW_Grad_02_FULL, file="TWGrad02_FULL.csv", row.names=FALSE)    
# Calculate average gradient
mean(na.omit(TW_Grad_02_FULL[,"dh/dz"])) # -0.1668647 m
# Calculate standard deviation of gradient		       
sd(na.omit(TW_Grad_02_FULL[,"dh/dz"])) # 0.01848455 m       

############## TW_PZ_03 ##############    

# June 2018
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 58 cm
TW_PZ_03_Jun2018[,"m_above_GS"]<-(151.6/100-(58/100+TW_PZ_03_Jun2018[,"m_water"]) )*-1 
# Remove first few rows of erroneous data
TW_PZ_03_Jun2018<-TW_PZ_03_Jun2018[which(TW_PZ_03_Jun2018[,"Date_Time"]=="05/06/18 04:45:00 PM"):nrow(TW_PZ_03_Jun2018),]
# Add manual data
TW_PZ_03_Jun2018[which(TW_PZ_03_Jun2018[,"Date_Time"]=="06/18/18 10:45:00 AM"),"m_manual"]<-0.309          
# Save as CSV  
write.csv(TW_PZ_03_Jun2018, file="TWPZ03_5-6-18_to_6-18-18.csv", row.names=FALSE)      
         
# July 2018
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 58 cm
#TW_PZ_03_Jul2018[,"m_above_GS"]<-(151/100-(58/100+TW_PZ_03_Jul2018[,"m_water"]) )*-1 

# November 2018
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 58 cm
TW_PZ_03_Nov2018[,"m_above_GS"]<-(151/100-(58/100+TW_PZ_03_Nov2018[,"m_water"]) )*-1 
# Remove last few rows of data 
TW_PZ_03_Nov2018<-TW_PZ_03_Nov2018[1:which(TW_PZ_03_Nov2018[,"Date_Time"]=="11/20/18 10:15:00 AM"),]
# Add manual data
TW_PZ_03_Nov2018[which(TW_PZ_03_Nov2018[,"Date_Time"]=="07/12/18 11:30:00 AM"),"m_manual"]<-0.383
TW_PZ_03_Nov2018[which(TW_PZ_03_Nov2018[,"Date_Time"]=="11/20/18 09:15:00 AM"),"m_manual"]<-0.382                    
#TW_PZ_03_Nov2018[,"lat"]<-41.91499167
#TW_PZ_03_Nov2018[,"long"]<--70.57736111   
write.csv(TW_PZ_03_Nov2018, file="TWPZ03_7-12-18_to_11-20-18.csv", row.names=FALSE)  

# June 2019   
# Create a column for the depth to water below ground surface
TW_PZ_03_Jun319[,"m_above_GS"]<-(TW_PZ_03_Jun319[,"m_water"])-.46
# Remove first few rows of data that overlap with previous dataset
TW_PZ_03_Jun319<-TW_PZ_03_Jun319[which(TW_PZ_03_Jun319[,"Date_Time"]=="11/20/18 10:30:00 AM"):nrow(TW_PZ_03_Jun319),]
# Interpolate between the 3/30 spike                     
#Start_Spike<-which(TW_PZ_03_Jun319[,"Date_Time"]=="03/30/19 03:45:00 PM")
#Stop_Spike<-which(TW_PZ_03_Jun319[,"Date_Time"]=="03/30/19 04:15:00 PM")     
#Smoothed_Spike<-seq(TW_PZ_03_Jun319[Start_Spike,"m_above_GS"], TW_PZ_03_Jun319[Stop_Spike,"m_above_GS"], length=Stop_Spike-Start_Spike+1) 
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
                       
# Bind all of the data frames together...                  
TW_PZ_03_FULL<-rbind(TW_PZ_03_Jun2018, TW_PZ_03_Nov2018, TW_PZ_03_Jun319)   
# Save as CSV  
write.csv(TW_PZ_03_FULL, file="TWPZ03_FULL.csv", row.names=FALSE)  
# Calculate the mean m above GS and SD
mean(na.omit(TW_PZ_03_FULL[,"m_above_GS"])) # 0.3720367
sd(na.omit(TW_PZ_03_FULL[,"m_above_GS"])) # 0.06722406               

############## TW_SW_03 ##############

# June 2018 
# Correct based on manual stream measurements
TW_SW_03_Jun2018[,"m_above_GS"]<-TW_SW_03_Jun2018[,"m_water"]-2
# Remove last few rows of erroneous data
TW_SW_03_Jun2018<-TW_SW_03_Jun2018[1:which(TW_SW_03_Jun2018[,"Date_Time"]=="06/18/18 10:30:00 AM"),]
# Add manual data
TW_SW_03_Jun2018[which(TW_SW_03_Jun2018[,"Date_Time"]=="06/18/18 10:30:00 AM"),"m_manual"]<-0.254
# Save as CSV  
write.csv(TW_SW_03_Jun2018, file="TWSW03_5-6-18_to_6-18-18_MALFUNC.csv", row.names=FALSE)         
     
# November 2018 - MALFUNCTIONING
# Correct based on manual stream measurements
TW_SW_03_Nov2018[,"m_above_GS"]<-TW_SW_03_Nov2018[,"m_water"]-2
# Add manual data
TW_SW_03_Nov2018[which(TW_SW_03_Nov2018[,"Date_Time"]=="07/11/18 12:00:00 PM"),"m_manual"]<-0.351
TW_SW_03_Nov2018[which(TW_SW_03_Nov2018[,"Date_Time"]=="11/20/18 10:30:00 AM"),"m_manual"]<-0.342
# Save as CSV  
write.csv(TW_SW_03_Nov2018, file="TWSW03_6-18-18_to_11-20-18_MALFUNC.csv", row.names=FALSE)                               
         
# June 2019 - MALFUNCTIONING                               
# Correct based on manual stream measurements
TW_SW_03_Jun319[,"m_above_GS"]<-TW_SW_03_Jun319[,"m_water"]-2
# Add manual data
TW_SW_03_Jun319[which(TW_SW_03_Jun319[,"Date_Time"]=="03/30/19 04:00:00 PM"),"m_manual"]<-0.204
TW_SW_03_Jun319[which(TW_SW_03_Jun319[,"Date_Time"]=="06/03/19 12:30:00 PM"),"m_manual"]<-0.245 
# Save as CSV  
write.csv(TW_SW_03_Jun319, file="TWSW03_11-20-18_to_6-3-19.csv", row.names=FALSE)       

# Bind all of the data frames together...                  
TW_SW_03_FULL<-rbind(TW_SW_03_Jun2018, TW_SW_03_Nov2018, TW_SW_03_Jun319)   
# Save as CSV  
write.csv(TW_SW_03_FULL, file="TWSW03_FULL_MALFUNC.csv", row.names=FALSE)                   
                
############## TW_PZ_04 ##############  
# June 2018
# Create a column for the depth to water below ground surface
TW_PZ_04_Jun2018[,"m_above_GS"]<-(TW_PZ_04_Jun2018[,"m_water"])-1.0
# Remove last few rows of erroneous data 
TW_PZ_04_Jun2018<-TW_PZ_04_Jun2018[1:which(TW_PZ_04_Jun2018[,"Date_Time"]=="06/18/18 11:15:00 AM"),]     
# Add manual data
TW_PZ_04_Jun2018[which(TW_PZ_04_Jun2018[,"Date_Time"]=="06/18/18 11:15:00 AM"),"m_manual"]<-0.314
# Save as CSV  
write.csv(TW_PZ_04_Jun2018, file="TW_WL_2018_06_18/processed/TWPZ04_5-6-18_to_6-18-18.csv", row.names=FALSE)   

# November 2018
# Create a column for the depth to water below ground surface
TW_PZ_04_Nov2018[,"m_above_GS"]<-(TW_PZ_04_Nov2018[,"m_water"])-1.04      
# Remove the first and last few rows of erroneous data 
TW_PZ_04_Nov2018<-TW_PZ_04_Nov2018[which(TW_PZ_04_Nov2018[,"Date_Time"]=="06/18/18 12:00:00 PM"):which(TW_PZ_04_Nov2018[,"Date_Time"]=="11/20/18 09:45:00 AM"),]    
# Remove erroneous values when logger was pulled out and isotope sample taken on 7/12
TW_PZ_04_Nov2018[which(TW_PZ_04_Nov2018[,"Date_Time"]=="07/12/18 12:00:00 PM"),"m_above_GS"]<-NA
TW_PZ_04_Nov2018[which(TW_PZ_04_Nov2018[,"Date_Time"]=="07/12/18 12:15:00 PM"),"m_above_GS"]<-NA
# Add manual data
TW_PZ_04_Nov2018[which(TW_PZ_04_Nov2018[,"Date_Time"]=="07/11/18 12:45:00 PM"),"m_manual"]<-0.379
TW_PZ_04_Nov2018[which(TW_PZ_04_Nov2018[,"Date_Time"]=="08/16/18 09:30:00 AM"),"m_manual"]<-0.369  
TW_PZ_04_Nov2018[which(TW_PZ_04_Nov2018[,"Date_Time"]=="11/20/18 09:45:00 AM"),"m_manual"]<-0.389                                           
# Save as CSV  
write.csv(TW_PZ_04_Nov2018, file="TWPZ04_6-18-18_to_11-20-18.csv", row.names=FALSE)   

# June 2019
# Create a column for the depth to water below ground surface
TW_PZ_04_Jun319[,"m_above_GS"]<-(TW_PZ_04_Jun319[,"m_water"])-1.03
# Remove first and last rows of erroneous data 
TW_PZ_04_Jun319<-TW_PZ_04_Jun319[which(TW_PZ_04_Jun319[,"Date_Time"]=="11/20/18 10:00:00 AM"):which(TW_PZ_04_Jun319[,"Date_Time"]=="06/03/19 10:00:00 AM"),]
# Correct the vertical jump in data on 3/30
vert_shift_start<-which(TW_PZ_04_Jun319[,"Date_Time"]=="03/30/19 03:15:00 PM")
TW_PZ_04_Jun319[vert_shift_start:nrow(TW_PZ_04_Jun319),"m_above_GS"]<-TW_PZ_04_Jun319[vert_shift_start:nrow(TW_PZ_04_Jun319),"m_above_GS"]- 0.05620621                                      
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

# Bind all of the data frames together...                  
TW_PZ_04_FULL<-rbind(TW_PZ_04_Jun2018, TW_PZ_04_Nov2018, TW_PZ_04_Jun319)   
# Add tag in notes for where WL was recovering from isotope sampling
# Recovery from 6/18 and 7/11 sampling: 
TW_PZ_04_FULL[which(TW_PZ_04_FULL[,"Date_Time"]=="06/18/18 12:00:00 PM"):which(TW_PZ_04_FULL[,"Date_Time"]=="08/16/18 09:15:00 AM"),"Notes"]<-"sampling recovery"
# Recovery from 3/30/19 sampling (it appears that PZ didn't fully recover before dataset from 6/3/19 ends 
TW_PZ_04_FULL[which(TW_PZ_04_FULL[,"Date_Time"]=="03/30/19 03:15:00 PM"):which(TW_PZ_04_FULL[,"Date_Time"]=="06/03/19 10:00:00 AM"),"Notes"]<-"sampling recovery"
# Calculate mean height above GS and the standard deviation of the height above GS:  
# NOTE: we are ignoring the rows that are tagged with "sampling recovery" 
mean(na.omit(TW_PZ_04_FULL[-which(TW_PZ_04_FULL[,"Notes"]=="sampling recovery"),"m_above_GS"])) # 0.3682311 m
sd(na.omit(TW_PZ_04_FULL[-which(TW_PZ_04_FULL[,"Notes"]=="sampling recovery"),"m_above_GS"])) # 0.05680383 m 
# Save as CSV  
write.csv(TW_PZ_04_FULL, file="TWPZ04_FULL.csv", row.names=FALSE)       

############## TW_SW_04 ##############     

# June 2018
# Correct based on manual stream measurements
TW_SW_04_Jun2018[,"m_above_GS"]<-TW_SW_04_Jun2018[,"m_water"]-.035
# Remove the first few rows of erroneous data
TW_SW_04_Jun2018<-TW_SW_04_Jun2018[which(TW_SW_04_Jun2018[,"Date_Time"]=="05/06/18 08:00:00 PM"):nrow(TW_SW_04_Jun2018),] 
# Add manual data
TW_SW_04_Jun2018[which(TW_SW_04_Jun2018[,"Date_Time"]=="06/18/18 08:00:00 AM"),"m_manual"]<-0.29
# Save as CSV  
write.csv(TW_SW_04_Jun2018, file="TWSW04_5-6-18_to_6-18-18.csv", row.names=FALSE) 

# July 2018
# Correct based on manual stream measurements
TW_SW_04_Jul2018[,"m_above_GS"]<-TW_SW_04_Jul2018[,"m_water"]-.07
# Remove last few rows of erroneous data
TW_SW_04_Jul2018<-TW_SW_04_Jul2018[1:which(TW_SW_04_Jul2018[,"Date_Time"]=="07/12/18 05:30:00 AM"),] 
# Add manual data
TW_SW_04_Jul2018[which(TW_SW_04_Jul2018[,"Date_Time"]=="07/12/18 05:30:00 AM"),"m_manual"]<-0.32
# Save as CSV  
write.csv(TW_SW_04_Jul2018, file="TWSW04_6-18-18_to_7-12-18.csv", row.names=FALSE) 
                    
# November 2018
# Correct based on manual stream measurements
TW_SW_04_Nov2018[,"m_above_GS"]<-TW_SW_04_Nov2018[,"m_water"]-.07                       
# Remove last few rows of data 
TW_SW_04_Nov2018<-TW_SW_04_Nov2018[1:which(TW_SW_04_Nov2018[,"Date_Time"]=="11/20/18 09:45:00 AM"),] 
# Add manual data
TW_SW_04_Nov2018[which(TW_SW_04_Nov2018[,"Date_Time"]=="08/16/18 08:45:00 AM"),"m_manual"]<-0.36
TW_SW_04_Nov2018[which(TW_SW_04_Nov2018[,"Date_Time"]=="11/20/18 09:15:00 AM"),"m_manual"]<-0.273 
#TW_SW_04_Nov2018[,"lat"]<-41.91283611
#TW_SW_04_Nov2018[,"long"]<--70.57670833
# Save as CSV  
write.csv(TW_SW_04_Nov2018, file="TWSW04_7-12-18_to_11-20-18.csv", row.names=FALSE) 

# June 2019
# Correct based on manual stream measurements
TW_SW_04_Jun319[,"m_above_GS"]<-TW_SW_04_Jun319[,"m_water"]-.055
# Remove first few rows of data that overlap with previous dataset
TW_SW_04_Jun319<-TW_SW_04_Jun319[which(TW_SW_04_Jun319[,"Date_Time"]=="11/20/18 10:00:00 AM"):nrow(TW_SW_04_Jun319),]                     
# Add manual data
TW_SW_04_Jun319[which(TW_SW_04_Jun319[,"Date_Time"]=="03/30/19 03:00:00 PM"),"m_manual"]<-0.238
TW_SW_04_Jun319[which(TW_SW_04_Jun319[,"Date_Time"]=="06/03/19 10:00:00 AM"),"m_manual"]<-0.225 
# Save as CSV  
write.csv(TW_SW_04_Jun319, file="TWSW04_11-20-18_to_6-3-19.csv", row.names=FALSE) 

# Bind all of the data frames together...                  
# First remove additional NA.4 column so that all of the data frames have the same number of columns
TW_SW_04_Jun2018<-TW_SW_04_Jun2018[,-which(colnames(TW_SW_04_Jun2018)=="NA.4")]
TW_SW_04_Nov2018<-TW_SW_04_Nov2018[,-which(colnames(TW_SW_04_Nov2018)=="NA.4")]
TW_SW_04_Jun319<-TW_SW_04_Jun319[,-which(colnames(TW_SW_04_Jun319)=="NA.4")]
TW_SW_04_FULL<-rbind(TW_SW_04_Jun2018, TW_SW_04_Jul2018, TW_SW_04_Nov2018, TW_SW_04_Jun319)   
# Save as CSV  
write.csv(TW_SW_04_FULL, file="TWSW04_FULL.csv", row.names=FALSE)    
# Calculate mean height above GS and the standard deviation of the height above GS:  
mean(na.omit(TW_SW_04_FULL[,"m_above_GS"])) # 0.2976708 m
sd(na.omit(TW_SW_04_FULL[,"m_above_GS"])) # 0.06093183 m 

############## TW_Grad_04 ##############
# November 2018
# Calculate the vertical gradient between PZ_04 and SW_04     
# Join the pz and sw files together by the "Date_Time" column
TW_Grad_04_Nov2018<-join(TW_PZ_04_Nov2018[,c("Date_Time","m_above_GS")], TW_SW_04_Nov2018[,c("Date_Time","m_above_GS")], by="Date_Time")
# Rename the columns to designate between pz and sw water level values
colnames(TW_Grad_04_Nov2018)<-c( "Date_Time", "PZ_m_above_GS", "SW_m_above_GS")
# Define dh (difference in head values)
TW_Grad_04_Nov2018[,"dh"]<--(TW_Grad_04_Nov2018[,"PZ_m_above_GS"]-TW_Grad_04_Nov2018[,"SW_m_above_GS"])
# Define dz (vertical distance between midpoint of screens)
TW_Grad_04_Nov2018[,"dz"]<-.9865-0         
# Calculate the gradient (dh/dz) such that a positive gradient indicates downward flow
TW_Grad_04_Nov2018[,"dh/dz"]<-TW_Grad_04_Nov2018[,"dh"]/TW_Grad_04_Nov2018[,"dz"]    
# Remove the rows where there is no data for pz 04  
no_data<-which(TW_Grad_04_Nov2018[,"Date_Time"]=="07/12/18 12:15:00 PM")
TW_Grad_04_Nov2018<-TW_Grad_04_Nov2018[-(1:no_data),]             
# Save as CSV  
write.csv(TW_Grad_04_Nov2018, file="TWGrad04_7-12-18_to_11-20-18.csv", row.names=FALSE)    

# FULL
# Calculate the vertical gradient between PZ_04 and SW_04     
# Join the pz and sw files together by the "Date_Time" column
TW_Grad_04_FULL<-join(TW_PZ_04_FULL[,c("Date_Time","m_above_GS", "m_manual", "Notes")], TW_SW_04_FULL[,c("Date_Time","m_above_GS", "m_manual")], by="Date_Time")
# Rename the columns to designate between pz and sw water level values
colnames(TW_Grad_04_FULL)<-c( "Date_Time", "PZ_m_above_GS", "PZ_manual", "PZ_notes", "SW_m_above_GS", "SW_manual")
# Define dh (difference in head values)
TW_Grad_04_FULL[,"dh"]<-(TW_Grad_04_FULL[,"PZ_m_above_GS"]-TW_Grad_04_FULL[,"SW_m_above_GS"])
# Define dz (vertical distance between midpoint of screens)
TW_Grad_04_FULL[,"dz"]<--.9865-0         
# Calculate the gradient (dh/dz) such that a positive gradient indicates downward flow
TW_Grad_04_FULL[,"dh/dz"]<-TW_Grad_04_FULL[,"dh"]/TW_Grad_04_FULL[,"dz"]    
# Calculate the gradient (dh/dz) such that a positive gradient indicates downward flow
TW_Grad_04_FULL[,"dh/dz"]<-TW_Grad_04_FULL[,"dh"]/TW_Grad_04_FULL[,"dz"]    
write.csv(TW_Grad_04_FULL, file="TWGrad04_FULL.csv", row.names=FALSE)    
# Calculate the mean gradient
# Note: Ignore the sections of data where the WL is recovering from isotope sampling!
TW_Grad_04_FULL2<-subset(TW_Grad_04_FULL, is.na(TW_Grad_04_FULL[,"PZ_notes"]))
# Calculate average gradient
mean(na.omit(TW_Grad_04_FULL2[,"dh/dz"])) # -0.0698503 m
# Calculate standard deviation of gradient		       
sd(na.omit(TW_Grad_04_FULL2[,"dh/dz"])) # 0.03926074 m        

############## TW_PZ_05 ##############   
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 25.75 cm
TW_PZ_05_Nov2018[,"m_below_GS"]<-157/100-(25.75/100+TW_PZ_05_Nov2018[,"m_water"])             
# Smooth the spikes in the data caused by logger removal during data downloading
# Interpolate between the 7/11 spike
Start_Spike<-which(TW_PZ_05_Nov2018[,"Date_Time"]=="07/11/18 02:30:00 PM")                     
Stop_Spike<-which(TW_PZ_05_Nov2018[,"Date_Time"]=="07/11/18 03:00:00 PM")     
Smoothed_Spike<-seq(TW_PZ_05_Nov2018[Start_Spike,"m_below_GS"], TW_PZ_05_Nov2018[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)
# Replace the spike with the smoothed interpolated data
TW_PZ_05_Nov2018[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike
# Remove the beginning of the dataset (where logger was not submerged) 
TW_PZ_05_Nov2018<-TW_PZ_05_Nov2018[which(TW_PZ_05_Nov2018[,"Date_Time"]=="06/19/18 03:15:00 PM"):nrow(TW_PZ_05_Nov2018),]
# Add manual data
TW_PZ_05_Nov2018[which(TW_PZ_05_Nov2018[,"Date_Time"]=="07/11/18 02:30:00 PM"),"m_manual"]<-0.298
TW_PZ_05_Nov2018[which(TW_PZ_05_Nov2018[,"Date_Time"]=="11/19/18 03:00:00 PM"),"m_manual"]<-0.114
# Save as CSV  
write.csv(TW_PZ_05_Nov2018, file="TWPZ05_6-19-18_to_11-19-18.csv", row.names=FALSE)    
                                                                     
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
TW_PZ_05_Jun319[,"m_below_GS"]<-157/100-(25.75/100+TW_PZ_05_Jun319[,"m_water"])             
# Remove the beginning of the dataset (where logger was not submerged)
TW_PZ_05_Jun319<-TW_PZ_05_Jun319[which(TW_PZ_05_Jun319[,"Date_Time"]=="11/19/18 03:30:00 PM"):nrow(TW_PZ_05_Jun319),]                                    
# Add manual data
TW_PZ_05_Jun319[which(TW_PZ_05_Jun319[,"Date_Time"]=="03/30/19 12:30:00 PM"),"m_manual"]<-0.083
TW_PZ_05_Jun319[which(TW_PZ_05_Jun319[,"Date_Time"]=="06/03/19 11:00:00 AM"),"m_manual"]<-0.129
# Save as CSV  
write.csv(TW_PZ_05_Jun319, file="TWPZ05_11-19-18_to_6-3-19.csv", row.names=FALSE)    
          
############## TW_PZ_05_SAND ##############  
# June 2018
TW_PZ_05_SAND_Jun2018[,"m_below_GS"]<-153/100-(105/100+TW_PZ_05_SAND_Jun2018[,"m_water"])  
# Remove first row of erroneous data
TW_PZ_05_SAND_Jun2018<-TW_PZ_05_SAND_Jun2018[which(TW_PZ_05_SAND_Jun2018[,"Date_Time"]=="05/06/18 04:45:00 PM"):nrow(TW_PZ_05_SAND_Jun2018),] 
# Add manual data
TW_PZ_05_SAND_Jun2018[which(TW_PZ_05_SAND_Jun2018[,"Date_Time"]=="06/18/18 03:00:00 PM"),"m_manual"]<-0.204
# Save as CSV  
write.csv(TW_PZ_05_SAND_Jun2018, file="TWPZ05_SAND_5-6-18_to_6-18-18.csv", row.names=FALSE) 
		
# November 2018  
TW_PZ_05_SAND_Nov2018[,"m_below_GS"]<-153/100-(105/100+TW_PZ_05_SAND_Nov2018[,"m_water"])  
# Remove last few rows of data 
TW_PZ_05_SAND_Nov2018<-TW_PZ_05_SAND_Nov2018[1:which(TW_PZ_05_SAND_Nov2018[,"Date_Time"]=="11/19/18 03:45:00 PM"),]
# Don't correct for vertical jump! This was a real vertical jump due to isotope sampling on 6/19
# Correct the vertical jump in data on 6/19 (date of logger retrieval)
#vert_shift_start<-which(TW_PZ_05_SAND_Nov2018[,"Date_Time"]=="06/19/18 03:15:00 PM")
#TW_PZ_05_SAND_Nov2018[vert_shift_start:nrow(TW_PZ_05_SAND_Nov2018),"m_below_GS"]<-TW_PZ_05_SAND_Nov2018[vert_shift_start:nrow(TW_PZ_05_SAND_Nov2018),"m_below_GS"]
#TW_PZ_05_SAND_Nov2018[,"lat"]<-41.91594
#TW_PZ_05_SAND_Nov2018[,"long"]<--70.57631
# Interpolate between the 7/11 spike
Start_Spike<-which(TW_PZ_05_SAND_Nov2018[,"Date_Time"]=="07/11/18 02:30:00 PM")                     
Stop_Spike<-which(TW_PZ_05_SAND_Nov2018[,"Date_Time"]=="07/11/18 03:00:00 PM")     
Smoothed_Spike<-seq(TW_PZ_05_SAND_Nov2018[Start_Spike,"m_below_GS"], TW_PZ_05_SAND_Nov2018[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)  
# Replace the spike with the smoothed interpolated data
TW_PZ_05_SAND_Nov2018[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike  
# Add manual data
TW_PZ_05_SAND_Nov2018[which(TW_PZ_05_SAND_Nov2018[,"Date_Time"]=="06/19/18 03:00:00 PM"),"m_manual"]<-0.224                    
TW_PZ_05_SAND_Nov2018[which(TW_PZ_05_SAND_Nov2018[,"Date_Time"]=="07/11/18 02:30:00 PM"),"m_manual"]<-0.398
TW_PZ_05_SAND_Nov2018[which(TW_PZ_05_SAND_Nov2018[,"Date_Time"]=="11/19/18 03:00:00 PM"),"m_manual"]<-0.127 
# Save as CSV  
write.csv(TW_PZ_05_SAND_Nov2018, file="TWPZ05_SAND_6-18-18_to_11-19-18.csv", row.names=FALSE)  

# JUNE 2019 - malfunctioning
# All time stamps are the same                
#TW_PZ_05_SAND_Jun319[,"m_below_GS"]<-150.3/100-(105.5/100+TW_PZ_05_SAND_Jun319[,"m_water"])  
# Save as CSV  
#write.csv(TW_PZ_05_SAND_Jun319, file="TWPZ05_SAND_11-19-18.csv", row.names=FALSE)  

# Bind all of the data frames together...                  
TW_PZ_05_SAND_FULL<-rbind(TW_PZ_05_SAND_Jun2018, TW_PZ_05_SAND_Nov2018)   
# Save as CSV  
write.csv(TW_PZ_05_SAND_FULL, file="TWSW05SAND_FULL.csv", row.names=FALSE)    
                       
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
                                
# June 2018
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 32 cm
TW_PZ_06_Jun2018[,"m_below_GS"]<-153/100-(32/100+TW_PZ_06_Jun2018[,"m_water"])  
# Remove first and last few rows of erroneous data
TW_PZ_06_Jun2018<-TW_PZ_06_Jun2018[which(TW_PZ_06_Jun2018[,"Date_Time"]=="05/06/18 11:15:00 AM"):which(TW_PZ_06_Jun2018[,"Date_Time"]=="06/18/18 02:15:00 PM"),]
# Add manual data 
TW_PZ_06_Jun2018[which(TW_PZ_06_Jun2018[,"Date_Time"]=="06/18/18 02:00:00 PM"),"m_manual"]<-0.286
# Save as CSV  
write.csv(TW_PZ_06_Jun2018, file="TWPZ06_5-6-18_to_6-18-18.csv", row.names=FALSE)  
              
# November 2018		       
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 32 cm
TW_PZ_06_Nov2018[,"m_below_GS"]<-153/100-(32/100+TW_PZ_06_Nov2018[,"m_water"])  
# Smooth the spikes in the data caused by logger removal during data downloading
# Interpolate between the 7/11 spike
Start_Spike<-which(TW_PZ_06_Nov2018[,"Date_Time"]=="07/11/18 01:30:00 PM")                     
Stop_Spike<-which(TW_PZ_06_Nov2018[,"Date_Time"]=="07/11/18 02:15:00 PM")     
Smoothed_Spike<-seq(TW_PZ_06_Nov2018[Start_Spike,"m_below_GS"], TW_PZ_06_Nov2018[Stop_Spike,"m_below_GS"], length=Stop_Spike-Start_Spike+1)
# Replace the spike with the smoothed interpolated data
TW_PZ_06_Nov2018[Start_Spike:Stop_Spike,"m_below_GS"]<-Smoothed_Spike
# Remove the end of the dataset (where logger was not submerged) 
TW_PZ_06_Nov2018<-TW_PZ_06_Nov2018[1:which(TW_PZ_06_Nov2018[,"Date_Time"]=="11/19/18 04:00:00 PM"),]
# Add manual data
TW_PZ_06_Nov2018[which(TW_PZ_06_Nov2018[,"Date_Time"]=="06/19/18 02:45:00 PM"),"m_manual"]<-0.297
TW_PZ_06_Nov2018[which(TW_PZ_06_Nov2018[,"Date_Time"]=="07/11/18 01:30:00 PM"),"m_manual"]<-0.36
TW_PZ_06_Nov2018[which(TW_PZ_06_Nov2018[,"Date_Time"]=="11/19/18 03:30:00 PM"),"m_manual"]<-0.063
#TW_PZ_06_Nov2018[,"lat"]<-41.91573
#TW_PZ_06_Nov2018[,"long"]<--70.57496
# Save as CSV  
write.csv(TW_PZ_06_Nov2018, file="TWPZ06_6-18-18_to_11-19-18.csv", row.names=FALSE)  
  
# June 2019
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 32 cm
TW_PZ_06_Jun319[,"m_below_GS"]<-153/100-(31/100+TW_PZ_06_Jun319[,"m_water"])  
# Remove first few rows of data that overlap with previous dataset
TW_PZ_06_Jun319<-TW_PZ_06_Jun319[which(TW_PZ_06_Jun319[,"Date_Time"]=="11/19/18 04:15:00 PM"):nrow(TW_PZ_06_Jun319),]
# Add manual data
TW_PZ_06_Jun319[which(TW_PZ_06_Jun319[,"Date_Time"]=="03/30/19 12:30:00 PM"),"m_manual"]<-0.152
TW_PZ_06_Jun319[which(TW_PZ_06_Jun319[,"Date_Time"]=="06/03/19 10:45:00 AM"),"m_manual"]<-0.145
# Save as CSV  
write.csv(TW_PZ_06_Jun319, file="TWPZ06_11-19-18_to_6-3-19_rise.csv", row.names=FALSE) 

# Save another file without the rise (WL recovery from isotope sampling)
TW_PZ_06_Jun319_norise<-TW_PZ_06_Jun319
# Replace the portion of the data during the rise on 3/30 with NA 
Start_Blank<-which(TW_PZ_06_Jun319_norise[,"Date_Time"]=="03/30/19 03:15:00 PM")
Stop_Blank<-which(TW_PZ_06_Jun319_norise[,"Date_Time"]=="04/01/19 12:00:00 AM") 
TW_PZ_06_Jun319_norise[Start_Blank:Stop_Blank,"m_below_GS"]<-NA  
# Save as CSV  
write.csv(TW_PZ_06_Jun319_norise, file="TWPZ06_11-19-18_to_6-3-19.csv", row.names=FALSE) 

# Bind all of the data frames together...                  
TW_PZ_06_FULL<-rbind(TW_PZ_06_Jun2018, TW_PZ_06_Nov2018, TW_PZ_06_Jun319)   
# Make another data frame without the isotope dip
TW_PZ_06_FULL_NO_ISO<-rbind(TW_PZ_06_Jun2018, TW_PZ_06_Nov2018, TW_PZ_06_Jun319_norise)   
# Save as CSV  
write.csv(TW_PZ_06_FULL, file="TWSW06_FULL.csv", row.names=FALSE)     
write.csv(TW_PZ_06_FULL_NO_ISO, file="TWSW06_FULL_NO_ISO.csv", row.names=FALSE)     

############## TW_PZ_06_SAND ##############  
# June 2018
TW_PZ_06_SAND_Jun2018[,"m_below_GS"]<-150/100-(100/100+TW_PZ_06_SAND_Jun2018[,"m_water"])  
# Add manual data
TW_PZ_06_SAND_Jun2018[which(TW_PZ_06_SAND_Jun2018[,"Date_Time"]=="06/18/18 02:00:00 PM"),"m_manual"]<-0.102
# Save as CSV  
write.csv(TW_PZ_06_SAND_Jun2018, file="TWPZ06_SAND_5-6-18_to_6-18-18.csv", row.names=FALSE)    

# November 2018  
TW_PZ_06_SAND_Nov2018[,"m_below_GS"]<-150/100-(102/100+TW_PZ_06_SAND_Nov2018[,"m_water"])  
# Remove last few rows of data 
TW_PZ_06_SAND_Nov2018<-TW_PZ_06_SAND_Nov2018[1:which(TW_PZ_06_SAND_Nov2018[,"Date_Time"]=="11/19/18 04:00:00 PM"),]                 
# Add manual data
TW_PZ_06_SAND_Nov2018[which(TW_PZ_06_SAND_Nov2018[,"Date_Time"]=="06/19/18 02:45:00 PM"),"m_manual"]<-0.138
TW_PZ_06_SAND_Nov2018[which(TW_PZ_06_SAND_Nov2018[,"Date_Time"]=="07/11/18 01:30:00 PM"),"m_manual"]<-0.207
TW_PZ_06_SAND_Nov2018[which(TW_PZ_06_SAND_Nov2018[,"Date_Time"]=="11/19/18 03:30:00 PM"),"m_manual"]<-0.199
# This data has a lot of noise the ma() function uses a moving average, using an order of 75 smoothed the data well 
#TW_PZ_06_SAND_Nov2018[,"denoised"]<-ma(TW_PZ_06_SAND_Nov2018[,"m_below_GS"], order=75)                     
#TW_PZ_06_SAND_Nov2018<-TW_PZ_06_SAND_Nov2018[-which(is.na(TW_PZ_06_SAND_Nov2018[,"denoised"])),]  
#TW_PZ_06_SAND_Nov2018[,"lat"]<-41.91573
#TW_PZ_06_SAND_Nov2018[,"long"]<--70.57496
# Save as CSV  
write.csv(TW_PZ_06_SAND_Nov2018, file="TWPZ06_SAND_6-18-18_to_11-19-18.csv", row.names=FALSE)    

# June 2019
TW_PZ_06_SAND_Jun319[,"m_below_GS"]<-150/100-(99/100+TW_PZ_06_SAND_Jun319[,"m_water"]) 
# Remove first few rows of data that overlap with previous dataset
TW_PZ_06_SAND_Jun319<-TW_PZ_06_SAND_Jun319[which(TW_PZ_06_SAND_Jun319[,"Date_Time"]=="11/19/18 04:15:00 PM"):nrow(TW_PZ_06_SAND_Jun319),]                  
# Add manual data
TW_PZ_06_SAND_Jun319[which(TW_PZ_06_SAND_Jun319[,"Date_Time"]=="03/30/19 12:30:00 PM"),"m_manual"]<-0.083
TW_PZ_06_SAND_Jun319[which(TW_PZ_06_SAND_Jun319[,"Date_Time"]=="06/03/19 10:45:00 AM"),"m_manual"]<-0.165
# Don't correct for vertical jump on 3/30 bc it is real due to isotope sampling!
# Correct the vertical jump in data on 3/30
#vert_shift_start<-which(TW_PZ_06_SAND_Jun319[,"Date_Time"]=="03/30/19 03:15:00 PM")
#TW_PZ_06_SAND_Jun319[vert_shift_start:nrow(TW_PZ_06_SAND_Jun319),"m_below_GS"]<-TW_PZ_06_SAND_Jun319[vert_shift_start:nrow(TW_PZ_06_SAND_Jun319),"m_below_GS"]- 0.156                     
# Save as CSV  
write.csv(TW_PZ_06_SAND_Jun319, file="TWPZ06_SAND_11-19-18_to_6-3-19.csv", row.names=FALSE)   

# Bind all of the data frames together...                  
TW_PZ_06_SAND_FULL<-rbind(TW_PZ_06_SAND_Jun2018, TW_PZ_06_SAND_Nov2018, TW_PZ_06_SAND_Jun319)    
# Save as CSV  
write.csv(TW_PZ_06_SAND_FULL, file="TWSW06SAND_FULL.csv", row.names=FALSE)     

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

# June 2018
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 31 cm
TW_PZ_07_Jun2018[,"m_above_GS"]<-(153/100-(31/100+TW_PZ_07_Jun2018[,"m_water"]) )*-1 
# Remove the first rows of erroneous data
TW_PZ_07_Jun2018<-TW_PZ_07_Jun2018[which(TW_PZ_07_Jun2018[,"Date_Time"]=="05/06/18 03:00:00 PM"):nrow(TW_PZ_07_Jun2018),] 
# Add manual data
TW_PZ_07_Jun2018[which(TW_PZ_07_Jun2018[,"Date_Time"]=="06/18/18 11:45:00 AM"),"m_manual"]<-0.222
# Save as CSV
write.csv(TW_PZ_07_Jun2018, file="TWPZ07_5-6-18_to_6-18-18.csv", row.names=FALSE) 

# November 2018
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 31 cm
TW_PZ_07_Nov2018[,"m_above_GS"]<-(153/100-(31/100+TW_PZ_07_Nov2018[,"m_water"]) )*-1 
# Remove last few rows of data 
TW_PZ_07_Nov2018<-TW_PZ_07_Nov2018[1:which(TW_PZ_07_Nov2018[,"Date_Time"]=="11/19/18 05:00:00 PM"),] 
# Remove blank rows from logger extractions                    
TW_PZ_07_Nov2018<-TW_PZ_07_Nov2018[-which(is.na(TW_PZ_07_Nov2018[,"m_above_GS"])),]   
# Add manual data
TW_PZ_07_Nov2018[which(TW_PZ_07_Nov2018[,"Date_Time"]=="11/19/18 04:30:00 PM"),"m_manual"]<-0.228
TW_PZ_07_Nov2018[which(TW_PZ_07_Nov2018[,"Date_Time"]=="07/12/18 12:30:00 PM"),"m_manual"]<-0.26
#TW_PZ_07_Nov2018[,"lat"]<-41.91708333
#TW_PZ_07_Nov2018[,"long"]<--70.57833333
write.csv(TW_PZ_07_Nov2018, file="TWPZ07_6-18-18_to_11-19-18.csv", row.names=FALSE) 

# June 2019
# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 31 cm
TW_PZ_07_Jun319[,"m_above_GS"]<-(153/100-(31/100+TW_PZ_07_Jun319[,"m_water"]) )*-1   
# Remove the first few rows that overlap with previous dataset
TW_PZ_07_Jun319<-TW_PZ_07_Jun319[which(TW_PZ_07_Jun319[,"Date_Time"]=="11/19/18 05:15:00 PM"):nrow(TW_PZ_07_Jun319),] 
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

# Bind all of the data frames together...                  
TW_PZ_07_FULL<-rbind(TW_PZ_07_Jun2018, TW_PZ_07_Nov2018, TW_PZ_07_Jun319)    
# Save as CSV  
write.csv(TW_PZ_07_FULL, file="TWPZ07_FULL.csv", row.names=FALSE)     
                  
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

# June 2018
# Correct based on manual stream measurements
TW_SW_07_Jun2018[,"m_above_GS"]<-TW_SW_07_Jun2018[,"m_water"]-.125
# Remove first rows of erroneous data
TW_SW_07_Jun2018<-TW_SW_07_Jun2018[which(TW_SW_07_Jun2018[,"Date_Time"]=="05/06/18 03:00:00 PM"):nrow(TW_SW_07_Jun2018),]
# Add manual data
TW_SW_07_Jun2018[which(TW_SW_07_Jun2018[,"Date_Time"]=="06/18/18 11:45:00 AM"),"m_manual"]<-0.265                     
# Save as CSV  
write.csv(TW_SW_07_Jun2018, file="TWSW07_5-6-18_to_6-18-18.csv", row.names=FALSE) 

# November 2018
# Correct based on manual stream measurements
TW_SW_07_Nov2018[,"m_above_GS"]<-TW_SW_07_Nov2018[,"m_water"]-.125
# Remove last few rows of data 
TW_SW_07_Nov2018<-TW_SW_07_Nov2018[1:which(TW_SW_07_Nov2018[,"Date_Time"]=="11/19/18 05:00:00 PM"),]
# Correct for strange vertical jump at 1 AM on 11/14/18. Not sure how this 4 cm jump happened, but it needs to be corrected to match manual data
vert_shift_start<-which(TW_SW_07_Nov2018[,"Date_Time"]=="11/14/18 01:15:00 AM")
TW_SW_07_Nov2018[vert_shift_start:nrow(TW_SW_07_Nov2018),"m_above_GS"]<-TW_SW_07_Nov2018[vert_shift_start:nrow(TW_SW_07_Nov2018),"m_above_GS"]-0.0439414	
#TW_SW_07_Nov2018[,"lat"]<-41.91708333
#TW_SW_07_Nov2018[,"long"]<--70.57833333
# Add manual data
TW_SW_07_Nov2018[which(TW_SW_07_Nov2018[,"Date_Time"]=="07/11/18 12:15:00 PM"),"m_manual"]<-0.279                     
TW_SW_07_Nov2018[which(TW_SW_07_Nov2018[,"Date_Time"]=="11/19/18 03:15:00 PM"),"m_manual"]<-0.21
write.csv(TW_SW_07_Nov2018, file="TWSW07_6-18-18_to_11-19-18.csv", row.names=FALSE) 

# July 2019
# Correct based on manual stream measurements
TW_SW_07_Jun319[,"m_above_GS"]<-TW_SW_07_Jun319[,"m_water"]-.135
# Remove first and last few rows of erroneous or overlapping data
TW_SW_07_Jun319<-TW_SW_07_Jun319[which(TW_SW_07_Jun319[,"Date_Time"]=="11/19/18 05:15:00 PM"):which(TW_SW_07_Jun319[,"Date_Time"]=="06/03/19 09:15:00 AM"),]
# Add manual data
TW_SW_07_Jun319[which(TW_SW_07_Jun319[,"Date_Time"]=="03/30/19 01:45:00 PM"),"m_manual"]<-0.132                     
TW_SW_07_Jun319[which(TW_SW_07_Jun319[,"Date_Time"]=="06/03/19 09:15:00 AM"),"m_manual"]<-0.198
# Save as CSV
write.csv(TW_SW_07_Jun319, file="TWSW07_11-19-18_to_6-3-19.csv", row.names=FALSE) 

# Bind all of the data frames together...                  
TW_SW_07_FULL<-rbind(TW_SW_07_Jun2018, TW_SW_07_Nov2018, TW_SW_07_Jun319)    
# Save as CSV  
write.csv(TW_SW_07_FULL, file="TWSW07_FULL.csv", row.names=FALSE)  

############## TW_Grad_07 ##############
# November 2018
# Calculate the vertical gradient between PZ_07 and SW_07     
# Join the pz and sw files together by the "Date_Time" column
TW_Grad_07_Nov2018<-join(TW_PZ_07_Nov2018[,c("Date_Time","m_above_GS")], TW_SW_07_Nov2018[,c("Date_Time","m_above_GS")], by="Date_Time")
# Rename the columns to designate between pz and sw water level values
colnames(TW_Grad_07_Nov2018)<-c( "Date_Time", "PZ_m_above_GS", "SW_m_above_GS")
# Define dh (difference in head values)
TW_Grad_07_Nov2018[,"dh"]<--(TW_Grad_07_Nov2018[,"PZ_m_above_GS"]-TW_Grad_07_Nov2018[,"SW_m_above_GS"])
# Define dz (vertical distance between midpoint of screens)
TW_Grad_07_Nov2018[,"dz"]<-1.2375-0         
# Calculate the gradient (dh/dz) such that a positive gradient indicates downward flow
TW_Grad_07_Nov2018[,"dh/dz"]<-TW_Grad_07_Nov2018[,"dh"]/TW_Grad_07_Nov2018[,"dz"]    
# Save as CSV  
write.csv(TW_Grad_07_Nov2018, file="TWGrad07_6-18-18_to_11-19-18.csv", row.names=FALSE)    

# FULL
# Calculate the vertical gradient between PZ_07 and SW_07    
# Join the pz and sw files together by the "Date_Time" column
TW_Grad_07_FULL<-join(TW_PZ_07_FULL[,c("Date_Time","m_above_GS")], TW_SW_07_FULL[,c("Date_Time","m_above_GS")], by="Date_Time")
# Rename the columns to designate between pz and sw water level values
colnames(TW_Grad_07_FULL)<-c( "Date_Time", "PZ_m_above_GS", "SW_m_above_GS")
# Define dh (difference in head values)
TW_Grad_07_FULL[,"dh"]<--(TW_Grad_07_FULL[,"PZ_m_above_GS"]-TW_Grad_07_FULL[,"SW_m_above_GS"])
# Define dz (vertical distance between midpoint of screens)
TW_Grad_07_FULL[,"dz"]<-1.2375-0         
# Calculate the gradient (dh/dz) such that a positive gradient indicates downward flow
TW_Grad_07_FULL[,"dh/dz"]<-TW_Grad_07_FULL[,"dh"]/TW_Grad_07_FULL[,"dz"]    
# Calculate the gradient (dh/dz) such that a positive gradient indicates downward flow
TW_Grad_07_FULL[,"dh/dz"]<-TW_Grad_07_FULL[,"dh"]/TW_Grad_07_FULL[,"dz"]    
write.csv(TW_Grad_07_FULL, file="TWGrad07_FULL.csv", row.names=FALSE)    

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
TW_PZ_08_Jun2018[,"m_below_GS"]<-116/100-(28/100+TW_PZ_08_Jun2018[,"m_water"])    
# Remove rows with erroneous data
TW_PZ_08_Jun2018<-TW_PZ_08_Jun2018[which(TW_PZ_08_Jun2018[,"Date_Time"]=="05/06/18 04:45:00 PM"):nrow(TW_PZ_08_Jun2018),]    
# Add manual data
TW_PZ_08_Jun2018[which(TW_PZ_08_Jun2018[,"Date_Time"]=="06/18/18 02:45:00 PM"),"m_manual"]<-0.149       
# Save as CSV
write.csv(TW_PZ_08_Jun2018, file="TWPZ08_5-6-18_to_6-18-18_MALFUNC.csv", row.names=FALSE)           

# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 28 cm
TW_PZ_08_Nov2018[,"m_below_GS"]<-116/100-(28/100+TW_PZ_08_Nov2018[,"m_water"])                       
# Remove the beginning of the dataset (where logger was not submerged) 
TW_PZ_08_Nov2018<-TW_PZ_08_Nov2018[-1,]
# Remove last 3 rows of blank data 
TW_PZ_08_Nov2018<-TW_PZ_08_Nov2018[1:which(TW_PZ_08_Nov2018[,"Date_Time"]=="11/19/18 04:45:00 PM"),]
# This data has a lot of noise the ma() function uses a moving average, using an order of 100 smoothed the data well 
#TW_PZ_08_Nov2018[,"denoised"]<-ma(TW_PZ_08_Nov2018[,"m_below_GS"], order=100)                     
#TW_PZ_08_Nov2018<-TW_PZ_08_Nov2018[-which(is.na(TW_PZ_08_Nov2018[,"denoised"])),]
# Add manual data
TW_PZ_08_Nov2018[which(TW_PZ_08_Nov2018[,"Date_Time"]=="06/19/18 03:15:00 PM"),"m_manual"]<-0.149
TW_PZ_08_Nov2018[which(TW_PZ_08_Nov2018[,"Date_Time"]=="07/11/18 05:00:00 PM"),"m_manual"]<-0.106
TW_PZ_08_Nov2018[which(TW_PZ_08_Nov2018[,"Date_Time"]=="11/19/18 03:45:00 PM"),"m_manual"]<-0.114
#TW_PZ_08_Nov2018[,"lat"]<-41.91744444
#TW_PZ_08_Nov2018[,"long"]<---70.57794444
# Save as CSV
write.csv(TW_PZ_08_Nov2018, file="TWPZ08_6-18-18_to_11-19-18_MALFUNC.csv", row.names=FALSE) 

# Create a column for the depth to water below ground surface
# The top of piezometer casing to ground surface = 28 cm
TW_PZ_08_Jun319[,"m_below_GS"]<-116/100-(28/100+TW_PZ_08_Jun319[,"m_water"])
# Remove the first few rows of erroneous data
TW_PZ_08_Jun319<-TW_PZ_08_Jun319[which(TW_PZ_08_Jun319[,"Date_Time"]=="11/19/18 05:00:00 PM"):nrow(TW_PZ_08_Jun319),]    
# Add manual data   
TW_PZ_08_Jun319[which(TW_PZ_08_Jun319[,"Date_Time"]=="06/03/19 09:00:00 AM"),"m_manual"]<-0.213
# Save as CSV
write.csv(TW_PZ_08_Jun319, file="TWPZ08_11-19-18_to_6-3-19_MALFUNC.csv", row.names=FALSE)    

# Bind all of the data frames together...                  
TW_PZ_08_FULL<-rbind(TW_PZ_08_Jun2018, TW_PZ_08_Nov2018, TW_PZ_08_Jun319)    
# Save as CSV  
write.csv(TW_PZ_08_FULL, file="TWPZ08_FULL.csv", row.names=FALSE)  

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
TW_PZ_09_Nov2018[,"m_below_GS"]<-163.5/100-(28/100+TW_PZ_09_Nov2018[,"m_water"])                       
# Note that there is a vertical shift in data on 7/11 due to an isotope extraction 
# Replace the portion of the data where logger was out of water on 7/11 with NA 
Start_Blank<-which(TW_PZ_09_Nov2018[,"Date_Time"]=="07/11/18 04:45:00 PM")
Stop_Blank<-which(TW_PZ_09_Nov2018[,"Date_Time"]=="07/11/18 05:15:00 PM") 
TW_PZ_09_Nov2018[Start_Blank:Stop_Blank,"m_below_GS"]<-NA   
# Correct the vertical jump in data on 7/11 (date of logger retrieval); logger was in slightly different vertical position upon reinstallation
vert_shift_start<-which(TW_PZ_09_Nov2018[,"Date_Time"]=="07/11/18 05:30:00 PM")
TW_PZ_09_Nov2018[vert_shift_start:nrow(TW_PZ_09_Nov2018),"m_below_GS"]<-TW_PZ_09_Nov2018[vert_shift_start:nrow(TW_PZ_09_Nov2018),"m_below_GS"]+ 0.04                                 
# Remove last few rows of data 
TW_PZ_09_Nov2018<-TW_PZ_09_Nov2018[1:which(TW_PZ_09_Nov2018[,"Date_Time"]=="11/19/18 03:30:00 PM"),]
#TW_PZ_09_Nov2018[,"lat"]<-41.91705556
#TW_PZ_09_Nov2018[,"long"]<--70.57588889
# Note that logger had to be removed for WL measurement on 7/11
TW_PZ_09_Nov2018[which(TW_PZ_09_Nov2018[,"Date_Time"]=="07/11/18 04:30:00 PM"),"m_manual"]<-0.513
TW_PZ_09_Nov2018[which(TW_PZ_09_Nov2018[,"Date_Time"]=="11/19/18 03:00:00 PM"),"m_manual"]<-0.403
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
# November 2018
# Correct based on manual stream measurements
# Create a column for height of water above stream bed
TW_SW_10_Nov2018[,"m_above_GS"]<-TW_SW_10_Nov2018[,"m_water"]-.015 
# Remove the first set of rows where the logger was not submerged       
TW_SW_10_Nov2018<-TW_SW_10_Nov2018[which(TW_SW_10_Nov2018[,"Date_Time"]=="08/16/18 03:45:00 PM"):nrow(TW_SW_10_Nov2018),]
# Add manual data
TW_SW_10_Nov2018[which(TW_SW_10_Nov2018[,"Date_Time"]=="08/16/18 03:45:00 PM"),"m_manual"]<-0.188
TW_SW_10_Nov2018[which(TW_SW_10_Nov2018[,"Date_Time"]=="11/19/18 05:00:00 PM"),"m_manual"]<-0.21    
# Save as CSV
write.csv(TW_SW_10_Nov2018, file="TWSW10_8-16-18_to_11-19-18.csv", row.names=FALSE)                       
                                             
# June 2019
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
                                             

                     
##################################################### MAKE PLOTS ####################################################################################

################ TW_PZ_01 ################
Plot_Times<-as.POSIXct(TW_PZ_01_3_19[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_3_19, aes(Plot_Times, TW_PZ_01_3_19[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1.2,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_3_19.pdf", width = 12, height = 6)  
                       
# cut off slow rise
Plot_Times<-as.POSIXct(TW_PZ_01_3_19[which(TW_PZ_01_3_19[,"Date_Time"]=="08/24/17 12:00:00 AM"):nrow(TW_PZ_01_3_19)    ,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_3_19[which(TW_PZ_01_3_19[,"Date_Time"]=="08/24/17 12:00:00 AM"):nrow(TW_PZ_01_3_19),], aes(Plot_Times, TW_PZ_01_3_19[which(TW_PZ_01_3_19[,"Date_Time"]=="08/24/17 12:00:00 AM"):nrow(TW_PZ_01_3_19),"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.4,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_3_19_2.pdf", width = 12, height = 6)               

# June 2018        
Plot_Times<-as.POSIXct(TW_PZ_01_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_Jun2018, aes(Plot_Times, TW_PZ_01_Jun2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.3,0)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_WL_2018_06_18/processed/TW_PZ_01_5-6-18_to_6-18-18.pdf", width = 12, height = 6)                       
# June with manual
Plot_Times<-as.POSIXct(TW_PZ_01_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_Jun2018, aes(Plot_Times, TW_PZ_01_Jun2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.2,0)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_01_Jun2018[,"m_manual"]), color="orange3", size=3) 
ggsave("TW_WL_2018_06_18/processed/TW_PZ_01_5-6-18_to_6-18-18_manual.pdf", width = 12, height = 6)       
                                             
# November 2018                 
Plot_Times<-as.POSIXct(TW_PZ_01_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_Nov2018, aes(Plot_Times, TW_PZ_01_Nov2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.2,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_Nov.pdf", width = 12, height = 6)
# November with manual
Plot_Times<-as.POSIXct(TW_PZ_01_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_Nov2018, aes(Plot_Times, TW_PZ_01_Nov2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.2,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_01_Nov2018[,"m_manual"]), color="orange3", size=3) 
          
#June 2019 - with isotope sample dip                    
Plot_Times<-as.POSIXct(TW_PZ_01_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_Jun319, aes(Plot_Times, TW_PZ_01_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_11-20-18_to_6-3-19.pdf", width = 12, height = 6)  
# June with manual
Plot_Times<-as.POSIXct(TW_PZ_01_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_Jun319, aes(Plot_Times, TW_PZ_01_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_01_Jun319[,"m_manual"]), color="orange3", size=3)                            
ggsave("TW_PZ_01_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)
                       
#June 2019  without isotope sample dip                   
Plot_Times<-as.POSIXct(TW_PZ_01_Jun319_NO_ISO[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_Jun319_NO_ISO, aes(Plot_Times, TW_PZ_01_Jun319_NO_ISO[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_11-20-18_to_6-3-19_NO_ISO.pdf", width = 12, height = 6)  
# June with manual
Plot_Times<-as.POSIXct(TW_PZ_01_Jun319_NO_ISO[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_Jun319_NO_ISO, aes(Plot_Times, TW_PZ_01_Jun319_NO_ISO[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_01_Jun319_NO_ISO[,"m_manual"]), color="orange3", size=3)                            
ggsave("TW_PZ_01_11-20-18_to_6-3-19_NO_ISO_manual.pdf", width = 12, height = 6)                             
                                      
# Complete PZ_01 dataset
Plot_Times<-as.POSIXct(TW_PZ_01_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_FULL, aes(Plot_Times, TW_PZ_01_FULL[,"m_below_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_FULL.pdf", width = 12, height = 6)                             
# Complete with manual
Plot_Times<-as.POSIXct(TW_PZ_01_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_FULL, aes(Plot_Times, TW_PZ_01_FULL[,"m_below_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_01_FULL[,"m_manual"]), color="orange3", size=3) 
ggsave("TW_PZ_01_FULL_manual.pdf", width = 12, height = 6)                             

# Complete PZ_01 dataset - without isotope dip
Plot_Times<-as.POSIXct(TW_PZ_01_FULL_NO_ISO[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_FULL_NO_ISO, aes(Plot_Times, TW_PZ_01_FULL_NO_ISO[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_NO_ISO_FULL.pdf", width = 12, height = 6)                             
# Complete - without isotope dip, with manual
Plot_Times<-as.POSIXct(TW_PZ_01_FULL_NO_ISO[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_FULL_NO_ISO, aes(Plot_Times, TW_PZ_01_FULL_NO_ISO[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_01_FULL_NO_ISO[,"m_manual"]), color="orange3", size=3) 
ggsave("TW_PZ_01_NO_ISO_FULL_manual.pdf", width = 12, height = 6)                             
                       
################ TW_PZ_01_SAND ################

# June 2019
Plot_Times<-as.POSIXct(TW_PZ_01_SAND_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_SAND_Jun319, aes(Plot_Times, TW_PZ_01_SAND_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.3,-.3)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_01_SAND_11-20-18_to_6-3-19.pdf", width = 12, height = 6)  
# June with manual
Plot_Times<-as.POSIXct(TW_PZ_01_SAND_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_01_SAND_Jun319, aes(Plot_Times, TW_PZ_01_SAND_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_01_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.3,-.3)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_01_SAND_Jun319[,"m_manual"]), color="orange3", size=3)                            
ggsave("TW_PZ_01_SAND_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)  

################ TW_01_GRAD ################

# Full dataset
Plot_Times<-as.POSIXct(TW_Grad_01_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_01_FULL, aes(Plot_Times, TW_Grad_01_FULL[,"dh/dz"]))+geom_point(color='royalblue3', size=0.3) + xlab("Date") + ylab("Vertical Hydraulic Gradient")+ scale_y_reverse(limits =c(.3,-.3), breaks=(seq(-.4,1,0.1)))+ ggtitle("TW_Gradient_01")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_Grad_01_FULL.pdf", width = 12, height = 6)                        

# Plot head measurements together
# Complete with manual
Plot_Times<-as.POSIXct(TW_Grad_01_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_01_FULL, aes(Plot_Times))+geom_line(aes(y=Peat_head_m, colour='Peat'), size=0.3)+geom_line(aes(y=Sand_head_m, colour='Sand'), size=0.3)+ geom_point(aes(y=Peat_manual, color='Peat manual'), size=3)+ geom_point(aes(y=Sand_manual, color='Sand manual'), size=3, shape=17)+ xlab("Date")+ ylab("Head (m)")+ scale_y_continuous(limits = c(-1, 0.8), breaks = seq(-1, 0.8, by = 0.5)) + ggtitle("PEAT/SAND 01")+ scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+scale_colour_manual(values=c("#bf812d","#543005","#5ab4ac","#003c30"))
ggsave("TW_PZ-SAND_01_FULL.pdf", width = 12, height = 6) 
# Complete with manual - ZOOM
Plot_Times<-as.POSIXct(TW_Grad_01_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_01_FULL, aes(Plot_Times))+geom_line(aes(y=Peat_head_m, colour='Peat'), size=0.3)+geom_line(aes(y=Sand_head_m, colour='Sand'), size=0.3)+ geom_point(aes(y=Peat_manual, color='Peat manual'), size=3)+ geom_point(aes(y=Sand_manual, color='Sand manual'), size=3, shape=17)+ xlab("Date")+ ylab("Head (m)")+ scale_y_continuous(limits = c(-0.4, 0.3), breaks = seq(-0.4, 0.3, by = 0.1)) + ggtitle("PEAT/SAND 01")+ scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+scale_colour_manual(values=c("#bf812d","#543005","#5ab4ac","#003c30"))
ggsave("TW_PZ-SAND_01_FULL_ZOOM.pdf", width = 12, height = 6) 

################ TW_PZ_02 ################
Plot_Times<-as.POSIXct(TW_PZ_02_5_6[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_5_6, aes(Plot_Times, TW_PZ_02_5_6[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0.2,.6) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_02_3_24.pdf", width = 12, height = 6)  

# June 2018      
Plot_Times<-as.POSIXct(TW_PZ_02_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_Jun2018, aes(Plot_Times, TW_PZ_02_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0,.7) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_WL_2018_06_18/processed/TW_PZ_02_5-6-18_to_6-18-18.pdf", width = 12, height = 6) 
# June with manual
Plot_Times<-as.POSIXct(TW_PZ_02_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_Jun2018, aes(Plot_Times, TW_PZ_02_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0,.7) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_02_Jun2018[,"m_manual"]), color="orange3", size=3)                            
ggsave("TW_WL_2018_06_18/processed/TW_PZ_02_5-6-18_to_6-18-18_manual.pdf", width = 12, height = 6)               
                 
# July 2018                    
Plot_Times<-as.POSIXct(TW_PZ_02_Jul2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_Jul2018, aes(Plot_Times, TW_PZ_02_Jul2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0,.6) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_WL_2018_07_11/processed/TW_PZ_02_6-18-18_to_7-11-18.pdf", width = 12, height = 6) 
# July with manual
Plot_Times<-as.POSIXct(TW_PZ_02_Jul2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_Jul2018, aes(Plot_Times, TW_PZ_02_Jul2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0,.6) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_02_Jul2018[,"m_manual"]), color="orange3", size=3)                            
ggsave("TW_WL_2018_07_11/processed/TW_PZ_02_6-18-18_to_7-11-18_manual.pdf", width = 12, height = 6) 
 
# November 2018                         
Plot_Times<-as.POSIXct(TW_PZ_02_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_Nov2018, aes(Plot_Times, TW_PZ_02_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0,.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_02_7-11-18_to_11-20-18.pdf", width = 12, height = 6)  
# November with manual
Plot_Times<-as.POSIXct(TW_PZ_02_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_Nov2018, aes(Plot_Times, TW_PZ_02_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0,.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_02_Nov2018[,"m_manual"]), color="orange3", size=3)                            
ggsave("TW_PZ_02_7-11-18_to_11-20-18_manual.pdf", width = 12, height = 6)                         

# June 2019                   
Plot_Times<-as.POSIXct(TW_PZ_02_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_Jun319, aes(Plot_Times, TW_PZ_02_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0,.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_02_11-20-18_to_6-3-19.pdf", width = 12, height = 6) 
# June with manual
Plot_Times<-as.POSIXct(TW_PZ_02_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_Jun319, aes(Plot_Times, TW_PZ_02_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0,.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_02_Jun319[,"m_manual"]), color="orange3", size=3)                            
ggsave("TW_PZ_02_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)  

# Complete PZ_02 dataset
Plot_Times<-as.POSIXct(TW_PZ_02_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_FULL, aes(Plot_Times, TW_PZ_02_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(0,0.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_02_FULL.pdf", width = 12, height = 6)  
# Complete with manual
Plot_Times<-as.POSIXct(TW_PZ_02_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_02_FULL, aes(Plot_Times, TW_PZ_02_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_02")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_02_FULL[,"m_manual"]), color="orange3", size=3) 
ggsave("TW_PZ_02_FULL_manual.pdf", width = 12, height = 6)  

################ TW_SW_02 ################
# November 2018
Plot_Times<-as.POSIXct(TW_SW_02_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_02_Nov2018, aes(Plot_Times, TW_SW_02_Nov2018[,"m_water"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_02_6-18-18_to_11-20-18.pdf", width = 12, height = 6)
# November with manual
Plot_Times<-as.POSIXct(TW_SW_02_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_02_Nov2018, aes(Plot_Times, TW_SW_02_Nov2018[,"m_water"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_02_Nov2018[,"m_manual"]), color="orange3", size=3)                                                                                                                      
ggsave("TW_SW_02_6-18-18_to_11-20-18_manual.pdf", width = 12, height = 6)
# June 2019                       
Plot_Times<-as.POSIXct(TW_SW_02_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_02_Jun319, aes(Plot_Times, TW_SW_02_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.7) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_02_11-20-18_to_6-3-19.pdf.pdf", width = 12, height = 6)
# June with manual
Plot_Times<-as.POSIXct(TW_SW_02_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_02_Jun319, aes(Plot_Times, TW_SW_02_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.7) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))   + geom_point(aes(x=Plot_Times, y=TW_SW_02_Jun319[,"m_manual"]), color="orange3", size=3)                                                                        
ggsave("TW_SW_02_11-20-18_to_6-3-19_manual.pdf.pdf", width = 12, height = 6)
# Complete SW_02 dataset
Plot_Times<-as.POSIXct(TW_SW_02_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_02_FULL, aes(Plot_Times, TW_SW_02_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_02")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(0,0.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_SW_02_FULL.pdf", width = 12, height = 6)  
# Complete with manual
Plot_Times<-as.POSIXct(TW_SW_02_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_02_FULL, aes(Plot_Times, TW_SW_02_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_02")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_SW_02_FULL[,"m_manual"]), color="orange3", size=3) 
ggsave("TW_SW_02_FULL_manual.pdf", width = 12, height = 6)  

################ TW_Grad_02 ################
Plot_Times<-as.POSIXct(TW_Grad_02_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_02_Nov2018, aes(Plot_Times, TW_Grad_02_Nov2018[,"dh/dz"]))+geom_line(color='darkolivegreen', size=0.5) + xlab("Date") + ylab("Vertical Hydraulic Gradient")+ scale_y_reverse(limits =c(0,-.3))+ ggtitle("TW_Gradient_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_Grad_02_7-12-18_to_11-20-18.pdf", width = 12, height = 6) 

Plot_Times<-as.POSIXct(TW_Grad_02_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_02_Jun319, aes(Plot_Times, TW_Grad_02_Jun319[,"dh/dz"]))+geom_line(color='darkolivegreen', size=0.5) + xlab("Date") + ylab("Vertical Hydraulic Gradient")+ scale_y_reverse(limits =c(0,-.3))+ ggtitle("TW_Gradient_02")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_Grad_02_11-20-18_to_6-3-19.pdf", width = 12, height = 6) 

Plot_Times<-as.POSIXct(TW_Grad_02_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_02_FULL, aes(Plot_Times, TW_Grad_02_FULL[,"dh/dz"]))+geom_point(color='royalblue3', size=0.3) + xlab("Date") + ylab("Vertical Hydraulic Gradient")+ scale_y_reverse(limits =c(0,-.3), breaks=(seq(-.3,0,.1)))+ ggtitle("TW_Gradient_02")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_Grad_02_FULL.pdf", width = 12, height = 6) 
  
# Plot head measurements together
# Complete with manual
Plot_Times<-as.POSIXct(TW_Grad_02_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_02_FULL, aes(Plot_Times))+geom_line(aes(y=PZ_m_above_GS, colour='PZ'), size=0.3)+geom_line(aes(y=SW_m_above_GS, colour='SW'), size=0.3)+ geom_point(aes(y=PZ_manual, color='PZ manual'), size=3)+ geom_point(aes(y=SW_manual, color='SW manual'), size=3, shape=17)+ xlab("Date")+ ylab("Head (m)")+ scale_y_continuous(limits = c(-1, 0.8), breaks = seq(-1, 0.8, by = 0.5)) + ggtitle("PZ/SW 02")+ scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+scale_colour_manual(values=c("#bf812d","#543005","#5ab4ac","#003c30"))
ggsave("TW_PZ-SW_02_FULL.pdf", width = 12, height = 6) 
# Complete with manual - ZOOM
Plot_Times<-as.POSIXct(TW_Grad_02_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_02_FULL, aes(Plot_Times))+geom_line(aes(y=PZ_m_above_GS, colour='PZ'), size=0.3)+geom_line(aes(y=SW_m_above_GS, colour='SW'), size=0.3)+ geom_point(aes(y=PZ_manual, color='PZ manual'), size=3)+ geom_point(aes(y=SW_manual, color='SW manual'), size=3, shape=17)+ xlab("Date")+ ylab("Head (m)")+ scale_y_continuous(limits = c(0.1, 0.8), breaks = seq(0.1, 0.8, by = 0.1)) + ggtitle("PZ/SW 02")+ scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+scale_colour_manual(values=c("#bf812d","#543005","#5ab4ac","#003c30"))
ggsave("TW_PZ-SW_02_FULL_ZOOM.pdf", width = 12, height = 6) 

################ TW_PZ_03 ################
# June 2018 
Plot_Times<-as.POSIXct(TW_PZ_03_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_03_Jun2018, aes(Plot_Times, TW_PZ_03_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_PZ_03_5-6-18_to_6-18-18.pdf", width = 12, height = 6)
# June with manual                      
Plot_Times<-as.POSIXct(TW_PZ_03_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_03_Jun2018, aes(Plot_Times, TW_PZ_03_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_03_Jun2018[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_PZ_03_5-6-18_to_6-18-18_manual.pdf", width = 12, height = 6)
# July 2018 data missing - malfunctioning logger
# November 2018                      
Plot_Times<-as.POSIXct(TW_PZ_03_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_03_Nov2018, aes(Plot_Times, TW_PZ_03_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_PZ_03_7-12-18_to_11-20-18.pdf", width = 12, height = 6)
# November with manual                      
Plot_Times<-as.POSIXct(TW_PZ_03_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_03_Nov2018, aes(Plot_Times, TW_PZ_03_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_03_Nov2018[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_PZ_03_7-12-18_to_11-20-18_manual.pdf", width = 12, height = 6)                       
# June 2019
Plot_Times<-as.POSIXct(TW_PZ_03_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_03_Jun319, aes(Plot_Times, TW_PZ_03_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_PZ_03_11-20-18_to_6-3-19.pdf", width = 12, height = 6)
# June with manual
Plot_Times<-as.POSIXct(TW_PZ_03_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_03_Jun319, aes(Plot_Times, TW_PZ_03_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_03_Jun319[,"m_manual"]), color="orange3", size=3)                                                                           
ggsave("TW_PZ_03_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)

# Complete PZ_03 dataset
Plot_Times<-as.POSIXct(TW_PZ_03_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_03_FULL, aes(Plot_Times, TW_PZ_03_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_03")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(0,0.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_03_FULL.pdf", width = 12, height = 6)  
# Complete with manual
Plot_Times<-as.POSIXct(TW_PZ_03_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_03_FULL, aes(Plot_Times, TW_PZ_03_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_03")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") + ylim(0,0.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_03_FULL[,"m_manual"]), color="orange3", size=3) 
ggsave("TW_PZ_03_FULL_manual.pdf", width = 12, height = 6)  

################ TW_SW_03 ################
# June 2018 - MALFUNCTIONING
Plot_Times<-as.POSIXct(TW_SW_03_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_03_Jun2018, aes(Plot_Times, TW_SW_03_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(-0.5,1) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_03_5-6-18_to_6-18-18_MALFUNC.pdf", width = 12, height = 6)
# June with manual 
Plot_Times<-as.POSIXct(TW_SW_03_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_03_Jun2018, aes(Plot_Times, TW_SW_03_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(-0.5,1) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_03_Jun2018[,"m_manual"]), color="orange3", size=3)                                                                                                                      
ggsave("TW_SW_03_5-6-18_to_6-18-18_manual_MALFUNC.pdf", width = 12, height = 6)

# November 2018 - MALFUNCTIONING
Plot_Times<-as.POSIXct(TW_SW_03_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_03_Nov2018, aes(Plot_Times, TW_SW_03_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(-1,3) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_03_6-18-18_to_11-20-18_MALFUNC.pdf", width = 12, height = 6)
# November with manual 
Plot_Times<-as.POSIXct(TW_SW_03_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_03_Nov2018, aes(Plot_Times, TW_SW_03_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(-1,3) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_03_Nov2018[,"m_manual"]), color="orange3", size=3)                                                                                                                      
ggsave("TW_SW_03_6-18-18_to_11-20-18_manual_MALFUNC.pdf", width = 12, height = 6)
                                                            
# June 2019 - MALFUNCTIONING
Plot_Times<-as.POSIXct(TW_SW_03_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_03_Jun319, aes(Plot_Times, TW_SW_03_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(-1,3) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_03_11-20-18_to_6-3-19.pdf", width = 12, height = 6)
# June with manual 
Plot_Times<-as.POSIXct(TW_SW_03_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_03_Jun319, aes(Plot_Times, TW_SW_03_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(-1,3) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_03")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_03_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                                                      
ggsave("TW_SW_03_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)

# Complete PZ_03 dataset
Plot_Times<-as.POSIXct(TW_SW_03_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_03_FULL, aes(Plot_Times, TW_SW_03_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_03")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(-1,3) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_SW_03_FULL_MALFUNC.pdf", width = 12, height = 6)  
# Complete with manual
Plot_Times<-as.POSIXct(TW_SW_03_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_03_FULL, aes(Plot_Times, TW_SW_03_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_03")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") + ylim(-1,3) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_SW_03_FULL[,"m_manual"]), color="orange3", size=3) 
ggsave("TW_SW_03_FULL_manual_MALFUNC.pdf", width = 12, height = 6)  
                                                                                      
################ TW_PZ_04 ################

# June 2018
Plot_Times<-as.POSIXct(TW_PZ_04_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_Jun2018, aes(Plot_Times, TW_PZ_04_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))     
ggsave("TW_WL_2018_06_18/processed/TW_PZ_04_5-6-18_to_6-18-18.pdf", width = 12, height = 6)          
# June manual data                 
Plot_Times<-as.POSIXct(TW_PZ_04_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_Jun2018, aes(Plot_Times, TW_PZ_04_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_04_Jun2018[,"m_manual"]), color="orange3", size=3)      
ggsave("TW_WL_2018_06_18/processed/TW_PZ_04_5-6-18_to_6-18-18_manual.pdf", width = 12, height = 6)        
    
# November 2018                
Plot_Times<-as.POSIXct(TW_PZ_04_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_Nov2018, aes(Plot_Times, TW_PZ_04_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))     
ggsave("TW_PZ_04_6-18-18_to_11-20-18.pdf", width = 12, height = 6)          
# November manual data                 
Plot_Times<-as.POSIXct(TW_PZ_04_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_Nov2018, aes(Plot_Times, TW_PZ_04_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_04_Nov2018[,"m_manual"]), color="orange3", size=3)      
ggsave("TW_PZ_04_6-18-18_to_11-20-18_manual.pdf", width = 12, height = 6)        
                                  
# June 2019 uncorrected rise                    
Plot_Times<-as.POSIXct(TW_PZ_04_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_Jun319, aes(Plot_Times, TW_PZ_04_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(-.75,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))     
ggsave("TW_PZ_04_11-20-18_to_6-3-19_RISE.pdf", width = 12, height = 6)
# June with manual data
Plot_Times<-as.POSIXct(TW_PZ_04_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_Jun319, aes(Plot_Times, TW_PZ_04_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(-.75,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_04_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                
ggsave("TW_PZ_04_11-20-18_to_6-3-19_RISE_manual.pdf", width = 12, height = 6)
# June 2019 without rise
Plot_Times<-as.POSIXct(TW_PZ_04_Jun319_norise[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_Jun319_norise, aes(Plot_Times, TW_PZ_04_Jun319_norise[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                                                         
ggsave("TW_PZ_04_11-20-18_to_6-3-19.pdf", width = 12, height = 6)
# June without rise with manual
Plot_Times<-as.POSIXct(TW_PZ_04_Jun319_norise[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_Jun319_norise, aes(Plot_Times, TW_PZ_04_Jun319_norise[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_04_Jun319_norise[,"m_manual"]), color="orange3", size=3)                                                                           
ggsave("TW_PZ_04_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)

# Complete PZ_04 dataset
Plot_Times<-as.POSIXct(TW_PZ_04_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_FULL, aes(Plot_Times, TW_PZ_04_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(-1,0.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_04_FULL.pdf", width = 12, height = 6)  
# Complete with manual
Plot_Times<-as.POSIXct(TW_PZ_04_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_FULL, aes(Plot_Times, TW_PZ_04_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(-1,0.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_04_FULL[,"m_manual"]), color="orange3", size=3)                                          
ggsave("TW_PZ_04_FULL_manual.pdf", width = 12, height = 6)  

# Complete PZ_04 dataset
Plot_Times<-as.POSIXct(TW_PZ_04_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_FULL, aes(Plot_Times, TW_PZ_04_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(0,0.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_04_FULL_ZOOM.pdf", width = 12, height = 6)  
# Complete with manual
Plot_Times<-as.POSIXct(TW_PZ_04_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_04_FULL, aes(Plot_Times, TW_PZ_04_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_04")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(0,0.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_04_FULL[,"m_manual"]), color="orange3", size=3)                                          
ggsave("TW_PZ_04_FULL_ZOOM_manual.pdf", width = 12, height = 6)  

################ TW_SW_04 ################
 
# June 2018
Plot_Times<-as.POSIXct(TW_SW_04_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_Jun2018, aes(Plot_Times, TW_SW_04_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_04_5-6-18_to_6-18-18.pdf", width = 12, height = 6)
# June with manual
Plot_Times<-as.POSIXct(TW_SW_04_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_Jun2018, aes(Plot_Times, TW_SW_04_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_04_Jun2018[,"m_manual"]), color="orange3", size=3)                                                
ggsave("TW_SW_04_5-6-18_to_6-18-18_manual.pdf", width = 12, height = 6)

# July 2018
Plot_Times<-as.POSIXct(TW_SW_04_Jul2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_Jul2018, aes(Plot_Times, TW_SW_04_Jul2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_04_6-18-18_to_7-12-18.pdf", width = 12, height = 6)
# July with manual
Plot_Times<-as.POSIXct(TW_SW_04_Jul2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_Jul2018, aes(Plot_Times, TW_SW_04_Jul2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_04_Jul2018[,"m_manual"]), color="orange3", size=3)                                                
ggsave("TW_SW_04_6-18-18_to_7-12-18_manual.pdf", width = 12, height = 6)
                                          
# November 2018
Plot_Times<-as.POSIXct(TW_SW_04_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_Nov2018, aes(Plot_Times, TW_SW_04_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_04_7-12-18_to_11-20-18.pdf", width = 12, height = 6)
# November with manual
Plot_Times<-as.POSIXct(TW_SW_04_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_Nov2018, aes(Plot_Times, TW_SW_04_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_04_Nov2018[,"m_manual"]), color="orange3", size=3)                                                
ggsave("TW_SW_04_7-12-18_to_11-20-18_manual.pdf", width = 12, height = 6)
#June 2019
Plot_Times<-as.POSIXct(TW_SW_04_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_Jun319, aes(Plot_Times, TW_SW_04_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_04_11-20-18_to_6-3-19.pdf", width = 12, height = 6)
# Add manual data
Plot_Times<-as.POSIXct(TW_SW_04_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_Jun319, aes(Plot_Times, TW_SW_04_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_04_Jun319[,"m_manual"]), color="orange3", size=3)                                                                           
ggsave("TW_SW_04_11-20-18_to_6-3-19_manual.pdf", width = 12, height = 6)                                           

# Complete SW_04 dataset
Plot_Times<-as.POSIXct(TW_SW_04_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_FULL, aes(Plot_Times, TW_SW_04_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(0,0.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_SW_04_FULL.pdf", width = 12, height = 6)  
# Complete with manual
Plot_Times<-as.POSIXct(TW_SW_04_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_04_FULL, aes(Plot_Times, TW_SW_04_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_04")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(0,0.8) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_SW_04_FULL[,"m_manual"]), color="orange3", size=3)                                          
ggsave("TW_SW_04_FULL_manual.pdf", width = 12, height = 6)  

################ TW_Grad_04 ################
		       
# Plot vertical gradient over time		       
Plot_Times<-as.POSIXct(TW_Grad_04_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_04_Nov2018, aes(Plot_Times, TW_Grad_04_Nov2018[,"dh/dz"]))+geom_line(color='darkgreen', size=0.5) + xlab("Date") + ylab("Vertical Hydraulic Gradient")+ scale_y_reverse(limits =c(.5,-.2))+ ggtitle("TW_Gradient_04")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_Grad_04_7-12-18_to_11-20-18.pdf", width = 12, height = 6) 

# Full dataset          
Plot_Times<-as.POSIXct(TW_Grad_04_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_04_FULL, aes(Plot_Times, TW_Grad_04_FULL[,"dh/dz"]))+geom_point(color='royalblue3', size=0.3) + xlab("Date") + ylab("Vertical Hydraulic Gradient")+ scale_y_reverse(limits =c(1,-.4), breaks=(seq(-.4,1,.1)))+ ggtitle("TW_Gradient_04")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_Grad_04_FULL.pdf", width = 12, height = 6)                      

# Full dataset - ZOOM         
Plot_Times<-as.POSIXct(TW_Grad_04_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_04_FULL, aes(Plot_Times, TW_Grad_04_FULL[,"dh/dz"]))+geom_point(color='royalblue3', size=0.3) + xlab("Date") + ylab("Vertical Hydraulic Gradient")+ scale_y_reverse(limits =c(0.2,-.3), breaks=(seq(-.4,1,.1)))+ ggtitle("TW_Gradient_04")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_Grad_04_FULL_ZOOM.pdf", width = 12, height = 6)                        
    
# Plot all head measurements together
# Complete with manual
Plot_Times<-as.POSIXct(na.omit(TW_Grad_04_FULL)[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(na.omit(TW_Grad_04_FULL), aes(Plot_Times))+geom_line(aes(y=PZ_m_above_GS, colour='PZ'), size=0.3)+geom_line(aes(y=SW_m_above_GS, colour='SW'), size=0.3)+scale_colour_manual(values=c("#bf812d","#5ab4ac"))+ xlab("Date")+ ylab("Head (m)")+ ylim(-1,0.8)+ ggtitle("TW_PZ/SW_04")+ scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ-SW_04_FULL.pdf", width = 12, height = 6) 
# Complete with manual - ZOOMED
Plot_Times<-as.POSIXct(na.omit(TW_Grad_04_FULL)[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(na.omit(TW_Grad_04_FULL), aes(Plot_Times))+geom_line(aes(y=PZ_m_above_GS, colour='PZ'), size=0.3)+geom_line(aes(y=SW_m_above_GS, colour='SW'), size=0.3)+scale_colour_manual(values=c("#bf812d","#5ab4ac"))+ xlab("Date")+ ylab("Head (m)")+ ylim(0,0.7)+ ggtitle("TW_PZ/SW_04")+ scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ-SW_04_FULL_ZOOM.pdf", width = 12, height = 6) 

# Plot all head measurements together
# Need to do a little extra work to plot all of the PZ/SW 04 data together because the measurement time interval on the SW 04 logger was > 15 minutes for a period of time
# Create individual data frames for the processed PZ and SW data (logger and manual) 
# PZ logger
PZ4<-na.omit(TW_Grad_04_FULL[,c("Date_Time","PZ_m_above_GS")])
colnames(PZ4)<-c("x","y")
PZ4[,"x"]<-as.POSIXct(PZ4[,"x"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
# SW logger
SW4<-na.omit(TW_Grad_04_FULL[,c("Date_Time","SW_m_above_GS")])
colnames(SW4)<-c("x","y")
SW4[,"x"]<-as.POSIXct(SW4[,"x"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
# PZ manual
PZ4_man<-na.omit(TW_Grad_04_FULL[,c("Date_Time","PZ_manual")])
colnames(PZ4_man)<-c("x","y")
PZ4_man[,"x"]<-as.POSIXct(PZ4_man[,"x"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
# SW manual
SW4_man<-na.omit(TW_Grad_04_FULL[,c("Date_Time","SW_manual")])
colnames(SW4_man)<-c("x","y")
SW4_man[,"x"]<-as.POSIXct(SW4_man[,"x"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
# Bind all of the data frames together
FULL04<-rbind(PZ4, SW4, PZ4_man, SW4_man)
# Add a column with an ID tag for which data frame the row came from
FULL04$ID <- c(rep("PZ", nrow(PZ4)), rep("SW", nrow(SW4)), rep("PZ_man", nrow(PZ4_man)), rep("SW_man", nrow(SW4_man)))

# Plot the data! 
ggplot() + geom_line(data = PZ4, aes(x, y, color='PZ'), size=0.3) + geom_line(data = SW4, aes(x, y, color='SW'), size=0.3) + geom_point(data = PZ4_man, aes(x, y, color='PZ manual'), size=3)+ geom_point(data = SW4_man, aes(x, y, color='SW manual'), shape=17, size=3)+ xlab("Date")+ ylab("Head (m)")+ scale_y_continuous(limits = c(-1, 0.8), breaks = seq(-1, 0.8, by = 0.5))+ ggtitle("PZ/SW_04")+ scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+scale_colour_manual(values=c("#bf812d","#543005","#5ab4ac","#003c30"))
ggsave("TW_PZ-SW_04_FULL.pdf", width = 12, height = 6) 
  
ggplot() + geom_line(data = PZ4, aes(x, y, color='PZ'), size=0.3) + geom_line(data = SW4, aes(x, y, color='SW'), size=0.3) + geom_point(data = PZ4_man, aes(x, y, color='PZ manual'), size=3)+ geom_point(data = SW4_man, aes(x, y, color='SW manual'), shape=17, size=3)+ xlab("Date")+ ylab("Head (m)")+ scale_y_continuous(limits = c(0.1, 0.7), breaks = seq(0.1, 0.7, by = 0.1))+ ggtitle("PZ/SW_04")+ scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+scale_colour_manual(values=c("#bf812d","#543005","#5ab4ac","#003c30"))
ggsave("TW_PZ-SW_04_FULL_ZOOM.pdf", width = 12, height = 6) 

################ TW_PZ_05 ################
Plot_Times<-as.POSIXct(TW_PZ_05_3_3[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_3_3, aes(Plot_Times, TW_PZ_05_3_3[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1,-.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_05_3_3.pdf", width = 12, height = 6)

# November                       
Plot_Times<-as.POSIXct(TW_PZ_05_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_Nov2018, aes(Plot_Times, TW_PZ_05_Nov2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.8,-.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_05_Nov.pdf", width = 12, height = 6)
# November with manual
Plot_Times<-as.POSIXct(TW_PZ_05_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_Nov2018, aes(Plot_Times, TW_PZ_05_Nov2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.8,-.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_05_Nov2018[,"m_manual"]), color="orange3", size=3)                         
ggsave("TW_PZ_05_6-19-18_to_11-19-18_manual.pdf", width = 12, height = 6)
# June                       
Plot_Times<-as.POSIXct(TW_PZ_05_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_Jun319, aes(Plot_Times, TW_PZ_05_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1.0,-0.3)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                       
ggsave("TW_PZ_05_11-19-18_to_6-3-19.pdf", width = 12, height = 6)
# June with manual
Plot_Times<-as.POSIXct(TW_PZ_05_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_Jun319, aes(Plot_Times, TW_PZ_05_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1.0,-0.3)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))  + geom_point(aes(x=Plot_Times, y=TW_PZ_05_Jun319[,"m_manual"]), color="orange3", size=3)                         
ggsave("TW_PZ_05_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6)

################ TW_PZ_05_SAND ################
# November 2018
Plot_Times<-as.POSIXct(TW_PZ_05_SAND_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_SAND_Nov2018, aes(Plot_Times, TW_PZ_05_SAND_Nov2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                       
ggsave("TW_PZ_05_SAND_6-18-18_to_11-19-18.pdf", width = 12, height = 6)     
# November with manual                       
Plot_Times<-as.POSIXct(TW_PZ_05_SAND_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_SAND_Nov2018, aes(Plot_Times, TW_PZ_05_SAND_Nov2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))  + geom_point(aes(x=Plot_Times, y=TW_PZ_05_SAND_Nov2018[,"m_manual"]), color="orange3", size=3)                                            
ggsave("TW_PZ_05_SAND_6-18-18_to_11-19-18_manual.pdf", width = 12, height = 6)                                                                     
  
# June 2019 - malfunctioning 

# Complete PZ_05_SAND dataset    
Plot_Times<-as.POSIXct(TW_PZ_05_SAND_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_SAND_FULL, aes(Plot_Times, TW_PZ_05_SAND_FULL[,"m_below_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05_SAND")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                           
ggsave("TW_PZ_05_SAND_FULL.pdf", width = 12, height = 6)                                                                     
# Complete with manual   
Plot_Times<-as.POSIXct(TW_PZ_05_SAND_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_05_SAND_FULL, aes(Plot_Times, TW_PZ_05_SAND_FULL[,"m_below_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_05_SAND")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))  + geom_point(aes(x=Plot_Times, y=TW_PZ_05_SAND_FULL[,"m_manual"]), color="orange3", size=3)                                            
ggsave("TW_PZ_05_SAND_FULL_manual.pdf", width = 12, height = 6)                                                                     
     
################ TW_PZ_06 ################
Plot_Times<-as.POSIXct(TW_PZ_06_3_19[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_3_19, aes(Plot_Times, TW_PZ_06_3_19[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) 
ggsave("TW_PZ_06_3_19.pdf", width = 12, height = 6) 
 
# November                                       
Plot_Times<-as.POSIXct(TW_PZ_06_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_Nov2018, aes(Plot_Times, TW_PZ_06_Nov2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_06_6-18-18_to_11-29-18.pdf", width = 12, height = 6) 
# November with manual
Plot_Times<-as.POSIXct(TW_PZ_06_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_Nov2018, aes(Plot_Times, TW_PZ_06_Nov2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_06_Nov2018[,"m_manual"]), color="orange3", size=3)
ggsave("TW_PZ_06_6-18-18_to_11-29-18_manual.pdf", width = 12, height = 6) 

# June
Plot_Times<-as.POSIXct(TW_PZ_06_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_Jun319, aes(Plot_Times, TW_PZ_06_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.8,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_06_11-19-18_to_6-3-19_RISE.pdf", width = 12, height = 6) 
# June with manual
Plot_Times<-as.POSIXct(TW_PZ_06_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_Jun319, aes(Plot_Times, TW_PZ_06_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.8,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_06_Jun319[,"m_manual"]), color="orange3", size=3)                                                                           
ggsave("TW_PZ_06_11-19-18_to_6-3-19_RISE_manual.pdf", width = 12, height = 6) 
# June without rise
Plot_Times<-as.POSIXct(TW_PZ_06_Jun319_norise[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_Jun319_norise, aes(Plot_Times, TW_PZ_06_Jun319_norise[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_06_11-19-18_to_6-3-19.pdf", width = 12, height = 6) 
# June without rise with manual
Plot_Times<-as.POSIXct(TW_PZ_06_Jun319_norise[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_Jun319_norise, aes(Plot_Times, TW_PZ_06_Jun319_norise[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.3,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_06_Jun319_norise[,"m_manual"]), color="orange3", size=3)                                                                           
ggsave("TW_PZ_06_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6) 

# Complete PZ_06 dataset    
Plot_Times<-as.POSIXct(TW_PZ_06_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_FULL, aes(Plot_Times, TW_PZ_06_FULL[,"m_below_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(.9,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                           
ggsave("TW_PZ_06_FULL.pdf", width = 12, height = 6)                                                                     
# Complete with manual   
Plot_Times<-as.POSIXct(TW_PZ_06_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_FULL, aes(Plot_Times, TW_PZ_06_FULL[,"m_below_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(.9,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))  + geom_point(aes(x=Plot_Times, y=TW_PZ_06_FULL[,"m_manual"]), color="orange3", size=3)                                            
ggsave("TW_PZ_06_FULL_manual.pdf", width = 12, height = 6)                                                                     
     
# Complete PZ_06 dataset without big isotope dip on 3/30 
Plot_Times<-as.POSIXct(TW_PZ_06_FULL_NO_ISO[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_FULL_NO_ISO, aes(Plot_Times, TW_PZ_06_FULL_NO_ISO[,"m_below_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                           
ggsave("TW_PZ_06_FULL_NO_ISO.pdf", width = 12, height = 6)                                                                     
# Complete with manual   
Plot_Times<-as.POSIXct(TW_PZ_06_FULL_NO_ISO[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_FULL_NO_ISO, aes(Plot_Times, TW_PZ_06_FULL_NO_ISO[,"m_below_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))  + geom_point(aes(x=Plot_Times, y=TW_PZ_06_FULL_NO_ISO[,"m_manual"]), color="orange3", size=3)                                            
ggsave("TW_PZ_06_FULL_NO_ISOmanual.pdf", width = 12, height = 6)                                                                     
     
################ TW_PZ_06_SAND ################
# November 2018
Plot_Times<-as.POSIXct(TW_PZ_06_SAND_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_SAND_Nov2018, aes(Plot_Times, TW_PZ_06_SAND_Nov2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                    
ggsave("TW_PZ_06_SAND_6-18-18_to_11-19-18_malfunc.pdf", width = 12, height = 6)        
# November with manual
Plot_Times<-as.POSIXct(TW_PZ_06_SAND_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_SAND_Nov2018, aes(Plot_Times, TW_PZ_06_SAND_Nov2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))  + geom_point(aes(x=Plot_Times, y=TW_PZ_06_SAND_Nov2018[,"m_manual"]), color="orange3", size=3)                                                                                                                
ggsave("TW_PZ_06_SAND_6-18-18_to_11-19-18_manual_malfunc.pdf", width = 12, height = 6)        

# June 2019
Plot_Times<-as.POSIXct(TW_PZ_06_SAND_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_SAND_Jun319, aes(Plot_Times, TW_PZ_06_SAND_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1,-.5)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) 
ggsave("TW_PZ_06_SAND_11-19-18_to_6-3-19.pdf", width = 12, height = 6)   

Plot_Times<-as.POSIXct(TW_PZ_06_SAND_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_SAND_Jun319, aes(Plot_Times, TW_PZ_06_SAND_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(1,-.5)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_06_SAND_Jun319[,"m_manual"]), color="orange3", size=3)                                                                           
ggsave("TW_PZ_06_SAND_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6)  

# Complete PZ_06_SAND dataset    
Plot_Times<-as.POSIXct(TW_PZ_06_SAND_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_SAND_FULL, aes(Plot_Times, TW_PZ_06_SAND_FULL[,"m_below_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06_SAND")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(1,-.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                           
ggsave("TW_PZ_06_SAND_FULL.pdf", width = 12, height = 6)                                                                     
# Complete with manual   
Plot_Times<-as.POSIXct(TW_PZ_06_SAND_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_06_SAND_FULL, aes(Plot_Times, TW_PZ_06_SAND_FULL[,"m_below_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_06_SAND")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(1,-.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))  + geom_point(aes(x=Plot_Times, y=TW_PZ_06_SAND_FULL[,"m_manual"]), color="orange3", size=3)                                            
ggsave("TW_PZ_06_SAND_FULL_manual.pdf", width = 12, height = 6)                                                                     

################ TW_PZ_07 ################
Plot_Times<-as.POSIXct(TW_PZ_07_3_19[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_3_19, aes(Plot_Times, TW_PZ_07_3_19[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ ylim(0,.3) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_07_3_19.pdf", width = 12, height = 6)  

# June 2018
Plot_Times<-as.POSIXct(TW_PZ_07_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_Jun2018, aes(Plot_Times, TW_PZ_07_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.4) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_PZ_07_5-6-18_to_6-18-18.pdf", width = 12, height = 6)
# November with manual
Plot_Times<-as.POSIXct(TW_PZ_07_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_Jun2018, aes(Plot_Times, TW_PZ_07_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.4) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))    + geom_point(aes(x=Plot_Times, y=TW_PZ_07_Jun2018[,"m_manual"]), color="orange3", size=3)                                               
ggsave("TW_PZ_07_5-6-18_to_6-18-18_manual.pdf", width = 12, height = 6)

# November 2018
Plot_Times<-as.POSIXct(TW_PZ_07_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_Nov2018, aes(Plot_Times, TW_PZ_07_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_PZ_07_Nov.pdf", width = 12, height = 6)
# November with manual
Plot_Times<-as.POSIXct(TW_PZ_07_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_Nov2018, aes(Plot_Times, TW_PZ_07_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))    + geom_point(aes(x=Plot_Times, y=TW_PZ_07_Nov2018[,"m_manual"]), color="orange3", size=3)                                               
ggsave("TW_PZ_07_6-18-18_to_11-19-18_manual.pdf", width = 12, height = 6)

#Plot_Times<-as.POSIXct(TW_PZ_07_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
#ggplot(TW_PZ_07_Nov, aes(Plot_Times, TW_PZ_07_Nov[,"m_stage"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
#ggsave("TW_PZ_07_Nov.pdf", width = 12, height = 6)       

# June 2019
Plot_Times<-as.POSIXct(TW_PZ_07_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_Jun319, aes(Plot_Times, TW_PZ_07_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_PZ_07_11-19-18_to_6-3-19.pdf", width = 12, height = 6)     
# June with manual 
Plot_Times<-as.POSIXct(TW_PZ_07_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_Jun319, aes(Plot_Times, TW_PZ_07_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))  + geom_point(aes(x=Plot_Times, y=TW_PZ_07_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_PZ_07_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6)                
      
# Complete PZ_07 dataset
Plot_Times<-as.POSIXct(TW_PZ_07_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_FULL, aes(Plot_Times, TW_PZ_07_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(0,0.5) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ_07_FULL.pdf", width = 12, height = 6)  
# Complete with manual
Plot_Times<-as.POSIXct(TW_PZ_07_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_07_FULL, aes(Plot_Times, TW_PZ_07_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Water Above Streambed (m)")+ggtitle("TW_PZ_07")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(0,0.5) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_PZ_07_FULL[,"m_manual"]), color="orange3", size=3)                                          
ggsave("TW_PZ_07_FULL_manual.pdf", width = 12, height = 6)  

################ TW_SW_07 ################
Plot_Times<-as.POSIXct(TW_SW_07_3_3[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_3_3, aes(Plot_Times, TW_SW_07_3_3[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.4) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_07_3_3.pdf", width = 12, height = 6)       

# June 2018 
Plot_Times<-as.POSIXct(TW_SW_07_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_Jun2018, aes(Plot_Times, TW_SW_07_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.4) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_07_5-6-18_to_6-18-18.pdf", width = 12, height = 6) 
# June with manual
Plot_Times<-as.POSIXct(TW_SW_07_Jun2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_Jun2018, aes(Plot_Times, TW_SW_07_Jun2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.4) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_07_Jun2018[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_SW_07_5-6-18_to_6-18-18_manual.pdf", width = 12, height = 6)   

# November 2018
Plot_Times<-as.POSIXct(TW_SW_07_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_Nov2018, aes(Plot_Times, TW_SW_07_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_07_6-18-18_to_11-19-18.pdf", width = 12, height = 6) 
# November with manual
Plot_Times<-as.POSIXct(TW_SW_07_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_Nov2018, aes(Plot_Times, TW_SW_07_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_07_Nov2018[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_SW_07_6-18-18_to_11-19-18_manual.pdf", width = 12, height = 6)                                                                           

# June 2019
Plot_Times<-as.POSIXct(TW_SW_07_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_Jun319, aes(Plot_Times, TW_SW_07_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_07_11-19-18_to_6-3-19.pdf", width = 12, height = 6) 
# June with manual
Plot_Times<-as.POSIXct(TW_SW_07_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_Jun319, aes(Plot_Times, TW_SW_07_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.5) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_07_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_SW_07_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6)                                                                           

# Complete SW_07 dataset
Plot_Times<-as.POSIXct(TW_SW_07_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_FULL, aes(Plot_Times, TW_SW_07_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.4) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(0,0.5) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_SW_07_FULL.pdf", width = 12, height = 6)  
# Complete with manual
Plot_Times<-as.POSIXct(TW_SW_07_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_07_FULL, aes(Plot_Times, TW_SW_07_FULL[,"m_above_GS"]))+geom_line(color='royalblue3', size=.4) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_07")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ ylim(0,0.5) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_point(aes(x=Plot_Times, y=TW_SW_07_FULL[,"m_manual"]), color="orange3", size=3)                                          
ggsave("TW_SW_07_FULL_manual.pdf", width = 12, height = 6)  

################ TW_Grad_07 ################
# Plot November 2018 vertical gradient
Plot_Times<-as.POSIXct(TW_Grad_07_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_07_Nov2018, aes(Plot_Times, TW_Grad_07_Nov2018[,"dh/dz"]))+geom_line(color='darkolivegreen', size=0.5) + xlab("Date") + ylab("Vertical Hydraulic Gradient")+ scale_y_reverse(limits =c(.1,-.1))+ ggtitle("TW_Gradient_07")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_Grad_07_6-18-18_to_11-19-18.pdf", width = 12, height = 6) 
       
# Full dataset
Plot_Times<-as.POSIXct(TW_Grad_07_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_Grad_07_FULL, aes(Plot_Times, TW_Grad_07_FULL[,"dh/dz"]))+geom_point(color='darkolivegreen', size=0.3) + xlab("Date") + ylab("Vertical Hydraulic Gradient")+ scale_y_reverse(limits =c(.3,-.3), breaks=(seq(-.4,1,.2)))+ ggtitle("TW_Gradient_07")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_Grad_07_FULL.pdf", width = 12, height = 6)                        

# Plot head measurements together
# Complete with manual
Plot_Times<-as.POSIXct(na.omit(TW_Grad_07_FULL)[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(na.omit(TW_Grad_07_FULL), aes(Plot_Times))+geom_line(aes(y=PZ_m_above_GS, colour='PZ'), size=0.3)+geom_line(aes(y=SW_m_above_GS, colour='SW'), size=0.3)+scale_colour_manual(values=c("#bf812d","#5ab4ac"))+ xlab("Date")+ ylab("Head (m)")+ ylim(-1,0.8)+ ggtitle("TW_PZ/SW_07")+ scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
#ggplot(na.omit(TW_Grad_07_FULL), aes(Plot_Times))+geom_line(aes(y=SW_m_above_GS, colour='SW'), size=0.3)+geom_line(aes(y=PZ_m_above_GS, colour='PZ'), size=0.3)+scale_color_brewer(palette="Dark2")+ xlab("Date")+ ylab("Head (m)")+ ylim(-1,0.8)+ ggtitle("TW_PZ/SW_07")+ scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ-SW_07_FULL.pdf", width = 12, height = 6) 
# Complete with manual - ZOOM
Plot_Times<-as.POSIXct(na.omit(TW_Grad_07_FULL)[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(na.omit(TW_Grad_07_FULL), aes(Plot_Times))+geom_line(aes(y=PZ_m_above_GS, colour='PZ'), size=0.3)+geom_line(aes(y=SW_m_above_GS, colour='SW'), size=0.3)+scale_colour_manual(values=c("#bf812d","#5ab4ac"))+ xlab("Date")+ ylab("Head (m)")+ ylim(0,0.7)+ ggtitle("TW_PZ/SW_07")+ scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y") +theme(axis.text.x = element_text(angle=45, vjust = 0.5))
ggsave("TW_PZ-SW_07_FULL_ZOOM.pdf", width = 12, height = 6) 
   
################ TW_PZ_08 ################
Plot_Times<-as.POSIXct(TW_PZ_08_3_3[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_3_3, aes(Plot_Times, TW_PZ_08_3_3[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.8,-.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))              
ggsave("TW_PZ_08_3_3.pdf", width = 12, height = 6)

# November
Plot_Times<-as.POSIXct(TW_PZ_08_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_Nov2018, aes(Plot_Times, TW_PZ_08_Nov2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                      
ggsave("TW_PZ_08_6-18-18_to_11-19-18.pdf", width = 12, height = 6)
# November with manual
Plot_Times<-as.POSIXct(TW_PZ_08_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_Nov2018, aes(Plot_Times, TW_PZ_08_Nov2018[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_PZ_08_Nov2018[,"m_manual"]), color="orange3", size=3)                                                                                                                                           
ggsave("TW_PZ_08_6-18-18_to_11-19-18_manual.pdf", width = 12, height = 6)

#Plot_Times<-as.POSIXct(TW_PZ_08_Nov[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
#ggplot(TW_PZ_08_Nov, aes(Plot_Times, TW_PZ_08_Nov[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(.6,-.1)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))+ geom_line(aes(x=Plot_Times, y=TW_PZ_08_Nov[,"denoised"]), color="orange3", size=.6)                       
#ggsave("TW_PZ_08_Nov.pdf", width = 12, height = 6)
# June
Plot_Times<-as.POSIXct(TW_PZ_08_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_Jun319, aes(Plot_Times, TW_PZ_08_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.8,-.4)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                      
ggsave("TW_PZ_08_11-19-18_to_6-3-19.pdf", width = 12, height = 6)
# June with manual
Plot_Times<-as.POSIXct(TW_PZ_08_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_Jun319, aes(Plot_Times, TW_PZ_08_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.8,-.4)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))   + geom_point(aes(x=Plot_Times, y=TW_PZ_08_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_PZ_08_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6)                 

# Plot full dataset
Plot_Times<-as.POSIXct(TW_PZ_08_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_FULL, aes(Plot_Times, TW_PZ_08_FULL[,"m_below_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(0.8,-.4), breaks=(seq(-.4,0.8,.2))) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                      
ggsave("TW_PZ_08_FULL.pdf", width = 12, height = 6)
# Complete with manual
Plot_Times<-as.POSIXct(TW_PZ_08_FULL[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_FULL, aes(Plot_Times, TW_PZ_08_FULL[,"m_below_GS"]))+geom_line(color='royalblue3', size=.3) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08")+  scale_x_datetime(breaks = seq(as.POSIXct("2018-05-01 00:00:00 EDT"), as.POSIXct("2019-09-01 00:00:00 EDT"), "1 month"),date_labels="%b %d, %Y")+ scale_y_reverse(limits =c(0.8,-.4), breaks=(seq(-.4,0.8,.2))) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))   + geom_point(aes(x=Plot_Times, y=TW_PZ_08_FULL[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_PZ_08_FULL_manual.pdf", width = 12, height = 6)                 

################ TW_PZ_08_SAND ################
Plot_Times<-as.POSIXct(TW_PZ_08_SAND_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_SAND_Jun319, aes(Plot_Times, TW_PZ_08_SAND_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.7,-0.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                                                                                      
ggsave("TW_PZ_08_SAND_11-19-18_to_6-3-19.pdf", width = 12, height = 6) 

Plot_Times<-as.POSIXct(TW_PZ_08_SAND_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_PZ_08_SAND_Jun319, aes(Plot_Times, TW_PZ_08_SAND_Jun319[,"m_below_GS"]))+geom_line(color='royalblue3', size=.6) + xlab("Date") + ylab("Depth to Water Below Ground Surface (m)")+ggtitle("TW_PZ_08_SAND")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+ scale_y_reverse(limits =c(0.7,-0.2)) +theme(axis.text.x = element_text(angle=45, vjust = 0.5))   + geom_point(aes(x=Plot_Times, y=TW_PZ_08_SAND_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_PZ_08_SAND_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6)                 

################ TW_PZ_09 ################
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
                 
################ TW_SW_10 ################
# November 2018
Plot_Times<-as.POSIXct(TW_SW_10_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_10_Nov2018, aes(Plot_Times, TW_SW_10_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_10")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_10_8-16-18_to_11-19-18.pdf", width = 12, height = 6)     
# November 2018 with manual 
Plot_Times<-as.POSIXct(TW_SW_10_Nov2018[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_10_Nov2018, aes(Plot_Times, TW_SW_10_Nov2018[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_10")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_10_Nov2018[,"m_manual"]), color="orange3", size=3)                                                                                                                                                                       
ggsave("TW_SW_10_8-16-18_to_11-19-18_manual.pdf", width = 12, height = 6)     
# June 2019
Plot_Times<-as.POSIXct(TW_SW_10_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_10_Jun319, aes(Plot_Times, TW_SW_10_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_10")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5))                                               
ggsave("TW_SW_10_11-19-18_to_6-3-19.pdf", width = 12, height = 6)       
# June 2019 with manual
Plot_Times<-as.POSIXct(TW_SW_10_Jun319[,"Date_Time"], "%m/%d/%y %I:%M:%S %p", tz="America/New_York")
ggplot(TW_SW_10_Jun319, aes(Plot_Times, TW_SW_10_Jun319[,"m_above_GS"]))+geom_line(color='royalblue3', size=.6)+ ylim(0,.6) + xlab("Date") + ylab("Stream Stage (m)")+ggtitle("TW_SW_10")+  scale_x_datetime(breaks = seq(Plot_Times[1], Plot_Times[length(Plot_Times)], "7 days"),date_labels="%b %d")+theme(axis.text.x = element_text(angle=45, vjust = 0.5)) + geom_point(aes(x=Plot_Times, y=TW_SW_10_Jun319[,"m_manual"]), color="orange3", size=3)                                                                                                                         
ggsave("TW_SW_10_11-19-18_to_6-3-19_manual.pdf", width = 12, height = 6) 



##################################################### GET SPATIAL DATA ######################################

# Load LiDAR elevation / terrain data from MassGIS:
# Bare-earth Digital Surface Model (DSM) rasters (aka DEMs): 
# https://docs.digital.mass.gov/dataset/massgis-data-lidar-terrain-data#download
TW_LiDAR <- raster("C:/Users/erikai94/Documents/UMass/Tidmarsh/LiDAR/19_03694641.tif")
# Tighten the border around the bog
TW_border <- extent(369000, 369600, 4641200, 4642000)
TW_LiDAR<-crop(TW_LiDAR, TW_border)
# Reproject the raster into lat long (from UTM) 
#projected_TW_LiDAR <- projectRaster(TW_LiDAR, crs = "+proj=longlat +ellps=GRS80 +towgs84=0,0,0,0,0,0,0  +no_defs")

# Load the lat long data for the piezometers
TW_PZ_longlat<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/LiDAR/PZ_longlat.csv", row.names=1)
# Convert into a spatial points
sp_TW_PZ_longlat<- SpatialPoints(TW_PZ_longlat, proj4string = CRS("+proj=longlat +datum=WGS84"))
# Convert the lat long points into UTM points
tp_TW <- spTransform(sp_TW_PZ_longlat, crs(TW_LiDAR))             

# Optional script to plot the elevation raster showing locations of piezometers 
plot(TW_LiDAR, col = terrain.colors( length(seq(7, 10, by = .1))-1), breaks= seq(7, 10, by = .1), zlim=c(7,10))
plot(tp_TW, add=TRUE)
          
# Extract elevations at each lat long piezometer point
TW_PZ_Elev<-extract(TW_LiDAR, tp_TW)   
# Bind the elevations to the long lat data 
TW_PZ_Positions<-cbind(TW_PZ_longlat, TW_PZ_Elev)
# Rename columns        
colnames(TW_PZ_Positions)<-c("long", "lat", "elev_m")   
# Bind the elevations to the UTM data 
TW_PZ_Positions_UTM<-cbind(as.data.frame(tp_TW), TW_PZ_Elev)
# Rename columns        
colnames(TW_PZ_Positions_UTM)<-c("easting", "northing", "elev_m")                  
               

##################################################### CALCUATE DH/DX ######################################

# Calculate the horizontal groundwater gradient in the "sand aquifer" using manual measurement data

############ CALCUATE DL ############
# First, calculate the horizontal distances between each piezometer screened in sand:
# note that lonlat must = TRUE to calculate distance between points on WGS ellipsoid instead of distance between points on a plane 
# Calculate the distance (in meters) between TW_PZ_01_SAND and TW_PZ_05_SAND
Dist_01_to_05_SAND <- pointDistance(TW_PZ_longlat["TW_PZ_01_SAND",], TW_PZ_longlat["TW_PZ_05_SAND",], lonlat=TRUE)
# Between TW_PZ_01_SAND and TW_PZ_06_SAND
Dist_01_to_06_SAND <- pointDistance(TW_PZ_longlat["TW_PZ_01_SAND",], TW_PZ_longlat["TW_PZ_06_SAND",], lonlat=TRUE)
# Between TW_PZ_01_SAND and TW_PZ_08_SAND
Dist_01_to_08_SAND <- pointDistance(TW_PZ_longlat["TW_PZ_01_SAND",], TW_PZ_longlat["TW_PZ_08_SAND",], lonlat=TRUE)
# Between TW_PZ_05_SAND and TW_PZ_06_SAND
Dist_05_to_06_SAND <- pointDistance(TW_PZ_longlat["TW_PZ_05_SAND",], TW_PZ_longlat["TW_PZ_06_SAND",], lonlat=TRUE)
# Between TW_PZ_05_SAND and TW_PZ_08_SAND
Dist_05_to_08_SAND <- pointDistance(TW_PZ_longlat["TW_PZ_05_SAND",], TW_PZ_longlat["TW_PZ_08_SAND",], lonlat=TRUE)
# Between TW_PZ_06_SAND and TW_PZ_08_SAND
Dist_06_to_08_SAND <- pointDistance(TW_PZ_longlat["TW_PZ_06_SAND",], TW_PZ_longlat["TW_PZ_08_SAND",], lonlat=TRUE)

############ CALCULATE DH ############ 

# First, calculate the head elevation in each piezometer
# (based on manual water level measurements and LiDAR elevation data)
# Subtract the water level below ground surface from the elevation at each piezometer to get the head elevations

### PZ_01_SAND head elevation ### 
# Head elevation in TW_PZ_01_SAND on 03/03/18 (see manual data spreadsheet): 
PZ_01_SAND_h_elev<-c(TW_PZ_Positions["TW_PZ_01_SAND","elev_m"]-(5.8/100), 
# on 05/06/18
TW_PZ_Positions["TW_PZ_01_SAND","elev_m"]-(13.3/100),
# on 06/18/18
TW_PZ_Positions["TW_PZ_01_SAND","elev_m"]-(18.5/100),  
# on 06/19/18             
TW_PZ_Positions["TW_PZ_01_SAND","elev_m"]-(19.5/100),  
# on 07/11/18
TW_PZ_Positions["TW_PZ_01_SAND","elev_m"]-(20.1/100),
# on 11/19/18 - the manual measurement was taken on 11/20 at this pz, so it won't be used 
NA,
# on 03/30/19
TW_PZ_Positions["TW_PZ_01_SAND","elev_m"]-(7/100),
# on 06/03/19
TW_PZ_Positions["TW_PZ_01_SAND","elev_m"]-(10.2/100))

### PZ_05_SAND head elevation ### 
# Head elevation in TW_PZ_05_SAND on 03/03/18 (see manual data spreadsheet): 
PZ_05_SAND_h_elev<-c(TW_PZ_Positions["TW_PZ_05_SAND","elev_m"]-(7.2/100), 
# on 05/06/18
TW_PZ_Positions["TW_PZ_05_SAND","elev_m"]-(9.8/100),
# on 06/18/18
TW_PZ_Positions["TW_PZ_05_SAND","elev_m"]-(20.4/100),  
# on 06/19/18             
TW_PZ_Positions["TW_PZ_05_SAND","elev_m"]-(22.4/100),  
# on 07/11/18
TW_PZ_Positions["TW_PZ_05_SAND","elev_m"]-(39.8/100),
# on 11/19/18
TW_PZ_Positions["TW_PZ_05_SAND","elev_m"]-(12.7/100),
# on 03/30/19
TW_PZ_Positions["TW_PZ_05_SAND","elev_m"]-(9.5/100),
# on 06/03/19
TW_PZ_Positions["TW_PZ_05_SAND","elev_m"]-(14.4/100))

### PZ_06_SAND head elevation ### 
# Head elevation in PZ_06_SAND on 03/03/18 (see manual data spreadsheet): 
PZ_06_SAND_h_elev<-c(TW_PZ_Positions["TW_PZ_06_SAND","elev_m"]-(18/100), 
# on 05/06/18
TW_PZ_Positions["TW_PZ_06_SAND","elev_m"]-(10.7/100),
# on 06/18/18
TW_PZ_Positions["TW_PZ_06_SAND","elev_m"]-(10.2/100),  
# on 06/19/18             
TW_PZ_Positions["TW_PZ_06_SAND","elev_m"]-(13.8/100),  
# on 07/11/18
TW_PZ_Positions["TW_PZ_06_SAND","elev_m"]-(20.7/100),
# on 11/19/18
TW_PZ_Positions["TW_PZ_06_SAND","elev_m"]-(19.9/100),
# on 03/30/19
TW_PZ_Positions["TW_PZ_06_SAND","elev_m"]-(8.3/100),
# on 06/03/19
TW_PZ_Positions["TW_PZ_06_SAND","elev_m"]-(16.5/100))

### PZ_08_SAND head elevation ### 
# Head elevation in PZ_06_SAND on 03/03/18 (see manual data spreadsheet): 
PZ_08_SAND_h_elev<-c(TW_PZ_Positions["TW_PZ_08_SAND","elev_m"]-(16.2/100), 
# on 05/06/18
TW_PZ_Positions["TW_PZ_08_SAND","elev_m"]-(16.9/100),
# on 06/18/18
TW_PZ_Positions["TW_PZ_08_SAND","elev_m"]-(17/100),  
# on 06/19/18             
TW_PZ_Positions["TW_PZ_08_SAND","elev_m"]-(30.8/100),  
# on 07/11/18
TW_PZ_Positions["TW_PZ_08_SAND","elev_m"]-(23.1/100),
# on 11/19/18
TW_PZ_Positions["TW_PZ_08_SAND","elev_m"]-(1.8/100),
# on 03/30/19
NA,
# on 06/03/19
TW_PZ_Positions["TW_PZ_08_SAND","elev_m"]-(18/100))

# Paste manual measurement dates together into a vector
dates<-c("03/03/18","05/06/18","06/18/18","06/19/18","07/11/18","11/19/18","03/30/19","06/03/19")

# Bind all the manual head level data together from PZ_01_SAND, PZ_05_SAND, PZ_06_SAND, and PZ_08_SAND
PZ_SAND_h_elev<-cbind(PZ_01_SAND_h_elev,PZ_05_SAND_h_elev,PZ_06_SAND_h_elev,PZ_08_SAND_h_elev)                      
# Assign manual measurement dates as row names to the head elevation matrix
rownames(PZ_SAND_h_elev)<-dates   
# Assign column names to match piezometers
colnames(PZ_SAND_h_elev)<- c("TW_PZ_01_SAND", "TW_PZ_05_SAND", "TW_PZ_06_SAND", "TW_PZ_08_SAND")


# Calculate the horizontal groundwater gradient in the confined "peat aquifer" using manual measurement data
### PZ_01 head elevation ### 
# Head elevation in TW_PZ_01 on 03/03/18 (see manual data spreadsheet): 
PZ_01_h_elev<-c(TW_PZ_Positions["TW_PZ_01","elev_m"]-(18.2/100), 
# on 03/19/18
TW_PZ_Positions["TW_PZ_01","elev_m"]-(18.4/100),
# on 05/06/18
NA,
# on 06/18/18
TW_PZ_Positions["TW_PZ_01","elev_m"]-(14.5/100),  
# on 06/19/18             
TW_PZ_Positions["TW_PZ_01","elev_m"]-(15.8/100),  
# on 07/11/18
TW_PZ_Positions["TW_PZ_01","elev_m"]-(6/100),
# on 11/19/18 - the manual measurement was taken on 11/20 at this pz, so it won't be used 
NA,
# on 03/30/19
TW_PZ_Positions["TW_PZ_01","elev_m"]-(15.5/100),
# on 06/03/19
TW_PZ_Positions["TW_PZ_01","elev_m"]-(10.6/100))

### PZ_05 head elevation ### 
# Head elevation in TW_PZ_05 on 03/03/18 (see manual data spreadsheet): 
PZ_05_h_elev<-c(TW_PZ_Positions["TW_PZ_05","elev_m"]-(17.8/100), 
# on 03/19/18
NA,
# on 05/06/18
TW_PZ_Positions["TW_PZ_05","elev_m"]-(13.5/100),  
# on 06/18/18
TW_PZ_Positions["TW_PZ_05","elev_m"]-(16.8/100),  
# on 06/19/18             
TW_PZ_Positions["TW_PZ_05","elev_m"]-(23.3/100),  
# on 07/11/18
TW_PZ_Positions["TW_PZ_05","elev_m"]-(29.8/100),
# on 11/19/18 - the manual measurement was taken on 11/20 at this pz, so it won't be used 
TW_PZ_Positions["TW_PZ_05","elev_m"]-(11.4/100),
# on 03/30/19
TW_PZ_Positions["TW_PZ_05","elev_m"]-(8.3/100),
# on 06/03/19
TW_PZ_Positions["TW_PZ_05","elev_m"]-(12.9/100))

### PZ_06 head elevation ### 
# Head elevation in TW_PZ_06 on 03/03/18 (see manual data spreadsheet): 
PZ_06_h_elev<-c(TW_PZ_Positions["TW_PZ_06","elev_m"]-(9.9/100), 
# on 03/19/18
TW_PZ_Positions["TW_PZ_06","elev_m"]-(6.6/100),
# on 05/06/18
TW_PZ_Positions["TW_PZ_06","elev_m"]-(9.1/100),  
# on 06/18/18
TW_PZ_Positions["TW_PZ_06","elev_m"]-(28.3/100),  
# on 06/19/18             
TW_PZ_Positions["TW_PZ_06","elev_m"]-(29.7/100),  
# on 07/11/18
TW_PZ_Positions["TW_PZ_06","elev_m"]-(36/100),
# on 11/19/18  
TW_PZ_Positions["TW_PZ_06","elev_m"]-(6.3/100),
# on 03/30/19
TW_PZ_Positions["TW_PZ_06","elev_m"]-(15.2/100),
# on 06/03/19
TW_PZ_Positions["TW_PZ_06","elev_m"]-(14.5/100))

### PZ_08 head elevation ### 
# Head elevation in TW_PZ_08 on 03/03/18 (see manual data spreadsheet): 
PZ_08_h_elev<-c(TW_PZ_Positions["TW_PZ_08","elev_m"]-(19.7/100), 
# on 03/19/18
NA,
# on 05/06/18
TW_PZ_Positions["TW_PZ_08","elev_m"]-(16.3/100),  
# on 06/18/18
TW_PZ_Positions["TW_PZ_08","elev_m"]-(14.7/100),  
# on 06/19/18             
TW_PZ_Positions["TW_PZ_08","elev_m"]-(14.9/100),  
# on 07/11/18
TW_PZ_Positions["TW_PZ_08","elev_m"]-(10.6/100),
# on 11/19/18  
TW_PZ_Positions["TW_PZ_08","elev_m"]-(11.4/100),
# on 03/30/19
NA,
# on 06/03/19
TW_PZ_Positions["TW_PZ_08","elev_m"]-(21.3/100))

### PZ_09 head elevation ### 
# Head elevation in TW_PZ_08 on 03/03/18 (see manual data spreadsheet): 
PZ_09_h_elev<-c(NA, 
# on 03/19/18
TW_PZ_Positions["TW_PZ_09","elev_m"]-(19.8/100),
# on 05/06/18
TW_PZ_Positions["TW_PZ_09","elev_m"]-(36.8/100),  
# on 06/18/18
TW_PZ_Positions["TW_PZ_09","elev_m"]-(20.1/100),  
# on 06/19/18             
NA,  
# on 07/11/18 - not using this measurement because logger had to be removed for manual measurement
NA,
# on 11/19/18  
TW_PZ_Positions["TW_PZ_09","elev_m"]-(40.3/100),
# on 03/30/19
TW_PZ_Positions["TW_PZ_09","elev_m"]-(39/100),
# on 06/03/19
TW_PZ_Positions["TW_PZ_09","elev_m"]-(13.3/100))

# Paste manual measurement dates together into a vector
dates<-c("03/03/18","03/19/18","05/06/18","06/18/18","06/19/18","07/11/18","11/19/18","03/30/19","06/03/19")

# Bind all the manual head level data together from PZ_01_SAND, PZ_05_SAND, PZ_06_SAND, and PZ_08_SAND
PZ_h_elev<-cbind(PZ_01_h_elev,PZ_05_h_elev,PZ_06_h_elev,PZ_08_h_elev, PZ_09_h_elev)                      
# Assign manual measurement dates as row names to the head elevation matrix
rownames(PZ_h_elev)<-dates   
# Assign column names to match piezometers
colnames(PZ_h_elev)<- c("TW_PZ_01", "TW_PZ_05", "TW_PZ_06", "TW_PZ_08", "TW_PZ_09")


################################################# THREE POINT FUNCTIONS #################################################

# First extract coordinate data (easting, northing, elevation) for the three piezometers that will be used in the three point problem
findCoords_3P<-function(ElevationData, Piezometers) { 
        # A_x,y are the coordinates of the piezometer point of minimum head value; A_h is the minimum head value       
        A_x<-TW_PZ_Positions_UTM[names(which.min(ElevationData[Piezometers])),1]
        A_y<-TW_PZ_Positions_UTM[names(which.min(ElevationData[Piezometers])),2]
        A_h<-min(ElevationData[Piezometers]) 
        # B_x,y are the coordinates of the piezometer point of median head value; B_h is the median head value
        B_x<-TW_PZ_Positions_UTM[names(which(ElevationData[Piezometers]==median(ElevationData[Piezometers]))),1]
        B_y<-TW_PZ_Positions_UTM[names(which(ElevationData[Piezometers]==median(ElevationData[Piezometers]))),2]
        B_h<-PZ_SAND_h_elev[1,which(ElevationData[Piezometers]==median(ElevationData[Piezometers]))]
        # C_x,y are the coordinates of the piezometer point of maximum head value; B_h is the maximum head value
        C_x<-TW_PZ_Positions_UTM[names(which.max(ElevationData[Piezometers])),1]
        C_y<-TW_PZ_Positions_UTM[names(which.max(ElevationData[Piezometers])),2]
        C_h<-max(ElevationData[Piezometers]) 
        Coords<-rbind(A_x, A_y, A_h, B_x, B_y, B_h, C_x, C_y, C_h)
        return(Coords)
        }     

 # Next, calculate the magnitude of the gradient using the coordinate data 

### Write a function to calculate dh/dl (three point problem)
calcGrad_3P<-function(Coordinates) {  
        # Create emtpy vectors for for loops
        dh_dl<-vector(length=nrow(Coordinates))
        grad_dir<-vector(length=nrow(Coordinates)) 
        for (i in 1:nrow(Coordinates)){ 
                # A plane through these three points has the linear approximation: ∆h = (∂h/∂x)∆x + (∂h/∂y)∆y
                # The partial derivatives (∂h/∂x and ∂h/∂y) are CONSTANT in a plane
                # The partial derivatives between B and A are defined as: hB−hA = ∂h/∂x(xB−xA) + ∂h/∂y(yB−yA)
                # The partial derivatives between C and A are defined as: hC−hA = ∂h/∂x(xC−xA) + ∂h/∂y(yC−yA)
                # Create a matrix for ∂h/∂x and ∂h/∂y to solve for system of equations:                 
                Matrix_A<-rbind(c(Coordinates[i,"B_x"]-Coordinates[i,"A_x"], Coordinates[i,"B_y"]-Coordinates[i,"A_y"]),               
                c(Coordinates[i,"C_x"]-Coordinates[i,"A_x"], Coordinates[i,"C_y"]-Coordinates[i,"A_y"]))
                # Create a matrix for the head differences between B and A and between C and A                        
                Matrix_B<-rbind(Coordinates[i,"B_h"]-Coordinates[i,"A_h"], Coordinates[i,"C_h"]-Coordinates[i,"A_h"])  
                print(Matrix_B)
                # AX = B so the solution is X = (Ainv)B:                       
                Matrix_X<-solve(Matrix_A,Matrix_B)                       
                # Calculate the magnitude of the gradient dh/dl
                dh_dl[i]<-sqrt((Matrix_X[1,])^2+(Matrix_X[2,])^2)
                }                
        # Calculate the direction of dh/dl  
        for (i in 1:nrow(Coordinates)){      
                # Calculate the components of the pole to the plane containing all three points
                #  Ui =  (y1-y2)*(z3-z2)-(y3-y2)*(z1-z2)i
                Ui<-(Coordinates[i,"A_y"]-Coordinates[i,"B_y"])*(Coordinates[i,"C_h"]-Coordinates[i,"B_h"])-(Coordinates[i,"C_y"]-Coordinates[i,"B_y"])*(Coordinates[i,"A_h"]-Coordinates[i,"B_h"])                      
                # -Uj = -(x1-x2)*(z3-z2)-(x3-x2)*(z1-z2)j
                neg_Uj<--((Coordinates[i,"A_x"]-Coordinates[i,"B_x"])*(Coordinates[i,"C_h"]-Coordinates[i,"B_h"])-(Coordinates[i,"C_x"]-Coordinates[i,"B_x"])*(Coordinates[i,"A_h"]-Coordinates[i,"B_h"]))                                             
                # Uk =  (x1-x2)*(y3-y2)-(x3-x2)*(y1-y2)k
                Uk<-(Coordinates[i,"A_x"]-Coordinates[i,"B_x"])*(Coordinates[i,"C_y"]-Coordinates[i,"B_y"])-(Coordinates[i,"C_x"]-Coordinates[i,"B_x"])*(Coordinates[i,"A_y"]-Coordinates[i,"B_y"])                      
                # Calculate direction of gradient: angle = arccos(N/(sqrt(E^2+N^2)))
                if(Uk>0){
                grad_dir[i]<-acos(Ui/(sqrt(neg_Uj^2+Ui^2)))*(180/pi)+90
                } else if (Uk<0 ) {   
                grad_dir[i]<-acos(-Ui/(sqrt(neg_Uj^2+Ui^2)))*(180/pi)+90
                }
                }
                return(cbind(dh_dl,grad_dir))
         }

######################################################################################################################3


############ SAND ############
# First, calculate the gradient in the sand between piezometers 1, 5 and 6: 
# Run the function to define piezometer coordinates
test156<-apply(PZ_SAND_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=1:3)) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test156<-test156[-which(sapply(test156, length)<9)]
# Convert the list into a matrix
Coords156<-t(do.call(cbind,test156)) 
# Assign column names based on dates of manual measurements
rownames(Coords156)<-names(test156)      
# Run the function to calculate the gradient magnitude and direction
Gradient156<-calcGrad_3P(Coordinates=Coords156)
# Rename row names based on manual measurement dates
rownames(Gradient156)<-rownames(Coords156)

# Second, calculate the gradient in the sand between piezometers 1, 6 and 8: 
# Run the function to define piezometer coordinates
test168<-apply(PZ_SAND_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=c(1,3,4))) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test168<-test168[-which(sapply(test168, length)<9)]
# Convert the list into a matrix
Coords168<-t(do.call(cbind,test168)) 
# Assign column names based on dates of manual measurements
rownames(Coords168)<-names(test168)      
# Run the function to calculate the gradient magnitude and direction
Gradient168<-calcGrad_3P(Coordinates=Coords168)
# Rename row names based on manual measurement dates
rownames(Gradient168)<-rownames(Coords168)

# Third, calculate the gradient in the sand between piezometers 1, 5 and 8: 
# Run the function to define piezometer coordinates
test158<-apply(PZ_SAND_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=c(1,2,4))) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test158<-test158[-which(sapply(test158, length)<9)]
# Convert the list into a matrix
Coords158<-t(do.call(cbind,test158)) 
# Assign column names based on dates of manual measurements
rownames(Coords158)<-names(test158)      
# Run the function to calculate the gradient magnitude and direction
Gradient158<-calcGrad_3P(Coordinates=Coords158)
# Rename row names based on manual measurement dates
rownames(Gradient158)<-rownames(Coords158)

# Fourth, calculate the gradient in the sand between piezometers 5, 6 and 8: 
# Run the function to define piezometer coordinates
test568<-apply(PZ_SAND_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=c(2:4))) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test568<-test568[-which(sapply(test568, length)<9)]
# Convert the list into a matrix
Coords568<-t(do.call(cbind,test568)) 
# Assign column names based on dates of manual measurements
rownames(Coords568)<-names(test568)      
# Run the function to calculate the gradient magnitude and direction
Gradient568<-calcGrad_3P(Coordinates=Coords568)
# Rename row names based on manual measurement dates
rownames(Gradient568)<-rownames(Coords568)

# Bind all gradient data into the manual measurements matrix for the sand piezometers
PZ_SAND_Grad<-cbind(PZ_SAND_h_elev, Gradient156[match(rownames(PZ_SAND_h_elev), rownames(Gradient156)),])
PZ_SAND_Grad<-cbind(PZ_SAND_Grad, Gradient168[match(rownames(PZ_SAND_Grad), rownames(Gradient168)),])
PZ_SAND_Grad<-cbind(PZ_SAND_Grad, Gradient158[match(rownames(PZ_SAND_Grad), rownames(Gradient158)),])
PZ_SAND_Grad<-cbind(PZ_SAND_Grad, Gradient568[match(rownames(PZ_SAND_Grad), rownames(Gradient568)),])
colnames(PZ_SAND_Grad)<- c("TW_PZ_01_SAND","TW_PZ_05_SAND","TW_PZ_06_SAND","TW_PZ_08_SAND","dh_dl_156","grad_dir_156","dh_dl_168","grad_dir_168","dh_dl_158","grad_dir_158","dh_dl_568","grad_dir_568") 

write.csv(PZ_SAND_Grad, "PZ_SAND_Grad.csv")
          
############  PEAT ############    

# First, calculate the gradient in the sand between piezometers 1, 5 and 6: 
# Run the function to define piezometer coordinates
test156<-apply(PZ_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=1:3)) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test156<-test156[-which(sapply(test156, length)<9)]
# Convert the list into a matrix
Coords156<-t(do.call(cbind,test156)) 
# Assign column names based on dates of manual measurements
rownames(Coords156)<-names(test156)      
# Run the function to calculate the gradient magnitude and direction
Gradient156<-calcGrad_3P(Coordinates=Coords156)
# Rename row names based on manual measurement dates
rownames(Gradient156)<-rownames(Coords156)  

# Second, calculate the gradient in the sand between piezometers 1, 6 and 8: 
# Run the function to define piezometer coordinates
test168<-apply(PZ_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=c(1,3,4))) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test168<-test168[-which(sapply(test168, length)<9)]
# Convert the list into a matrix
Coords168<-t(do.call(cbind,test168)) 
# Assign column names based on dates of manual measurements
rownames(Coords168)<-names(test168)      
# Run the function to calculate the gradient magnitude and direction
Gradient168<-calcGrad_3P(Coordinates=Coords168)
# Rename row names based on manual measurement dates
rownames(Gradient168)<-rownames(Coords168)

# Third, calculate the gradient in the sand between piezometers 1, 5 and 8: 
# Run the function to define piezometer coordinates
test158<-apply(PZ_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=c(1,2,4))) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test158<-test158[-which(sapply(test158, length)<9)]
# Convert the list into a matrix
Coords158<-t(do.call(cbind,test158)) 
# Assign column names based on dates of manual measurements
rownames(Coords158)<-names(test158)      
# Run the function to calculate the gradient magnitude and direction
Gradient158<-calcGrad_3P(Coordinates=Coords158)
# Rename row names based on manual measurement dates
rownames(Gradient158)<-rownames(Coords158)

# Fourth, calculate the gradient in the sand between piezometers 1, 5 and 9: 
# Run the function to define piezometer coordinates
test159<-apply(PZ_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=c(1,2,5))) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test159<-test159[-which(sapply(test159, length)<9)]
# Convert the list into a matrix
Coords159<-t(do.call(cbind,test159)) 
# Assign column names based on dates of manual measurements
rownames(Coords159)<-names(test159)      
# Run the function to calculate the gradient magnitude and direction
Gradient159<-calcGrad_3P(Coordinates=Coords159)
# Rename row names based on manual measurement dates
rownames(Gradient159)<-rownames(Coords159)

# Fifth, calculate the gradient in the sand between piezometers 5, 6 and 8: 
# Run the function to define piezometer coordinates
test568<-apply(PZ_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=c(2:4))) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test568<-test568[-which(sapply(test568, length)<9)]
# Convert the list into a matrix
Coords568<-t(do.call(cbind,test568)) 
# Assign column names based on dates of manual measurements
rownames(Coords568)<-names(test568)      
# Run the function to calculate the gradient magnitude and direction
Gradient568<-calcGrad_3P(Coordinates=Coords568)
# Rename row names based on manual measurement dates
rownames(Gradient568)<-rownames(Coords568)

# Sixth, calculate the gradient in the sand between piezometers 5, 6 and 9: 
# Run the function to define piezometer coordinates
test569<-apply(PZ_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=c(2,3,5))) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test569<-test569[-which(sapply(test569, length)<9)]
# Convert the list into a matrix
Coords569<-t(do.call(cbind,test569)) 
# Assign column names based on dates of manual measurements
rownames(Coords569)<-names(test569)      
# Run the function to calculate the gradient magnitude and direction
Gradient569<-calcGrad_3P(Coordinates=Coords569)
# Rename row names based on manual measurement dates
rownames(Gradient569)<-rownames(Coords569)

# Seventh, calculate the gradient in the sand between piezometers 5, 8 and 9: 
# Run the function to define piezometer coordinates
test589<-apply(PZ_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=c(2,4,5))) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test589<-test589[-which(sapply(test589, length)<9)]
# Convert the list into a matrix
Coords589<-t(do.call(cbind,test589)) 
# Assign column names based on dates of manual measurements
rownames(Coords589)<-names(test589)      
# Run the function to calculate the gradient magnitude and direction
Gradient589<-calcGrad_3P(Coordinates=Coords589)
# Rename row names based on manual measurement dates
rownames(Gradient589)<-rownames(Coords589)

# Eighth, calculate the gradient in the sand between piezometers 1, 8 and 9: 
# Run the function to define piezometer coordinates
test189<-apply(PZ_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=c(1,4,5))) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test189<-test189[-which(sapply(test189, length)<9)]
# Convert the list into a matrix
Coords189<-t(do.call(cbind,test189)) 
# Assign column names based on dates of manual measurements
rownames(Coords189)<-names(test189)      
# Run the function to calculate the gradient magnitude and direction
Gradient189<-calcGrad_3P(Coordinates=Coords189)
# Rename row names based on manual measurement dates
rownames(Gradient189)<-rownames(Coords189)

# Ninth, calculate the gradient in the sand between piezometers 6, 8 and 9: 
# Run the function to define piezometer coordinates
test689<-apply(PZ_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=c(3,4,5))) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test689<-test689[-which(sapply(test689, length)<9)]
# Convert the list into a matrix
Coords689<-t(do.call(cbind,test689)) 
# Assign column names based on dates of manual measurements
rownames(Coords689)<-names(test689)      
# Run the function to calculate the gradient magnitude and direction
Gradient689<-calcGrad_3P(Coordinates=Coords689)
# Rename row names based on manual measurement dates
rownames(Gradient689)<-rownames(Coords689)

# Tenth, calculate the gradient in the sand between piezometers 1, 6 and 9: 
# Run the function to define piezometer coordinates
test169<-apply(PZ_h_elev,1, function(x) findCoords_3P(ElevationData=x, Piezometers=c(1,3,5))) 
# Remove the list elements who do not have data for all three piezometers for the three point problem
test169<-test169[-which(sapply(test169, length)<9)]
# Convert the list into a matrix
Coords169<-t(do.call(cbind,test169)) 
# Assign column names based on dates of manual measurements
rownames(Coords169)<-names(test169)      
# Run the function to calculate the gradient magnitude and direction
Gradient169<-calcGrad_3P(Coordinates=Coords169)
# Rename row names based on manual measurement dates
rownames(Gradient169)<-rownames(Coords169)


# Bind all gradient data into the manual measurements matrix for the sand piezometers
PZ_Grad<-cbind(PZ_h_elev, Gradient156[match(rownames(PZ_h_elev), rownames(Gradient156)),])
PZ_Grad<-cbind(PZ_Grad, Gradient158[match(rownames(PZ_Grad), rownames(Gradient158)),])
PZ_Grad<-cbind(PZ_Grad, Gradient159[match(rownames(PZ_Grad), rownames(Gradient159)),])
PZ_Grad<-cbind(PZ_Grad, Gradient168[match(rownames(PZ_Grad), rownames(Gradient168)),])
PZ_Grad<-cbind(PZ_Grad, Gradient169[match(rownames(PZ_Grad), rownames(Gradient169)),])
PZ_Grad<-cbind(PZ_Grad, Gradient189[match(rownames(PZ_Grad), rownames(Gradient189)),])
PZ_Grad<-cbind(PZ_Grad, Gradient568[match(rownames(PZ_Grad), rownames(Gradient568)),])
PZ_Grad<-cbind(PZ_Grad, Gradient569[match(rownames(PZ_Grad), rownames(Gradient569)),])
PZ_Grad<-cbind(PZ_Grad, Gradient589[match(rownames(PZ_Grad), rownames(Gradient589)),])
PZ_Grad<-cbind(PZ_Grad, Gradient689[match(rownames(PZ_Grad), rownames(Gradient689)),])

colnames(PZ_Grad)<- c("TW_PZ_01","TW_PZ_05","TW_PZ_06","TW_PZ_08","TW_PZ_09", "dh_dl_156","grad_dir_156", "dh_dl_158","grad_dir_158",
"dh_dl_159","grad_dir_159","dh_dl_168","grad_dir_168", "dh_dl_169","grad_dir_169", "dh_dl_189","grad_dir_189", "dh_dl_568","grad_dir_568", 
"dh_dl_569", "grad_dir_569", "dh_dl_589","grad_dir_589", "dh_dl_689","grad_dir_689") 

write.csv(PZ_Grad, "PZ_Grad.csv")
          




            
            
