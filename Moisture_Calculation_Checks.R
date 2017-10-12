# Set the working directory
setwd("C:/Users/erikai94/Documents/UMass/Tidmarsh/Calculation_Checks")

######################################################### West (cm) ###################################################################
# Open csv for West (cm)
West_Moisture<-read.csv("West_cm_Check.csv")

# Fix colnames
colnames(West_Moisture)<-c("Meas_No", "Distance_(cm)", "X", "Permittivity_(mV)", "Permittivity_(V)", "Soil Moisture_Mineral", "Soil Moisture_Calculated", "Latitude", "Longitude", "Misc1", "Misc2")

# Make sure the mV to V conversion is correct:
West_Moisture[,"Permittivity_Check"]<-West_Moisture[,"Permittivity_(mV)"]/1000

# Add approximated values in between data from probe measurements:
# Identify which rows have data
Measured<-which(!(is.na((West_Moisture[,"Permittivity_Check"]))))
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
    West_Moisture[LastMeasured[i]:FirstMeasured[i],"Permittivity_Check"]<-seq(West_Moisture[LastMeasured[i],"Permittivity_Check"], West_Moisture[FirstMeasured[i],"Permittivity_Check"],length=length(LastMeasured[i]:FirstMeasured[i]))
    }

# Round the original permittivity column AND the checked permittivity column to 5 decimal places
West_Moisture[,"Permittivity_(V)"]<-round(West_Moisture[,"Permittivity_(V)"], digits=5)
West_Moisture[,"Permittivity_Check"]<-round(West_Moisture[,"Permittivity_Check"], digits=5)

# Check to see if these columns are identical
identical(West_Moisture[,"Permittivity_(V)"], West_Moisture[,"Permittivity_Check"])
which(West_Moisture[,"Permittivity_(V)"]-West_Moisture[,"Permittivity_Check"]!=0)
# NOTE:
West_Moisture[572:591,c("Permittivity_(V)", "Permittivity_Check")]

######################################################### West (m) ####################################################################

