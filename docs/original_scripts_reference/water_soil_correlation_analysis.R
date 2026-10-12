library(readxl)
library(dplyr)
water_adjusted1 <- read_excel("data/water_data.xlsx")
library("ggpubr")
ggscatter(water_adjusted1, x = "pH", y = "soilpH", rm.na=TRUE,
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Groundwater pH", ylab = "Soil pH")

library(readxl)
library(ggpubr)

# Read your data
water_adjusted1 <- read_excel("data/water_data.xlsx")

# Scatter plot with regression line, confidence interval, and points colored by Treatment
ggscatter(water_adjusted1, x = "pH", y = "soilpH", 
          add = "reg.line", conf.int = TRUE,
          color = "Treatment",  # this sets color grouping
          palette = c("forestgreen", "firebrick", "goldenrod"),  # custom colors for T1, T3, T4
          xlab = "Groundwater pH", ylab = "Soil pH",
          legend = "right") +
  theme_minimal()

library(readxl)
library(ggpubr)

# Read your data
water_adjusted1 <- read_excel("data/water_data.xlsx")

# Scatter plot with single regression line, points colored by Treatment
ggscatter(water_adjusted1, x = "pH", y = "soilpH", 
          add = "reg.line", conf.int = TRUE,
          color = "Treatment",  # color points by Treatment
          palette = c("T1" = "forestgreen", "T3" = "firebrick", "T4" = "goldenrod"),
          xlab = "Groundwater pH", ylab = "Soil pH",
          legend = "right")
library(readxl)
library(ggpubr)

# Read your data
water_adjusted1 <- read_excel("data/water_data.xlsx")

# Scatter plot with single regression line, points colored by Treatment
ggscatter(water_adjusted1, x = "pH", y = "soilpH", 
          add = "reg.line", conf.int = TRUE,
          color = "Treatment",  # color points by Treatment
          palette = c("T1" = "forestgreen", "T3" = "firebrick", "T4" = "goldenrod"),
          xlab = "Groundwater pH", ylab = "Soil pH",
          legend = "right")



# Load necessary libraries
library(ggpubr)
library(readxl)
library(dplyr)

# Read data
water_adjusted1 <- read_excel("data/water_data.xlsx")

# Convert Treatment codes to descriptive labels
water_adjusted1 <- water_adjusted1 %>%
  mutate(
    Treatment = case_when(
      Treatment == "T1" ~ "Forest",
      Treatment == "T3" ~ "Conventional Farms",
      Treatment == "T4" ~ "Organic Farms"
    )
  )

# Create scatter plot
ggscatter(
  data = water_adjusted1, 
  x = "pH", 
  y = "soilpH",
  color = "Treatment",                   # Color points by Treatment
  palette = c("Forest" = "#1B9E77",      # Custom color palette
              "Conventional Farms" = "#D95F02", 
              "Organic Farms" = "#7570B3"),
  size = 3,                              # Adjust point size if needed
  alpha = 0.8,                           # Adjust transparency if needed
  add = "none",                          # Do not add default regression
  conf.int = FALSE,                      # No default confidence interval
  cor.coef = FALSE,                      # Remove correlation coefficient
  xlab = "Groundwater pH", 
  ylab = "Soil pH"
) +
  # Add single regression line for all data
  geom_smooth(
    method = "lm", 
    color = "black",      # Line color
    se = TRUE,            # Show confidence interval
    fill = "gray",        # Confidence interval fill color
    alpha = 0.2           # Confidence interval transparency
  )
cor_m <- cor(water_adjusted1, method = "spearman")
# Select only numeric columns
water_numeric <- water_adjusted1[, sapply(water_adjusted1, is.numeric)]

# Compute correlation matrix
cor_matrix <- cor(water_numeric, method = "spearman", use = "complete.obs")
print(cor_matrix)

attach("water_adjusted")
T3_waternsoil <- water_adjusted %>%
  filter(Treatment %in% c("T3"))
attach(T3_waternsoil)
attach(water_adjusted1)
cor <- cor.test(pH,soilph, method = "pearson")
print(cor)
plot(cor)
plot(pH,soilph)
library("ggpubr")
ggscatter(water_adjusted1, x = "pH", y = "soilph", rm.na=TRUE,
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Groundwater pH", ylab = "Soil pH")

t_test <- t.test(Nitrate ~ Treatment, data = water_adjusted)
print(t_test)
plot(Phosphate, Nitrate)

library(ggpubr)
library(dplyr)

# Exclude rows where Phosphate = 0
water_adjusted1_filtered <- water_adjusted1 %>%
  filter(Phosphate != 0) %>% filter('Lab ID'==19)

# Create scatter plot
ggscatter(water_adjusted1_filtered, x = "p", y = "Phosphate", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Groundwater pH", ylab = "Soil pH")








t_test <- t.test(Nitrate ~ Treatment, data = water_adjusted)
t_test
