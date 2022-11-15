rm(list=ls())

load("../data/KeyWestAnnualMeanTemperature.RData")


dataCor <- cor(ats$Year,ats$Temp)

n<-200000
shuffleC <- numeric(length = n)
for (i in 1:n){
  shufdata <- ats[sample(nrow(ats)),]
  shuffleC[i] <-cor(ats$Year,shufdata$Temp)
}

k <- 1
for (i in shuffleC){
  if (dataCor<= i){
    k + 1
  }
}
hist(shuffleC)
pdf(file="../results/CorTemp.pdf")
CorTemp <- hist(shuffleC)
dev.off()

pvalue<- k/length(shuffleC)

pvalue

