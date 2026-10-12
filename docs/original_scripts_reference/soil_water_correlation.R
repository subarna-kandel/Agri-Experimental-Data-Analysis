library(readxl)
library(dplyr)
library("ggpubr")
water_adjusted1 <- read_excel("data/water_data.xlsx")

water_numeric <- water_adjusted1[, sapply(water_adjusted1, is.numeric)]

# Compute correlation matrix
cor_matrix <- cor(water_numeric, method = "spearman", use = "complete.obs")
print(cor_matrix)

# Create scatter plot
ggscatter(water_adjusted1, x = "Zn", y = "zn_a", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "spearman",
          xlab = "Groundwater Zinc", ylab = "Soil Total Copper")
