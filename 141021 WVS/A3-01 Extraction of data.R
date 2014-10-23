# Stage 1: Data extraction & conversion to csv files

# This project aims to characterize the evolution of religious beliefs, identity and practices over time in the US.

setwd("~/Documents/Uni work/Masters/G4063 Data Viz/qmssviz/141021 WVS")
setwd("~/Documents/Uni work/Masters/General Data/WVS")
require("plyr")

# Extract from wave 6
x <- read.csv("WVS Wave 6.csv")
y6 <- x[, c("V108", "V148", "V201", "V145", "V25", "V146", "V143", "V147", "V9", "V152", "V2", "V240", "V242", "V248", "V229", "V254", "V144", "V57")]
# US Data only
y6 <- y6[y6$V2==840, ]
y6$V2 <- 3
write.csv(y6, file = "WVS6_rel.csv")
rm(y6)

# Extract from wave 5
load("/Users/bchowkc/Documents/Uni work/Masters/General Data/WVS/WVS Wave 5.rdata")
x <- WV5_Data_spss_v_2014_04_28
rm(WV5_Data_spss_v_2014_04_28)
y5 <- x[, c("V192", "V200", "V186", "V193", "V187", "V9", "V2", "V235", "V237", "V238", "V241", "V256", "V185", "V55", "V131", "V194", "V197", "V196", "V58", "V24", "V184")]
y5 <- y5[y5$V2==840, ]
y5$V2 <- 2
write.csv(y5, file = "WVS5_rel.csv")
rm(y5)

# Extract from wave 4
load("/Users/bchowkc/Documents/Uni work/Masters/General Data/WVS/WVS Wave 4.rdata")
x <- get("WV4_Data_rdata_v_2014-04-28", envir = globalenv())
y4 <- x[, c("v196", "v206", "v185", "v198", "v186", "v9", "v2", "v223", "v225", "v226", "v229", "V242", "v184", "v106", "v147", "v200", "v203", "v202", "v193", "v195", "v191", "v111", "v40", "v182")]
y4 <- rename(y4, c("V242" = "v242"))
y4 <- y4[y4$v2==840,]
y4$v2 <- 1
write.csv(y4, file = "WVS4_rel.csv")
rm(list=ls())


# Final product: produced 3 csv files with corresponding 3 waves, with only the relevant variables, and only observations from the USA. v2 / V2 now corresponds to the wave number
