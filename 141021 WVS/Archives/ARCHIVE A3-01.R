# Stage 1: Data extraction & conversion to csv files

# This project aims to characterize the evolution of religious beliefs, identity and practices over time in the US.

setwd("~/Documents/Uni work/Masters/G4063 Data Viz/qmssviz/141021 WVS")
setwd("~/Documents/Uni work/Masters/General Data/WVS")
require("plyr")

# Extract from wave 6
x <- read.csv("WVS Wave 6.csv")
y6 <- x[, c("V108", "V148", "V201", "V145", "V25", "V146", "V143", "V147", "V9", "V152", "V2", "V240", "V242", "V248", "V229", "V254", "V144", "V57")]

write.csv(y6, file = "WVS6_rel.csv")

# Extract from wave 5
load("/Users/bchowkc/Documents/Uni work/Masters/General Data/WVS/WVS Wave 5.rdata")
x <- WV5_Data_spss_v_2014_04_28
y5 <- x[, c("V2", "V131", "V194", "V197", "V196", "V58", "V200", "V186", "V24", "V193", "V184", "V187", "V9", "V192", "V235", "V237", "V238", "V241", "V256", "V185", "V55")]
write.csv(y5, file = "WVS5_rel.csv")

# Extract from wave 4
load("/Users/bchowkc/Documents/Uni work/Masters/General Data/WVS/WVS Wave 4.rdata")
x <- get("WV4_Data_rdata_v_2014-04-28", envir = globalenv())
y4 <- x[, c("v147", "v200", "v203", "v202", "v191", "v193", "v195", "v111", "v206", "v185", "v40", "v198", "v182", "v186", "v9", "v196", "v2", "v223", "v225", "v226", "v229", "V242", "v184", "v106")]
y4 <- rename(y4, c("V242" = "v242"))
write.csv(y4, file = "WVS4_rel.csv")

# Extract from wave 3
load("WVS Wave 3.rdata")
x <- WV3_Data_rdata_v_2014_09_21
rm(WV3_Data_rdata_v_2014_09_21)
y3 <- x[, c("V135", "V183", "V185", "V188", "V94", "V194", "v181", "V28", "V178", "V177", "V182", "V9", "V190", "V2", "V214", "V216", "V217", "V220", "V233", "V179", "V89")]
y3 <- rename(y3, c("v181" = "V181"))
write.csv(y3, file = "WVS3_rel.csv")

# Final product: produced 4 csv files corresponding 4 waves, with only the relevant variables