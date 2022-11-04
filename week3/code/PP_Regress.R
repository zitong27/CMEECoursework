rm(list = ls())
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
head(MyDF)

data$Type.of.feeding.interaction<-as.factor(data$Type.of.feeding.interaction)
data$Predator.lifestage<-as.factor(data$Predator.lifestage)
