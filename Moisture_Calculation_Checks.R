# Set the working directory
setwd("C:/Users/erikai94/Documents/UMass/Tidmarsh/Calculation_Checks")

######################################################### West (cm) ###################################################################
# Open csv for West (cm)
West_cm_Moisture<-read.csv("West_cm_Check.csv")

# Fix colnames
colnames(West_cm_Moisture)<-c("Meas_No", "Distance_(cm)", "X", "Permittivity_(mV)", "Permittivity_(V)", "Soil_Moisture_Mineral_(%)", "Soil_Moisture_Mineral_Calculated_(%)", "Latitude_(deg)", "Longitude_(deg)", "Misc1", "Misc2")

# Make sure the mV to V conversion is correct:
West_cm_Moisture[,"Permittivity_Check"]<-West_cm_Moisture[,"Permittivity_(mV)"]/1000

# Add approximated values in between data from probe measurements:
# Identify which rows have data
Measured<-which(!(is.na((West_cm_Moisture[,"Permittivity_Check"]))))
# Identify clusters of blanks
# Take difference of each measured element and element ahead
# Can identify the start of data gaps as places where the next measured point is more than one element away
# LastMeasured represent the last element before a patch of missing data
LastMeasured<-Measured[which(diff(Measured)>1)]
# FirstMeasured represent the first element after patch of missing data
# This is the element in Measured AFTER the elements where the next data point are more than one element away
FirstMeasured<-Measured[which(diff(Measured)>1)+1]

# Write a for loop that linearly interpolates values in these blank clusters 
# Note that there are 36 clusters of blanks ( length(FirstMeasured) = length(LastMeasured) = 36)
for (i in 1:36){
    West_cm_Moisture[LastMeasured[i]:FirstMeasured[i],"Permittivity_Check"]<-seq(West_cm_Moisture[LastMeasured[i],"Permittivity_Check"], West_cm_Moisture[FirstMeasured[i],"Permittivity_Check"],length=length(LastMeasured[i]:FirstMeasured[i]))
    }

# Round the original permittivity column AND the checked permittivity column to 5 decimal places
West_cm_Moisture[,"Permittivity_(V)"]<-round(West_cm_Moisture[,"Permittivity_(V)"], digits=5)
West_cm_Moisture[,"Permittivity_Check"]<-round(West_cm_Moisture[,"Permittivity_Check"], digits=5)

# Check to see if these columns are identical
identical(West_cm_Moisture[,"Permittivity_(V)"], West_cm_Moisture[,"Permittivity_Check"])
which(West_cm_Moisture[,"Permittivity_(V)"]-West_cm_Moisture[,"Permittivity_Check"]!=0)
# NOTE:
West_cm_Moisture[572:591,c("Permittivity_(V)", "Permittivity_Check")]

######################################################### West (m) ####################################################################
# Open csv for West (m) moisture data
West_m_Moisture<-read.csv("West_m_Check.csv")
# Fix colnames
colnames(West_m_Moisture)<-c("Meas_No", "Distance_(cm)", "Permittivity_(mV)", "Permittivity_(V)", "Soil_Moisture_Mineral_(%)", 
"Soil_Moisture_Mineral_Calculated_(%)", "Latitude_(deg)", "Longitude_(deg)", "Autocovariance_1m", "Autocovariance_2m", "Autocovariance_3m",
"Autocovariance_4m", "Autocovariance_5m", "Autocovariance_6m", "Autocovariance_7m", "Autocovariance_8m", "Autocovariance_9m",  "h=1",
"Autocorrelation_1","Autocorrelation_2","Autocorrelation_3","Autocorrelation_4","Autocorrelation_5","Autocorrelation_6",
"Autocorrelation_7", "Autocorrelation_8", "Misc1", "Misc2")

 # Check V calculation:
round(West_m_Moisture[,"Permittivity_(V)"], digits=4)-round(West_m_Moisture[,"Permittivity_(mV)"]/1000, digits=4)

# Mineral calculation check:
a0<-1.600
a1<-8.400
Mineral_Check<-sapply(West_m_Moisture[,"Permittivity_(V)"], function(x, y, z) ((1+6.175*x+6.303*x^2-73.578*x^3+183.44*x^4-184.78*x^5+68.017*x^6)-y)/z, a0, a1)
# CHECK:
round(Mineral_Check, digits=3)-West_m_Moisture[,"Soil_Moisture_Mineral_Calculated_(%)"]                                  
                      
