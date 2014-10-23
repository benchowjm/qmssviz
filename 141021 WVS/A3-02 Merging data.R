# Merging data
# Aim 1: Extract only US data
# Aim 2: Standardize variable names
# Aim 3: 
setwd("~/Documents/Uni work/Masters/G4063 Data Viz/qmssviz/141021 WVS")
require("plyr")
require("doBy")

W6 <- read.csv("WVS6_rel.csv")
W5 <- read.csv("WVS5_rel.csv")
W4 <- read.csv("WVS4_rel.csv")

W6 <- rename(W6, c("V152" = "prvblf", "V201" = "othblf", "V145" = "pubact", "V146" = "prvact", "V147" = "iden1", "V9" = "iden2", "V2" = "wave", "V240" = "sex", "V242" = "age", "V248" = "educ", "V229" = "work", "V254" = "ethnic", "V144" = "denom", "V57" = "marital"))

W5 <- rename(W5, c("V192" = "prvblf", "V200" = "othblf", "V186" = "pubact", "V193" = "prvact", "V187" = "iden1", "V9" = "iden2", "V2" = "wave", "V235" = "sex", "V237" = "age", "V238" = "educ", "V241" = "work", "V256" = "ethnic", "V185" = "denom", "V55" = "marital"))

W4 <- rename(W4, c("v196" = "prvblf", "v206" = "othblf", "v185" = "pubact", "v198" = "prvact", "v186" = "iden1", "v9" = "iden2", "v2" = "wave", "v223" = "sex", "v225" = "age", "v226" = "educ", "v229" = "work", "v242" = "ethnic", "v184" = "denom", "v106" = "marital"))

write.csv(W6, file = "WVS6_rel.csv")
write.csv(W5, file = "WVS5_rel.csv")
write.csv(W4, file = "WVS4_rel.csv")

# Recode for prvact: Do you pray every once in awhile? 0: No. 1: Yes
    # table(W6$prvact)
W6$prvact <- recodeVar(W6$prvact, src = c(1:8), tgt = c(rep(1, 4), rep(0, 4)))
    # table(W5$prvact)
W5$prvact <- recodeVar(W5$prvact, src = c(-5, -2, 1, 2), tgt = c(NA, NA, 1, 0))
    # table(W4$prvact)
W4$prvact <- recodeVar(W4$prvact, src = c(-1, 1, 2), tgt = c(NA, 1, 0))

# Recode for ethnic
    # table(W6$ethnic)
W6$ethnic <- recodeVar(W6$ethnic, src = c(840002:840006), tgt = c("White", "Black", "Other", "Hispanic", "Other"))
W6$ethnic <- factor(W6$ethnic, levels = c("White", "Black", "Hispanic", "Other"))
    # table(W5$ethnic)
W5$ethnic <- recodeVar(W5$ethnic, src = c(1400, 200, 1250, 8001, 8000), tgt = c("White", "Black", "Hispanic", "Other", "Other"))
W5$ethnic <- factor(W5$ethnic, levels = c("White", "Black", "Hispanic", "Other"))
    # table(W4$ethnic)
W4$ethnic <- recodeVar(W4$ethnic, src = c(840002:840009), tgt = c("White", "Black", "Other", "Hispanic", NA, rep("Other", 3)))
W4$ethnic <- factor(W4$ethnic, levels = c("White", "Black", "Hispanic", "Other"))

# Recode for marital
    # table(W6$marital)
W6$marital <- recodeVar(W6$marital, src = c(1:6), tgt = c("Married", "Married", "Separated", "Separated", "Widowed", "Single"))
W6$marital <- factor(W6$marital)
    # table(W5$marital)
W5$marital <- recodeVar(W5$marital, src = c(1:6), tgt = c("Married", NA, "Separated", "Separated", "Widowed", "Single"))
W5$marital <- factor(W5$marital)
    # table(W4$marital)
W4$marital <- recodeVar(W4$marital, src = c(1:6), tgt = c("Married", "Married", "Separated", "Separated", "Widowed", "Single"))
W4$marital <- factor(W4$marital)

# Recode for work
    # table(W6$work)
W6$work <- recodeVar(W6$work, src = c(1:8), tgt = c("Full Time", "Part Time", "Self Employed", "Unemployed", "Housewife", "Other", "Unemployed", "Other"))
W6$work <- factor(W6$work, levels = c("Full Time", "Part Time", "Self Employed", "Housewife", "Unemployed", "Other"))
    # table(W5$work)
