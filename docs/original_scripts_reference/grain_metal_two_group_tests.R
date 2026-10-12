

library(readxl)

grainm_init <- read_xlsx("data/grain_metal_data.xlsx")

#grainn_init <- read_xls("data/water_data.xlsx")
head(grainm_init)
library(dplyr)
grainn_initial_analysis <- grainn_init %>%
  filter(Treatment %in% c("T4", "T3"))





attach(grainm_init)
t_test <- t.test(fe ~ Treatment, data = grainm_init)
print(t_test)

sem <- function(x) sd(x, na.rm = TRUE) / sqrt(length(na.omit(x)))

sem_results <-grainm_init %>%
  group_by(Treatment) %>%
  summarise(sem_results = sem(Mn))  
print(sem_results)