# Write a function to get the autocovariance for lags 1-9
autoCov<-function(lag, MoistureData) {
    # Calculate average soil moisture
    SM_mean<-mean(MoistureData)
    # Record number of soil moisture measurements
    n<-length(MoistureData)
    # Make empty vector for autocovariance check
    AutoCov<-vector(length=length(MoistureData)-1)                    
    for (i in (lag+1):n){
    AutoCov[i]<-(MoistureData[i]-SM_mean)*(MoistureData[i-lag]-SM_mean)
    }
    # Final step is to sum all of the columns and multipy them by 1/n
    return(1/n*(sum(AutoCov)))
    } 
                                                             
AutoCov<-sapply(1:9, function(x,y) autoCov(x,y), West_m_Moisture[,"Soil_Moisture_Mineral_Calculated_(%)"])                         
 
# Autocovariance function in R gives the same answers ast the function above:                
acf(West_m_Moisture[,"Soil_Moisture_Mineral_Calculated_(%)"], lag.max = 9, type ="covariance", plot = FALSE)
                
#########################################################################################################################
               
# Load Raw Data
Raw<-read.csv("file:///C:/Users/erikai94/Documents/UMass/Tidmarsh/Raw.csv")                
# assign column names
colnames(Raw)<-c("Meas_No", "Distance_(cm)", "Raw_Permittivity_(mV)", "Probe_Soil_Moisture_(%)", "Comments")                
# Update the data frame so here are rows for every distance of 10 cm              
# First, make a sequence from 0 to the maximum distance in raw data, by increments of 10
 Distances<-seq(0, Raw[nrow(Raw),"Distance_(cm)"], 10)
 # Next, make new data frame with a row for every distance
MoistureData<-as.data.frame(matrix(nrow=length(Distances),ncol=ncol(Raw)))
colnames(MoistureData)<-colnames(Raw)                
MoistureData[,1]<-1:length(Distances)                
MoistureData[,2]<-Distances                
MoistureData[which(Distances%in%Raw[,"Distance_(cm)"]),3]<-Raw[,"Raw_Permittivity_(mV)"]
MoistureData[which(Distances%in%Raw[,"Distance_(cm)"]),4]<-Raw[,"Probe_Soil_Moisture_(%)"] 
MoistureData[which(Distances%in%Raw[,"Distance_(cm)"]),5]<-as.character(Raw[,"Comments"])                  
 
# Clean up data frame                
MoistureData[which(is.na(MoistureData[,"Comments"])),"Comments"]<-""
                
# Add a column of Permittivity in (V)
MoistureData[,"Permittivity_(V)"]<-MoistureData[,"Raw_Permittivity_(mV)"]/1000
                
# Add linearly interpolated values between probe measurement data for distance up to 8100 cm:
# Identify which rows have data
Measured<-which(!(is.na((MoistureData[1:which(MoistureData[,"Distance_(cm)"]==8100),"Permittivity_(V)"]))))
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
MoistureData[1:which(MoistureData[,"Distance_(cm)"]==8100),"Permittivitiy_interp_cm_(V)"]<-MoistureData[1:which(MoistureData[,"Distance_(cm)"]==8100), "Permittivity_(V)"]       
for (i in 1:36){
    MoistureData[LastMeasured[i]:FirstMeasured[i],"Permittivitiy_interp_cm_(V)"]<-seq(MoistureData[LastMeasured[i],"Permittivitiy_interp_cm_(V)"], MoistureData[FirstMeasured[i],"Permittivitiy_interp_cm_(V)"],length=length(LastMeasured[i]:FirstMeasured[i]))
    }
           
# Add a column for soil moisture calculated for the linearly interpolated permittivity column              
a0<-1.600
a1<-8.400
MoistureData[1:which(MoistureData[,"Distance_(cm)"]==8100),"cm_Soil_Moisture_Calculated_(%)"]<-sapply(MoistureData[1:which(MoistureData[,"Distance_(cm)"]==8100),"Permittivity_(V)"], function(x, y, z) ((1+6.175*x+6.303*x^2-73.578*x^3+183.44*x^4-184.78*x^5+68.017*x^6)-y)/z, a0, a1)
                                                         
 # Write a function to get the autocovariance for lags 0-9
autoCov<-function(lag, MoistureData) {
    # Calculate average soil moisture
    SM_mean<-mean(MoistureData)
    # Record number of soil moisture measurements
    n<-length(MoistureData)
    # Make empty vector for autocovariance check
    AutoCov<-vector(length=length(MoistureData)-1)                    
    for (i in (lag+1):n){
    AutoCov[i]<-(1/n*(MoistureData[i]-SM_mean)*(MoistureData[i-lag]-SM_mean))
    }
    return(AutoCov)
    }
                                                                                                      