W5$work <- recodeVar(W5$work, src = c(1:8), tgt = c("Full Time", "Part Time", "Self Employed", "Unemployed", "Housewife", "Other", "Unemployed", "Other"))
W5$work <- factor(W5$work, levels = c("Full Time", "Part Time", "Self Employed", "Housewife", "Unemployed", "Other"))
    # table(W4$work)
W4$work <- recodeVar(W4$work, src = c(-1, 1:8), tgt = c(NA, "Full Time", "Part Time", "Self Employed", "Unemployed", "Housewife", "Other", "Unemployed", "Other"))
W4$work <- factor(W4$work, levels = c("Full Time", "Part Time", "Self Employed", "Housewife", "Unemployed", "Other"))

# Recode for educ
    # table(W6$educ)
W6$educ <- recodeVar(W6$educ, src = c(1:9), tgt = c(rep("Primary School", 3), rep("High School", 4), "Some College", "Degree"))
W6$educ <- ordered(W6$educ, levels = c("Primary School", "High School", "Some College", "Degree"))
    # table(W5$educ)
W5$educ <- recodeVar(W5$educ, src = c(1:9), tgt = c(rep("Primary School", 3), rep("High School", 4), "Some College", "Degree"))
W5$educ <- ordered(W5$educ, levels = c("Primary School", "High School", "Some College", "Degree"))
    # table(W4$educ)
W4$educ <- recodeVar(W4$educ, src = c(1:9), tgt = c(rep("Primary School", 3), rep("High School", 4), "Some College", "Degree"))
W4$educ <- ordered(W4$educ, levels = c("Primary School", "High School", "Some College", "Degree"))

# Recode for gender
    # table(W6$sex)
W6$sex <- recodeVar(W6$sex, src = c(1, 2), tgt = c("Male", "Female"))
W6$sex <- factor(W6$sex)
    # table(W5$sex)
W5$sex <- recodeVar(W5$sex, src = c(1, 2), tgt = c("Male", "Female"))
W5$sex <- factor(W5$sex)
    # table(W4$sex)
W4$sex <- recodeVar(W4$sex, src = c(1, 2), tgt = c("Male", "Female"))
W4$sex <- factor(W4$sex)

# Recode for denom
    # table(W6$denom)
W6$denom <- recodeVar(W6$denom, src = c(0, 12, 31, 42, 49, 52, 53, 62, 64), tgt = c("None", "Other", "Other", "Judaism", "Other", "Christian", "Other", "Christian", "Catholic"))
W6$denom <- factor(W6$denom, levels = c("None", "Christian", "Catholic", "Judaism", "Other"))
    # table(W5$denom)
W5$denom <- recodeVar(W5$denom, src = c(-5, -2, 0, 12, 31, 42, 49, 52, 53, 62, 64), tgt = c(NA, NA, "None", "Other", "Other", "Judaism", "Other", "Christian", "Other", "Christian", "Catholic"))
W5$denom <- factor(W5$denom, levels = c("None", "Christian", "Catholic", "Judaism", "Other"))
    # table(W4$denom)
W4$denom <- recodeVar(W4$denom, src = c(-2, 0, 12, 31, 42, 49, 52, 53, 62, 64), tgt = c(NA, "None", "Other", "Other", "Judaism", "Other", "Christian", "Other", "Christian", "Catholic"))
W4$denom <- factor(W4$denom, levels = c("None", "Christian", "Catholic", "Judaism", "Other"))

# Renaming residual vars before merging
W6 <- rename(W6, c("V108" = "pubblf1", "V148" = "prvblf4", "V25" = "pubact3", "V143" = "prvact2"))
W5 <- rename(W5, c("V131" = "pubblf1", "V194" = "pubblf2", "V197" = "pubblf3", "V196" = "pubblf4", "V58" = "othblf2", "V24" = "pubact3", "V184" = "prvact2"))
W4 <- rename(W4, c("v147" = "pubblf1", "v200" = "pubblf2", "v203" = "pubblf3", "v202" = "pubblf4", "v193" = "prvblf2", "v195" = "prvblf3", "v191" = "prvblf4", "v111" = "othblf2", "v40" = "pubact2", "v182" = "prvact2"))

write.csv(W6, file = "WVS6_rel.csv")
write.csv(W5, file = "WVS5_rel.csv")
write.csv(W4, file = "WVS4_rel.csv")
save.image("~/Documents/Uni work/Masters/G4063 Data Viz/qmssviz/141021 WVS/WVS_Merged.RData")

W45 <- join(W4, W5, type = "full")
wvs <- join(W45, W6, type = "full")
str(wvs)
write.csv(wvs, file = "WVS456_rel.csv")
