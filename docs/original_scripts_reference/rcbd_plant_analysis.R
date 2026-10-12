library(doebioresearch)
library(agricolae)
library(dplyr)
library(ggplot2)
library(readxl)
library(ggpubr)
library(dplyr)


#read and load data
data <-read_xlsx("data/plant_analysis.xlsx") 


head(data)

#attach the data
attach(data)


#analysis rcbd

analys<- rcbd(data[3:6],Treatment,Replication,2)
analys

sink("analysis12.txt")
print(analys)
sink()


cor.test("", "Plant N"  method = "pearson")
