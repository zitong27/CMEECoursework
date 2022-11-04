rm(list=ls())
MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = FALSE))
class(MyData)
MyMetaData <- read.csv("../data/PoundHillMetaData.csv",header = TRUE,  sep=";")
class(MyMetaData)
head(MyData)
MyMetaData
dim(MyData)
str(MyData)
MyData[MyData == ""] = 0
MyData <- dplyr::as_tibble(t(MyData))
head(MyData)
colnames(MyData)
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F)
head(TempData)
colnames(TempData) <- MyData[1,] # assign column names from original data
head(TempData)
rownames(TempData) <- NULL
head(TempData)
require(reshape2)# load the reshape2 package
MyWrangledData <- gather(TempData, key="Species",value = "Count", -"Cultivation", -"Block", -"Plot", -"Quadrat")
head(MyWrangledData); tail(MyWrangledData)
MyWrangledData <- MyWrangledData %>%
  mutate(Cultivation = as.factor(Cultivation),
         Block = as.factor(Block),
         Plot =as.factor(Plot),
         Quadrat = as.factor(Quadrat),
         Species = as.factor(Species),
         Count = as.integer(Count))
         

glimpse(MyWrangledData) #like str(), but nicer!
filter(MyWrangledData, Count>100) #like subset(), but nicer!
slice(MyWrangledData, 10:15) # Look at a particular range of data rows
MyWrangledData %>%
  group_by(Species) %>%
  summarise(avg = mean(Count))
aggregate(MyWrangledData$Count, list(MyWrangledData$Species), FUN=mean) 

