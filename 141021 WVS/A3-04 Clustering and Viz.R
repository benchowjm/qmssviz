# Clustering
setwd("~/Documents/Uni work/Masters/G4063 Data Viz/qmssviz/141021 WVS")
require("mice")
require("RColorBrewer")
WVS <- read.csv("WVS456_rel.csv")
WVS <- WVS[,-1:-2]

# Extract complete cases
wvs <- WVS[,1:6]
w <- WVS[complete.cases(wvs), ]
rm(WVS, wvs)

# Create dissimilarity matrix
relig <- c("prvblf", "othblf", "pubact", "prvact", "iden1", "iden2")
distW <- dist(w[,1:6])

# Hierarchical clustering
hclust1 <- hclust(distW, method = "ward.D2")
w$hclust14 <- cutree(hclust1, k = 4)
w$hclust15 <- cutree(hclust1, k = 5)

# k-means clustering
set.seed(100)
kclust4 <- kmeans(w[,1:6], 4)
kclust5 <- kmeans(w[1:6], 5)
w$kclust4 <- kclust4$cluster
w$kclust5 <- kclust5$cluster

# Tabulating results
tab41 <- aggregate(cbind(w$prvblf, w$othblf, w$pubact, w$prvact, w$iden1, w$iden2) ~ w$kclust4, FUN = mean, na.action=na.omit)
tab41 <- data.frame(tab41)

tab51 <- aggregate(cbind(w$prvblf, w$othblf, w$pubact, w$prvact, w$iden1, w$iden2) ~ w$kclust5, FUN = mean, na.action=na.omit)
tab51 <- data.frame(tab51)

colnames(tab41) <- colnames(tab51) <- c("clust", relig)

# Normalizing scores & aesthetic ordering
for (i in 2:7) {
    frac <- c(9, 9, 6, 1, 2, 3)
    tab41[,i] <- tab41[,i]/frac[i-1]
    tab51[,i] <- tab51[,i]/frac[i-1]
}

# Reordering
tab41 <- tab41[,c(2:7, 1)]
ord41 <- order(apply(tab41[1:6], 2, FUN = sum), decreasing = TRUE)

tab51 <- tab51[,c(2:7, 1)]
ord51 <- order(apply(tab51[1:6], 2, FUN = sum), decreasing = TRUE)

tab41 <- tab41[,c(ord41, 7)]
tab51 <- tab51[,c(ord51, 7)]

tab42 <- aggregate(w$denom ~ w$kclust4, FUN = table, na.action=na.omit)
tab42 <- data.frame(tab42[,"w$denom"])
tab52 <- aggregate(w$denom ~ w$kclust5, FUN = table, na.action=na.omit)
tab52 <- data.frame(tab52[,"w$denom"])

x5 <- cbind(tab51, tab52)
ord52 <- order(apply(x5[1:6], 1, FUN = sum), decreasing = TRUE)
x5 <- x5[ord52,]

x4 <- cbind(tab41, tab42)
ord42 <- order(apply(x4[1:6], 1, FUN = sum), decreasing = TRUE)
x4 <- x4[ord42,]

# Preparation for visualization: colors and labels
x5$clust <- factor(x5$clust, levels = ord52)
x4$clust <- factor(x4$clust, levels = ord42)
color1 <- c("#2BA4D1", "#C0B00D", "#DC2975", "#29E887", "#FE93FE", "#7165A8")
color2 <- brewer.pal(5, "Set1")
lab <- c("God", "taxes", "attend", "prayer", "self", "general")
lab <- lab[ord51]

# Plot 1
plot(x5$clust, x5$Other, 
     type = "n", 
     frame.plot = F, 
     main = "Characteristics of different types of\n religious people", 
     ylim = c(0, 1), 
     xlab = "Cluster No.", ylab = "Score", 
     axes = F)
for(i in 1:5){
    axis(1, at = c(i), labels = c(i), lwd = 2, col.axis = color2[i], col.ticks = color2[i])    
}
axis(2, at = c(seq(0, 1, by = 0.2)), labels = seq(0, 1, by = 0.2), lwd = 0, las = 1)
for(i in 1:6){
    points(x5$clust, x5[,relig[i]], pch = 19, col = color1[i])
    lines(x5$clust, x5[,relig[i]], lwd = 2, col = color1[i], lty = 3)
}
legend(1, 0.45, legend = lab, col = color1, pch = 16, text.col = color1, box.lty = 0)


# Plot 2
plot(c(1:6), c(rep(5, 6)), 
     type = "n", 
     frame.plot = F, 
     main = "Religious scores by category", 
     xlim = c(1, 6), ylim = c(0, 1), 
     xlab = NA, ylab = "Score",
     axes = F)
for(i in 1:6){
    axis(1, at = c(i), labels = lab[i], lwd = 2, col.ticks = color1[i], col.axis = color1[i])
}
axis(2, at = c(seq(0, 1, by = 0.2)), labels = seq(0, 1, by = 0.2), lwd = 0, las = 1)
for(i in 1:5){
    lines(c(1:6), x5[i, 1:6], lwd = 2, col = color2[i])
    points(c(1:6), x5[i, 1:6], pch = 16, col = color2[i])    
}
legend(1, 0.39, legend = c("cluster 1", "cluster 2", "cluster 3", "cluster 4", "cluster 5"), col = color2, lty = 1, lwd = 2, text.col = color2, box.lty = 0)


