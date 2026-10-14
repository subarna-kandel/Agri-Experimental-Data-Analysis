#install.packages("doebioresearch", "dplyr")
library(doebioresearch)
library(dplyr)
eliza <- read.csv("C:/Users/kande/Downloads/Azotobacter.csv")


attach(eliza)

#analysis
Analysed <-  rcbd(eliza[3:16], trt, rep, 2)
print(Analysed)

sink("eliza.txt")
print(Analysed)
sink()
