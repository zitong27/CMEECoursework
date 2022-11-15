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
UniqFeeding <- unique(feeding)
par(mfrow=c(2,3))
MeanPred<-c()
MeanPrey<-c()
MeanRatio<-c()
MedPred<-c()
MedPrey<-c()
MedRatio<-c()


pdf("../Results/Pred_Subplots.pdf")
ggplot(TempData,aes(x=logPred))+ 
     labs(x="Body Mass", y="", 
     title  = "Predator mass") +
  geom_histogram(aes(x=logPred, color = feeding, fill = feeding),
                 alpha = 0.4,
                bins =30)+
  scale_fill_manual(values = c(2,3,4,5,6))+
  scale_color_manual(values = c(2,3,4,5,6))+
  facet_wrap( .~ feeding, scales = "free")
k <- 0
for (i in UniqFeeding){
  hist(TempData$logPred[TempData$feeding==i],xlab = i)
  k <- k+ 1
  MeanPred[k] <-(mean(TempData$logPred[TempData$feeding==i]))
  MedPred[k] <-(median(TempData$logPred[TempData$feeding==i]))
}
graphics.off();


pdf("../Results/Prey_Subplots.pdf")
ggplot(TempData,aes(x=logPrey))+ 
       labs(x="Body Mass", y="", 
       title = "Prey mass") +
  geom_histogram(aes(x=logPrey, color = feeding, fill = feeding),
                 alpha = 0.4,
                 bins =30)+
  scale_fill_manual(values = c(2,3,4,5,6))+
  scale_color_manual(values = c(2,3,4,5,6))+
  facet_wrap( .~ feeding, scales = "free")
k <- 0
for (i in UniqFeeding){
  hist(TempData$logPrey[TempData$feeding==i],xlab = i)
  k <- k+ 1
  MeanPrey[k] <-(mean(TempData$logPrey[TempData$feeding==i]))
  MedPrey[k] <-(median(TempData$logPrey[TempData$feeding==i]))
}
graphics.off()

pdf("../Results/SizeRatio_Subplots.pdf")
ggplot(TempData,aes(x=logratio)) + 
       labs(x= "Body Mass (g)", y="", 
       title  = "Size Ratio of prey mass and predator mass") +
  geom_histogram(aes(x=logRatio, color = feeding, fill = feeding),
                 alpha = 0.4,
                 bins =30)+
  scale_fill_manual(values = c(2,3,4,5,6))+
  scale_color_manual(values = c(2,3,4,5,6))+
  facet_wrap( .~ feeding, scales = "free")
k <- 0
for (i in UniqFeeding){
  hist(TempData$logRatio[TempData$feeding==i],xlab = i)
  k <- k + 1
  MeanRatio[k] <-(mean(TempData$logRatio[TempData$feeding==i]))
  MedRatio[k] <-(median(TempData$logRatio[TempData$feeding==i]))
}
graphics.off()

Data <- data.frame(MeanPred,MedPred,MeanPrey,MedPrey,MeanRatio,MedRatio)
rownames(Data) <- UniqFeeding
write.csv(Data, file = "../Results/PP_Results.csv")
