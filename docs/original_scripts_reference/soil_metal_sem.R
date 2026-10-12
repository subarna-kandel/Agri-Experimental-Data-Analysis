library(doebioresearch)
library(agricolae)
library(dplyr)
library(readxl)
library(ggplot2)

soil_m <- read_excel("data/soil_metal_data.xlsx")
attach(soil_m)
head(soil_m)
anova <- aov(fe_a~trt, data=soil_m)
summary(anova)
hsd <- HSD.test(anova, "trt", console = TRUE)
sem <- function(x) sd(x, na.rm = TRUE) / sqrt(length(na.omit(x)))

sem_results <-soil_m %>%
  group_by(trt) %>%
  summarise(sem_results = sem(fe_a))  
print(sem_results)
