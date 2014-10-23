# A3-03 More Recoding at an aggregate level
# Aim 1: All religious variables should have increasing religiosity
# Aim 2: Extract only people who identify themselves as religious

setwd("~/Documents/Uni work/Masters/G4063 Data Viz/qmssviz/141021 WVS")
wvs <- read.csv("WVS456_rel.csv")

# prvblf: How important is God in your life [0:9]
wvs$prvblf <- recodeVar(wvs$prvblf, src = c(1:10), tgt = c(0:9))

# othblf: How often is cheating on taxes (if you have a chance) justified? [0:9]
wvs$othblf <- 10 - wvs$othblf

# pubact: How often do you attend religious services these days (apart from weddings and funerals)? [0:6]
wvs$pubact <- recodeVar(wvs$pubact, src = c(-1, -2, -5, 1:7), tgt = c(NA, NA, NA, 6:0))

# prvact: Do you take some moments of prayer and meditation from time to time? [0:1]

# iden1: Independently of religious service attendance, would you consider yourself religious? [0:2]
wvs$iden1 <- recodeVar(wvs$iden1, src = c(-5, -2, -1, 1:3), tgt = c(NA, NA, NA, 2:0))

# iden2: How important is religion in your life? [0:3]
wvs$iden2 <- recodeVar(wvs$iden2, src = c(-2, -1, 1:4), tgt = c(NA, NA, 3:0))

# Wave variable
wvs$wave <- factor(wvs$wave)

# Exclude nonreligious respondents
wvs <- wvs[wvs$denom!="None", ]
wvs <- wvs[!is.na(wvs$denom), ]

# Overwrite file
write.csv(wvs, file = "WVS456_rel.csv")
