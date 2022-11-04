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
MyData <- t(MyData) 
head(MyData)
colnames(MyData)
TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F)
head(TempData)
colnames(TempData) <- MyData[1,] # assign column names from original data
head(TempData)
rownames(TempData) <- NULL
head(TempData)
require(reshape2)# load the reshape2 package
MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")
head(MyWrangledData); tail(MyWrangledData)
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])
str(MyWrangledData)
require(tidyverse)
tidyverse_packages(include_self = TRUE) # the include_self = TRUE means list "tidyverse" as well 
MyWrangledData <- dplyr::as_tibble(MyWrangledData) 
MyWrangledData
MyWrangledData <- as_tibble(MyWrangledData) 
class(MyWrangledData)
glimpse(MyWrangledData) #like str(), but nicer!
filter(MyWrangledData, Count>100) #like subset(), but nicer!
slice(MyWrangledData, 10:15) # Look at a particular range of data rows
MyWrangledData %>%
  group_by(Species) %>%
  summarise(avg = mean(Count))
aggregate(MyWrangledData$Count, list(MyWrangledData$Species), FUN=mean) 