# Run this function on the soil moisture calculated at the cm scale
# Create a vector of rows with data at the cm scale
cm_Rows<-which(!(is.na(MoistureData[,"cm_Soil_Moisture_Calculated_(%)"])))                                                                                                      
AutoCov<-sapply(0:9, function(x,y) autoCov(x,y), MoistureData[cm_Rows,"cm_Soil_Moisture_Calculated_(%)"])

MoistureData[cm_Rows,"AutoCov_cm_lag1"]<-AutoCov[,2]                
MoistureData[cm_Rows,"AutoCov_cm_lag2"]<-AutoCov[,3] 
MoistureData[cm_Rows,"AutoCov_cm_lag3"]<-AutoCov[,4] 
MoistureData[cm_Rows,"AutoCov_cm_lag4"]<-AutoCov[,5] 
MoistureData[cm_Rows,"AutoCov_cm_lag5"]<-AutoCov[,6] 
MoistureData[cm_Rows,"AutoCov_cm_lag6"]<-AutoCov[,7] 
MoistureData[cm_Rows,"AutoCov_cm_lag7"]<-AutoCov[,8] 
MoistureData[cm_Rows,"AutoCov_cm_lag8"]<-AutoCov[,9] 
MoistureData[cm_Rows,"AutoCov_cm_lag9"]<-AutoCov[,10] 
MoistureData[cm_Rows,"AutoCov_cm_lag0"]<-AutoCov[,1]                                
                
# check
# acf(MoistureData[which(!(is.na(MoistureData[,"cm_Soil_Moisture_Calculated_(%)"]))),"cm_Soil_Moisture_Calculated_(%)"], type="covariance", lag.max=9, plot=FALSE)                

# Calculate autocovariance 
acv0<-sum(MoistureData[cm_Rows,"AutoCov_cm_lag0"])                
acv1<-sum(MoistureData[cm_Rows,"AutoCov_cm_lag1"])
acv2<-sum(MoistureData[cm_Rows,"AutoCov_cm_lag2"])
acv3<-sum(MoistureData[cm_Rows,"AutoCov_cm_lag3"])
acv4<-sum(MoistureData[cm_Rows,"AutoCov_cm_lag4"])
acv5<-sum(MoistureData[cm_Rows,"AutoCov_cm_lag5"])
acv6<-sum(MoistureData[cm_Rows,"AutoCov_cm_lag6"])
acv7<-sum(MoistureData[cm_Rows,"AutoCov_cm_lag7"])
acv8<-sum(MoistureData[cm_Rows,"AutoCov_cm_lag8"])
acv9<-sum(MoistureData[cm_Rows,"AutoCov_cm_lag9"])
                
# Calculate autocorrelation coefficients 
MoistureData[2,"AutoCor_cm_lag1"]<-acv1/acv0  
MoistureData[3,"AutoCor_cm_lag2"]<-acv2/acv0
MoistureData[4,"AutoCor_cm_lag3"]<-acv3/acv0
MoistureData[5,"AutoCor_cm_lag4"]<-acv4/acv0                               
MoistureData[6,"AutoCor_cm_lag5"]<-acv5/acv0                               
MoistureData[7,"AutoCor_cm_lag6"]<-acv6/acv0                               
MoistureData[8,"AutoCor_cm_lag7"]<-acv7/acv0                               
MoistureData[9,"AutoCor_cm_lag8"]<-acv8/acv0                               
MoistureData[10,"AutoCor_cm_lag9"]<-acv9/acv0                               

# Get moisture data for every meter
# Create a vector for every meter (every 100 cm)
m_Distances<-seq(0, max(MoistureData[,"Distance_(cm)"]), 100) 
# Create a vector for the rows for every meter of data
m_Rows<-sapply(m_Distances, function(x) which(MoistureData[,"Distance_(cm)"]==x))
               
# Add linearly interpolated data where data is missing on the meter scale              
# Add approximated values in between data from probe measurements:
# Identify which rows have data
Measured<-which(!(is.na(MoistureData[m_Rows,"Permittivity_(V)"])))
# Identify clusters of blanks
# Take difference of each measured element and element ahead
# Can identify the start of data gaps as places where the next measured point is more than one element away
# LastMeasured represent the last element before a patch of missing data
LastMeasured<-Measured[which(diff(Measured)>1)]
# FirstMeasured represent the first element after patch of missing data
# This is the element in Measured AFTER the elements where the next data point are more than one element away
FirstMeasured<-Measured[which(diff(Measured)>1)+1]

