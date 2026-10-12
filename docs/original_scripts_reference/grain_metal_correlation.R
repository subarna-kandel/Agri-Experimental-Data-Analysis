library(readxl)
library(dplyr)
library("ggpubr")
graincor <- read_excel("data/grain_metal_data.xlsx")

grain_numeric <- graincor[, sapply(graincor, is.numeric)]

# Compute correlation matrix
cor_matrix <- cor(grain_numeric, method = "spearman", use = "complete.obs")
print(cor_matrix)

# Create scatter plot
ggscatter(graincor, x = "Cu", y = "cu_a", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "spearman",
          xlab = "Grain Copper", ylab = "Soil Total Copper")
