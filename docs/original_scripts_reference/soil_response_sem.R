library(doebioresearch)
library(agricolae)
library(dplyr)
library(readxl)
library(ggplot2)

soil_m <- read_excel("data/soil_measurements.xlsx")
attach(soil_m)
head(soil_m)
anova <- aov(mbc~trt, data=soil_m)
summary(anova)
hsd <- HSD.test(anova, "trt", console = TRUE)
sem <- function(x) sd(x, na.rm = TRUE) / sqrt(length(na.omit(x)))

sem_results <-soil_m %>%
  group_by(trt) %>%
  summarise(sem_results = sem(mbc))  
print(sem_results)
