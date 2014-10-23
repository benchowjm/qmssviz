# Visualization

setwd("~/Documents/Uni work/Masters/G4063 Data Viz/qmssviz/141021 WVS")
require("plyr")
require("doBy")
require("ggplot2")
require("scales")

wvs <- read.csv("WVS456_rel.csv")
View(wvs)
wvs$wave <- factor(wvs$wave)

# Time Trends
ggplot(wvs, aes(x=prvblf))+geom_histogram()
plot1 <- ggplot(wvs, aes(x=prvblf)) + geom_histogram(aes(y=..density..), binwidth = 1, position = "dodge")
plot1 + facet_grid(. ~ wave)

ggplot(wvs, aes(x=prvact, fill = wave)) + geom_bar(aes(y=..density..), position = "dodge", binwidth = 0.5)



