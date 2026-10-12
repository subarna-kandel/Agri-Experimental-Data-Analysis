#water t test
library(readxl)

water_init <- read_xlsx("data/water_data.xlsx")

#water_init <- read_xls("data/water_data.xlsx")
head(water_init)
 library(dplyr)
water_initial_analysis <- water_init %>%
  filter(Treatment %in% c("T4", "T3"))



#head(water)
library(writexl)
write_xlsx(water_initial_analysis, "outputs/water_analysis.xlsx")

attach(water_initial_analysis)
t_test <- t.test(Phosphate ~ Treatment, data = water_initial_analysis)
print(t_test)

shapiro.test(water_initial_analysis$Nitrate)


# Perform the Mann-Whitney U test with approximate p-value
mann_whitney_result <- wilcox.test(Tot_Hard ~ Treatment, data = water_initial_analysis, exact = FALSE)

# View the result
mann_whitney_result


# Define the column range
# Define the column range excluding specific variables
excluded_vars <- c("Soil_ref","TDS", "Fe", "Mn", "Pb", "Cr", "Ammonia")
columns_to_test <- setdiff(names(water_initial_analysis)[4:22], excluded_vars)


# Loop through selected columns
for (col in columns_to_test) {
  cat("\nAnalyzing variable:", col, "\n")
  
  # Perform t-test
  t_test <- t.test(water_initial_analysis[[col]] ~ water_initial_analysis$Treatment)
  print(t_test)
  
  # Perform Shapiro-Wilk test for normality
  shapiro_result <- shapiro.test(water_initial_analysis[[col]])
  print(shapiro_result)
  
  # Perform Mann-Whitney U test (Wilcoxon rank-sum test)
  mann_whitney_result <- wilcox.test(water_initial_analysis[[col]] ~ water_initial_analysis$Treatment, exact = FALSE)
  print(mann_whitney_result)
}


water_adjusted <- read_excel("outputs/water_analysis.xlsx")
head(water_adjusted)
attach(water_adjusted)
t_test <- t.test(Tot_Hard ~ Treatment, data = water_initial_analysis)
print(t_test)
