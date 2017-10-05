# Set the working directory
setwd("C:\\Users\\erikai94\\Documents\\Tidmarsh\\Calculation_Checks")

# Open csv for West (m)



# Open csv for West (cm)
West_Moisture<-read.csv("West_cm_Check.csv")

# Fix colnames
colnames(West_Moisture)<-c("Meas_No", "Distance_(cm)", "X", "Permittivity_(mV)", "Permittivity_(V)", "Soil Moisture_Mineral", "Soil Moisture_Calculated", "Latitude", "Longitude", "Misc1", "Misc2")

# Make sure the mV to V conversion is correct:
West_Moisture[,"Permittivity_Check"]<-West_Moisture[,"Permittivity_(mV)"]/1000

# Add estimated permittivity (V) values at unmeasured distances
West_Moisture[11:21, "Permittivity_Check"]<-seq(West_Moisture[11,"Permittivity_Check"], West_Moisture[21,"Permittivity_Check"],length=11)
West_Moisture[31:41, "Permittivity_Check"]<-seq(West_Moisture[31,"Permittivity_Check"], West_Moisture[41,"Permittivity_Check"],length=11)
West_Moisture[51:61, "Permittivity_Check"]<-seq(West_Moisture[51,"Permittivity_Check"], West_Moisture[61,"Permittivity_Check"],length=11)
West_Moisture[71:81, "Permittivity_Check"]<-seq(West_Moisture[71,"Permittivity_Check"], West_Moisture[81,"Permittivity_Check"],length=11)
West_Moisture[91:101, "Permittivity_Check"]<-seq(West_Moisture[91,"Permittivity_Check"], West_Moisture[101,"Permittivity_Check"],length=11)
West_Moisture[111:121, "Permittivity_Check"]<-seq(West_Moisture[111,"Permittivity_Check"], West_Moisture[121,"Permittivity_Check"],length=11)
West_Moisture[131:141, "Permittivity_Check"]<-seq(West_Moisture[131,"Permittivity_Check"], West_Moisture[141,"Permittivity_Check"],length=11)
West_Moisture[151:161, "Permittivity_Check"]<-seq(West_Moisture[151,"Permittivity_Check"], West_Moisture[161,"Permittivity_Check"],length=11)
West_Moisture[171:181, "Permittivity_Check"]<-seq(West_Moisture[171,"Permittivity_Check"], West_Moisture[181,"Permittivity_Check"],length=11)
West_Moisture[191:201, "Permittivity_Check"]<-seq(West_Moisture[191,"Permittivity_Check"], West_Moisture[201,"Permittivity_Check"],length=11)
West_Moisture[211:221, "Permittivity_Check"]<-seq(West_Moisture[211,"Permittivity_Check"], West_Moisture[221,"Permittivity_Check"],length=11)
West_Moisture[231:241, "Permittivity_Check"]<-seq(West_Moisture[231,"Permittivity_Check"], West_Moisture[241,"Permittivity_Check"],length=11)
West_Moisture[251:261, "Permittivity_Check"]<-seq(West_Moisture[251,"Permittivity_Check"], West_Moisture[261,"Permittivity_Check"],length=11)
West_Moisture[271:281, "Permittivity_Check"]<-seq(West_Moisture[271,"Permittivity_Check"], West_Moisture[281,"Permittivity_Check"],length=11)
West_Moisture[291:357, "Permittivity_Check"]<-seq(West_Moisture[291,"Permittivity_Check"], West_Moisture[357,"Permittivity_Check"],length=67)
West_Moisture[371:381, "Permittivity_Check"]<-seq(West_Moisture[371,"Permittivity_Check"], West_Moisture[381,"Permittivity_Check"],length=11)
West_Moisture[391:401, "Permittivity_Check"]<-seq(West_Moisture[391,"Permittivity_Check"], West_Moisture[401,"Permittivity_Check"],length=11)
West_Moisture[411:421, "Permittivity_Check"]<-seq(West_Moisture[411,"Permittivity_Check"], West_Moisture[421,"Permittivity_Check"],length=11)
West_Moisture[431:441, "Permittivity_Check"]<-seq(West_Moisture[431,"Permittivity_Check"], West_Moisture[441,"Permittivity_Check"],length=11)
West_Moisture[451:461, "Permittivity_Check"]<-seq(West_Moisture[451,"Permittivity_Check"], West_Moisture[461,"Permittivity_Check"],length=11)
West_Moisture[471:481, "Permittivity_Check"]<-seq(West_Moisture[471,"Permittivity_Check"], West_Moisture[481,"Permittivity_Check"],length=11)
West_Moisture[491:501, "Permittivity_Check"]<-seq(West_Moisture[491,"Permittivity_Check"], West_Moisture[501,"Permittivity_Check"],length=11)
West_Moisture[511:521, "Permittivity_Check"]<-seq(West_Moisture[511,"Permittivity_Check"], West_Moisture[521,"Permittivity_Check"],length=11)
West_Moisture[531:541, "Permittivity_Check"]<-seq(West_Moisture[531,"Permittivity_Check"], West_Moisture[541,"Permittivity_Check"],length=11)
West_Moisture[551:561, "Permittivity_Check"]<-seq(West_Moisture[551,"Permittivity_Check"], West_Moisture[561,"Permittivity_Check"],length=11)
West_Moisture[571:591, "Permittivity_Check"]<-seq(West_Moisture[571,"Permittivity_Check"], West_Moisture[591,"Permittivity_Check"],length=21)
West_Moisture[611:621, "Permittivity_Check"]<-seq(West_Moisture[611,"Permittivity_Check"], West_Moisture[621,"Permittivity_Check"],length=11)
West_Moisture[631:641, "Permittivity_Check"]<-seq(West_Moisture[631,"Permittivity_Check"], West_Moisture[641,"Permittivity_Check"],length=11)
West_Moisture[651:661, "Permittivity_Check"]<-seq(West_Moisture[651,"Permittivity_Check"], West_Moisture[661,"Permittivity_Check"],length=11)
West_Moisture[671:681, "Permittivity_Check"]<-seq(West_Moisture[671,"Permittivity_Check"], West_Moisture[681,"Permittivity_Check"],length=11)
West_Moisture[691:701, "Permittivity_Check"]<-seq(West_Moisture[691,"Permittivity_Check"], West_Moisture[701,"Permittivity_Check"],length=11)
West_Moisture[711:721, "Permittivity_Check"]<-seq(West_Moisture[711,"Permittivity_Check"], West_Moisture[721,"Permittivity_Check"],length=11)
West_Moisture[731:741, "Permittivity_Check"]<-seq(West_Moisture[731,"Permittivity_Check"], West_Moisture[741,"Permittivity_Check"],length=11)
West_Moisture[751:761, "Permittivity_Check"]<-seq(West_Moisture[751,"Permittivity_Check"], West_Moisture[761,"Permittivity_Check"],length=11)
West_Moisture[771:781, "Permittivity_Check"]<-seq(West_Moisture[771,"Permittivity_Check"], West_Moisture[781,"Permittivity_Check"],length=11)
West_Moisture[791:801, "Permittivity_Check"]<-seq(West_Moisture[791,"Permittivity_Check"], West_Moisture[801,"Permittivity_Check"],length=11)

# Round the original permittivity column AND the checked permittivity column to 5 decimal places
West_Moisture[,"Permittivity_(V)"]<-round(West_Moisture[,"Permittivity_(V)"], digits=5)
West_Moisture[,"Permittivity_Check"]<-round(West_Moisture[,"Permittivity_Check"], digits=5)


# Check to see if these columns are identical
identical(West_Moisture[,"Permittivity_(V)"], West_Moisture[,"Permittivity_Check"])


