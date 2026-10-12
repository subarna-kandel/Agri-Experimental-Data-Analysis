#water t test


library(readxl)

grainn_init <- read_xlsx("data/grain_data.xlsx")

#grainn_init <- read_xls("data/water_data.xlsx")
head(grainn_init)
library(dplyr)
grainn_initial_analysis <- grainn_init %>%
  filter(Treatment %in% c("T4", "T3"))





attach(grainn_initial_analysis)
t_test <- t.test(cp ~ Treatment, data = grainn_initial_analysis)
print(t_test)
sem <- function(x) sd(x, na.rm = TRUE) / sqrt(length(na.omit(x)))

sem_results <-grainn_initial_analysis %>%
  group_by(Treatment) %>%
  summarise(sem_results = sem(cp))  
print(sem_results)

shapiro.test(grainn_initial_analysis$`Nitrogen (%)`)


# Perform the Mann-Whitney U test with approximate p-value
mann_whitney_result <- wilcox.test(`Nitrogen (%)` ~ Treatment, data = grainn_initial_analysis, exact = FALSE)

# View the result
mann_whitney_result


# Define the column range
# Define the column range excluding specific variables
excluded_vars <- c("Soil_ref","TDS", "Fe", "Mn", "Pb", "Cr", "Ammonia")
columns_to_test <- setdiff(names(grainn_initial_analysis)[4:22], excluded_vars)


# Loop through selected columns
for (col in columns_to_test) {
  cat("\nAnalyzing variable:", col, "\n")
  
  # Perform t-test
  t_test <- t.test(grainn_initial_analysis[[col]] ~ grainn_initial_analysis$Treatment)
  print(t_test)
  
  # Perform Shapiro-Wilk test for normality
  shapiro_result <- shapiro.test(grainn_initial_analysis[[col]])
  print(shapiro_result)
  
  # Perform Mann-Whitney U test (Wilcoxon rank-sum test)
  mann_whitney_result <- wilcox.test(grainn_initial_analysis[[col]] ~ grainn_initial_analysis$Treatment, exact = FALSE)
  print(mann_whitney_result)
}
