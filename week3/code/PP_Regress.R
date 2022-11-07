rm(list = ls())
data <- read.csv("../data/EcolArchives-E089-51-D1.csv")
head(data)

data$Type.of.feeding.interaction<-as.factor(data$Type.of.feeding.interaction)
data$Predator.lifestage<-as.factor(data$Predator.lifestage)
str(data)
pdf("../results/PP_Regress.pdf")
p <- ggplot(data, aes(log(Prey.mass),log(Predator.mass)))+
  geom_point(mapping= aes(color = data$Predator.lifestage), size=I(1), shape=I(3),alpha=0.5)+
  facet_grid(Type.of.feeding.interaction ~.,scales = "free")+
  stat_smooth(mapping= aes(color = data$Predator.lifestage,size=I(0.5)), method = "lm", fullrange = TRUE)
p <- p + theme_bw() + # make the background white
  theme(aspect.ratio=0.5, legend.position = "bottom",
        legend.key.size = unit(0.5,"cm"),
        axis.title.x = element_text(vjust = 1, size = 10),
        axis.title.y = element_text( size = 10),
        legend.title = element_text(face='bold',size = 8),
        legend.text = element_text(size = 8))+
        guides(color = guide_legend(nrow = 1))+
  labs(x= "Prey Mass(g)", y = "Predator Mass(g)",
       color ="Predator.lifestage",size=0.1)
p
graphics.off()

summary(data$Prey.mass,data$Predator.mass)
