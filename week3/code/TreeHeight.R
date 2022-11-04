# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

MyData <- read.csv("../data/trees.csv")
MyDegrees<-MyData[,2]
MyDistance<-MyData[,3]

TreeHeight <- function(degrees, distance) {
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  print(paste("Tree height is:", height))
  return(height)
}
TreeHeight(MyDegrees, MyDistance)
Tree.Height.m<-TreeHeight(MyDegrees, MyDistance)

MyData2<-data.frame(MyData,Tree.Height.m)
MyData2
write.csv(MyData2, "../results/TreeHts.csv")
