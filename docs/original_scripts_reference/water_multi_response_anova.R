library(doebioresearch)
library(agricolae)
library(dplyr)
library(readxl)
library(ggplot2)

water_anova <- read_excel("data/water_data.xlsx")
attach(water_anova)
head(water_anova)
# Define the column range excluding specific variables
excluded_vars <- c("Soil_ref","TDS", "Pb", "Cr", "Ammonia")
columns_to_test <- setdiff(names(water_anova)[4:22], excluded_vars)


# Loop through selected columns
for (col in columns_to_test) {
  cat("\nAnalyzing variable:", col, "\n")
  %>% 
  # Perform t-test
 anova <- aov(water_anova[[col]] ~ water_anova$Treatment)
 summary(anova)
 print(summary(anova))
 #tukeys cramer test
 
 hsd <- HSD.test(anova, "water_anova$Treatment", console = TRUE)
 
}




head(water_anova)
anova <- aov(Chlorine~Treatment, data=water_anova)
summary(anova)
hsd <- HSD.test(anova, "Treatment", console = TRUE)

soil_mc <- read_excel("data/soil_physical_properties.xlsx")
attach(soil_mc)
head(soil_mc)

anova <- aov(mc~Treatment, data=soil_mc)
summary(anova)
hsd <- HSD.test(anova, "Treatment", console = TRUE)

sem <- function(x) sd(x, na.rm = TRUE) / sqrt(length(na.omit(x)))

sem_results <-water_anova %>%
  group_by(Treatment) %>%
  summarise(sem_results = sem(Tot_Hard ))  
print(sem_results)
