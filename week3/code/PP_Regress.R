rm(list = ls())
data <- read.csv("../data/EcolArchives-E089-51-D1.csv")
head(data)
require(ggplot2)
data$Type.of.feeding.interaction<-as.factor(data$Type.of.feeding.interaction)
data$Predator.lifestage<-as.factor(data$Predator.lifestage)
str(data)
pdf("../results/PP_Regress.pdf")
p <- ggplot(data, aes(log(Prey.mass),log(Predator.mass)))+
  geom_point(data, mapping= aes(color = Predator.lifestage), size=I(1), shape=I(3),alpha=0.5)+
  facet_grid(Type.of.feeding.interaction ~.,scales = "free")+
  stat_smooth(data, mapping= aes(color = Predator.lifestage,size=I(0.5)), method = "lm", fullrange = TRUE)
p <- p + theme_bw() + # make the background white
  theme(aspect.ratio=0.5, legend.position = "bottom",
        legend.key.size = unit(0.5,"cm"),
        axis.title.x = element_text(vjust = 1, size = 10),
        axis.title.y = element_text(size = 10),
        legend.title = element_text(face='bold',size = 8),
        legend.text = element_text(size = 8))+
  guides(color = guide_legend(nrow = 1))+
  labs(x= "Prey Mass(g)", y = "Predator Mass(g)",
       color ="Predator.lifestage",size=0.1)
p
dev.off()

uniqF<-unique(data$Type.of.feeding.interaction)
uniqL<-unique(data$Predator.lifestage)

df<- data.frame()
for (i in uniqF){
  for(k in uniqL){
    PreM<- subset(data, data$Type.of.feeding.interaction ==i&
                             data$Predator.lifestage == k)
    if (dim(PreM)[1] != 0){
      
      sumlm<- summary(lm(log(Predator.mass)~log(Prey.mass),data = PreM),na.action=na.exclude)
      if (is.null(sumlm$fstatistic)){
        f<- "Na"
      }else{f<-sumlm$fstatistic[1]}
      daf<- data.frame(
        i,
        k,
        sumlm$r.squared,
        sumlm$coefficients[1],
        sumlm$coefficients[2],
        sumlm$coefficients[8],
        f)
      df<- rbind(daf,df)
    }else{print(paste("Not include:",i,k))}
  }
}


names(df) = c("Type of Feeding Interaction", "Predator Lifestage",
                  "R2", "intercept", "slope", "p-value", "F-value")
write.csv(df,"../results/PP_Regress_Results.csv")
