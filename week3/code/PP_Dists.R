rm(list = ls())
MyData <- read.csv("../Data/EcolArchives-E089-51-D1.csv")
str(MyData)
require(ggplot2)

logPred <- log(MyData$Predator.mass)
logPrey <- log(MyData$Prey.mass)
Ratio <- MyData$Prey.mass/MyData$Predator.mass
logRatio <- log(Ratio)
feeding <- MyData$Type.of.feeding.interaction
TempData = data.frame(feeding, logPred, logPrey, logRatio)

pdf("../Results/Pred_Subplots.pdf")
ggplot(TempData,aes(x=logPred), 
     xlab="Body Mass (g)", ylab="Count", 
     main = "Predator mass") +
  geom_histogram(aes(x=logPred, color = feeding, fill = feeding),
                     alpha = 0.4,
                     bins =30)+
  scale_fill_manual(values = c(2,3,4,5,6))

graphics.off();


pdf("../Results/Prey_Subplots.pdf")
ggplot(TempData,aes(x=logPrey), 
       xlab="Body Mass (g)", ylab="Count", 
       main = "Prey mass") +
  geom_histogram(aes(x=logPrey, color = feeding, fill = feeding),
                 alpha = 0.4,
                 bins =30)+
  scale_fill_manual(values = c(2,3,4,5,6))

graphics.off()

pdf("../Results/SizeRatio_Subplots.pdf")
ggplot(TempData,aes(x=logratio), 
       xlab="Body Mass (g)", ylab="Count", 
       main = "Size Ratio of prey mass and predator mass") +
  geom_histogram(aes(x=logRatio, color = feeding, fill = feeding),
                 alpha = 0.4,
                 bins =30)+
  scale_fill_manual(values = c(2,3,4,5,6))

graphics.off()


Data <- data.frame(logPred, logPrey, Ratio, logRatio)
write.csv(Data, file = "../Results/PP_Results.csv")