# Creat a temporary vector of Permittivity values at the meter scale 
m_Permittivity<-MoistureData[m_Rows,"Permittivity_(V)"]                                  
# Write a for loop that linearly interpolates values in these blank clusters 
# Note that there are 2 clusters of blanks ( length(FirstMeasured) = length(LastMeasured) = 2)
for (i in 1:2){
    m_Permittivity[LastMeasured[i]:FirstMeasured[i]]<-seq(m_Permittivity[LastMeasured[i]], m_Permittivity[FirstMeasured[i]],length=length(LastMeasured[i]:FirstMeasured[i]))
    }
              
# Create a column in MoistureData for permittivity at the meter scale including linearly interpolated values in between measurements
MoistureData[m_Rows,"Permittivitiy_interp_m_(V)"]<-m_Permittivity
               
# Run the soil moisture calculation on this vector
a0<-1.600
a1<-8.400
MoistureData[m_Rows,"m_Soil_Moisture_Calculated_(%)"]<-sapply(m_Permittivity, function(x, y, z) ((1+6.175*x+6.303*x^2-73.578*x^3+183.44*x^4-184.78*x^5+68.017*x^6)-y)/z, a0, a1)
               
# Calculate autocovariance at the meter scale                        
# Run the autocovariance function on the soil moisture data at every meter
AutoCov<-sapply(0:9, function(x,y) autoCov(x,y), MoistureData[m_Rows,"m_Soil_Moisture_Calculated_(%)"])

# Add columns for the autocovariance function
MoistureData[m_Rows,"AutoCov_m_lag1"]<-AutoCov[,2]          
MoistureData[m_Rows,"AutoCov_m_lag2"]<-AutoCov[,3] 
MoistureData[m_Rows,"AutoCov_m_lag3"]<-AutoCov[,4] 
MoistureData[m_Rows,"AutoCov_m_lag4"]<-AutoCov[,5] 
MoistureData[m_Rows,"AutoCov_m_lag5"]<-AutoCov[,6] 
MoistureData[m_Rows,"AutoCov_m_lag6"]<-AutoCov[,7] 
MoistureData[m_Rows,"AutoCov_m_lag7"]<-AutoCov[,8] 
MoistureData[m_Rows,"AutoCov_m_lag8"]<-AutoCov[,9] 
MoistureData[m_Rows,"AutoCov_m_lag9"]<-AutoCov[,10] 
MoistureData[m_Rows,"AutoCov_m_lag0"]<-AutoCov[,1] 

# Calculate autocovariance SUM[1/n*([i]-mean)*([i-lag]-mean)] 
acv0<-sum(MoistureData[m_Rows,"AutoCov_m_lag0"])                
acv1<-sum(MoistureData[m_Rows,"AutoCov_m_lag1"])
acv2<-sum(MoistureData[m_Rows,"AutoCov_m_lag2"])
acv3<-sum(MoistureData[m_Rows,"AutoCov_m_lag3"])
acv4<-sum(MoistureData[m_Rows,"AutoCov_m_lag4"])
acv5<-sum(MoistureData[m_Rows,"AutoCov_m_lag5"])
acv6<-sum(MoistureData[m_Rows,"AutoCov_m_lag6"])
acv7<-sum(MoistureData[m_Rows,"AutoCov_m_lag7"])
acv8<-sum(MoistureData[m_Rows,"AutoCov_m_lag8"])
acv9<-sum(MoistureData[m_Rows,"AutoCov_m_lag9"]) 
                
# check
acf(MoistureData[m_Rows,"m_Soil_Moisture_Calculated_(%)"], type="covariance", plot=FALSE)                
                                
# Calculate autocorrelation coefficients 
MoistureData[11,"AutoCor_m_lag1"]<-acv1/acv0  
MoistureData[21,"AutoCor_m_lag2"]<-acv2/acv0
MoistureData[31,"AutoCor_m_lag3"]<-acv3/acv0
MoistureData[41,"AutoCor_m_lag4"]<-acv4/acv0                               
MoistureData[51,"AutoCor_m_lag5"]<-acv5/acv0                               
MoistureData[61,"AutoCor_m_lag6"]<-acv6/acv0                               
MoistureData[71,"AutoCor_m_lag7"]<-acv7/acv0                               
MoistureData[81,"AutoCor_m_lag8"]<-acv8/acv0                               
MoistureData[91,"AutoCor_m_lag9"]<-acv9/acv0                    
                
