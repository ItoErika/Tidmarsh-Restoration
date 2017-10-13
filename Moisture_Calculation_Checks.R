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

# Write a for loop that interpolates values in these blank clusters 
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

# Autocovariance check
# Calculate average soil moisture
SM_mean<-mean(West_m_Moisture[,"Soil_Moisture_Mineral_Calculated_(%)"])
# Record number of soil moisture measurements
n<-length(West_m_Moisture[,"Soil_Moisture_Mineral_Calculated_(%)"])
# Make empty vector for autocovariance check
AutoCov_Check<-vector(length=length(West_m_Moisture[,"Soil_Moisture_Mineral_Calculated_(%)"])-1)
# Write for loop to perform sample autocovariance
for (i in 2:length(West_m_Moisture[,"Soil_Moisture_Mineral_Calculated_(%)"])){
    AutoCov_Check[i]<-West_m_Moisture[i,"Soil_Moisture_Mineral_Calculated_(%)"]+(West_m_Moisture[i,"Soil_Moisture_Mineral_Calculated_(%)"]-SM_mean)*(West_m_Moisture[i-1,"Soil_Moisture_Mineral_Calculated_(%)"]-SM_mean)
    }               
# acf(West_m_Moisture[,"Mineral_Calculated_(%)"], lag.max = 787, type ="covariance", plot = FALSE)
