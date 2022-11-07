rm(list=ls())
library(ggplot2)
library(maps)

load("../Data/GPDDFiltered.RData")

map(database = "world", fill = TRUE, 
    bg = "white", ylim = c(-80, 100), 
    border = "white",panel.first = grid())


points(x = gpdd$long, y = gpdd$lat, col = "blue")
