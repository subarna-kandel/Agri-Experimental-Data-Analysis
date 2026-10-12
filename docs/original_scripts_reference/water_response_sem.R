library(ggplot2)
library(dplyr)
library(agricolae)
library(doebioresearch)
library(readxl)
attach(soil_init)
attach(water_anova)
attach(soil_mc)
sem <- function(x) sd(x, na.rm = TRUE) / sqrt(length(na.omit(x)))

sem_results <-water_anova %>%
  group_by(Treatment) %>%
  summarise(sem_results = sem(Fe))  
print(sem_results)
