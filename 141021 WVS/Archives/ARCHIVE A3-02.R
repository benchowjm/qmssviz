# Merging data
# Aim 1: Extract only US data
# Aim 2: Standardize variable names
setwd("~/Documents/Uni work/Masters/G4063 Data Viz/qmssviz/141021 WVS")
require("plyr")

W6 <- read.csv("WVS6_rel.csv")
W5 <- read.csv("WVS5_rel.csv")
W4 <- read.csv("WVS4_rel.csv")
W3 <- read.csv("WVS3_rel.csv")

# Wave 6
W6 <- rename(W6, c("V108" = "pubbel1", "V148" = "pribel1", "V201" = "othbel2", "V145" = "pubact1", "V25" = "pubact2", "V146" = "priact1", "V143" = "priact2", "V147" = "iden1", "V9" = "iden2", "V152" = "iden3", "V2" = "country", "V240" = "sex", "V242" = "age", "V248" = "educ", "V229" = "wrkstat", "V254" = "ethnic", "V144" = "denom", "V57" = "marital"))

W5 <- rename(W5, c("V131" = "pubbel1", "V194" = "pubbel2", "V197" = "pubbel3", "V196" = "pubbel4", "V58" = "othbel1", "V200" = "othbel2", "V186" = "pubact1", "V24" = "pubact2", "V193" = "priact1", "V184" = "priact2", "V187" = "iden1", "V9" = "iden2", "V192" = "iden3", "V2" = "country", "V235" = "sex", "V237" = "age", "V238" = "educ", "V241" = "wrkstat", "V256" = "ethnic", "V185" = "denom", "V55" = "marital"))

W4 <- rename(W4, c("v147" = "pubbel1", "v200" = "pubbel2", "v203" = "pubbel3", "v202" = "pubbel4", "v191" = "pribel1", "v193" = "pribel2", "v195" = "pribel3", "v111" = "othbel1", "v206" = "othbel2", "v185" = "pubact1", "v40" = "pubact2", "v198" = "priact1", "v182" = "priact2", "v186" = "iden1", "v9" = "iden2", "v196" = "iden3", "v2" = "country", "v223" = "sex", "v225" = "age", "v226" = "educ", "v229" = "wrkstat", "v242" = "ethnic", "v184" = "denom", "v106" = "marital"))

W3 <- rename(W3, c("V135" = "pubbel1", "V183" = "pribel1", "V185" = "pribel2", "V188" = "pribel3", "V94" = "othbel1", "V194" = "othbel2", "V181" = "pubact1", "V28" = "pubact2", "V177" = "priact2", "V182" = "iden1", "V177" = "priact2", "V182" = "iden1", "V9" = "iden2", "V190" = "iden3", "V2" = "country", "V214" = "sex", "V216" = "age", "V217" = "educ", "V220" = "wrkstat", "V233" = "ethnic", "V179" = "denom", "V89" = "marital"))

# Check to make sure that USA has country code 840
dim(W6[W6$country==840, ])
dim(W5[W5$country==840, ])
dim(W4[W4$country==840, ])
dim(W3[W3$country==840, ])

W6 <- W6[W6$country==840, ]
W5 <- W5[W5$country==840, ]
W4 <- W4[W4$country==840, ]
W3 <- W3[W3$country==840, ]

write.csv(W6, file = "WVS6_rel.csv")
write.csv(W5, file = "WVS5_rel.csv")
write.csv(W4, file = "WVS4_rel.csv")
write.csv(W3, file = "WVS3_rel.csv")

# Recode for pubact2: Are you a member of a church organization? 0: No. 1: Yes
    table(W4$pubact2)
W4[W4$pubact2==2, "pubact2"] <- 0
W4$pubact2 <- cut(W4$pubact2, breaks = c(-1, 0.9, 1.1), labels = c(0, 1))
    table(W3$pubact2)
W3[W3$pubact2==-1, "pubact2"] <- NA
W3$pubact2 <- cut(W3$pubact2, breaks = c(0, 2.1, 3.1), labels = c(1, 0))
    table(W5$pubact2)
W5[W5$pubact2==-5 | W5$pubact2==-2, "pubact2"] <- NA
W5$pubact2 <- cut(W5$pubact2, breaks = c(-1, 0.9, 2.1), labels = c(0, 1))
    table(W6$pubact2)
W6$pubact2 <- cut(W6$pubact2, breaks = c(-1, 0.9, 2.1), labels = c(0, 1))

names(W3)
