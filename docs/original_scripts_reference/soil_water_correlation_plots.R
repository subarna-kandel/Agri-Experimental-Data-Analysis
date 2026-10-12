# Define the data vectors
Soil_pH <- c(4.90,5.36,5.65,5.01,5.69,5.71,5.43,4.97,5.78,5.25,7.16,5.46,5.85,4.92,5.48,5.41,5.12,6.11,4.79,5.46,7.42,5.58,5.87,6.56,6.88,7.37,6.60,7.02,7.35,7.06,7.44,6.44,6.05,7.54,7.13,8.68,7.61,7.92,7.82,7.04,4.95,6.54,6.73,6.52,7.13,6.63,5.47,4.92,6.87,6.85,6.84,6.39,5.65,4.63,7.22,6.79,7.06,7.13,7.62,6.83,4.85,5.03,6.07,4.88,5.25,5.51,5.57,5.32,5.55,5.21,7.60,5.42,6.12,5.24,5.76,5.34,5.09,6.08,5.15,5.30,6.70,5.56,5.97,7.07,6.62,7.26,7.09,6.95,7.22,6.95,7.67,6.16,6.29,7.75,6.72,8.70,7.36,7.97,7.95,6.57,4.96,5.98,6.76,6.15,7.05,6.29,5.45,4.77,7.09,7.01,7.03,6.55,6.07,6.72,5.96,7.08,7.1,7.34,7.31,6.93)
MC <- c(10,13,2,18,21,4,11,8,6,6,36,7,4,8,6,8,10,19,4,9,48,23,13,19,12,9,17,8,23,28,16,10,17,18,19,9,9,16,18,8,25,25,21,19,45,36,24,27,15,27,14,12,20,25,13,15,24,10,36,10,9,6,18,8,8,4,10,7,22,2,20,5,6,16,4,7,7,4,3,2,11,15,17,20,8,9,16,15,32,9,14,14,14,24,18,22,11,25,20,12,22,28,11,25,34,32,29,14,16,16,21,17,9,15,12,16,23,9,15,6)

# Create data frame
df <- data.frame(Soil_pH, MC)

# Calculate correlation and p-value
cor_test <- cor.test(df$Soil_pH, df$MC)
correlation <- cor_test$estimate
p_value <- cor_test$p.value

# Base R scatterplot (no regression line)
plot(MC ~ Soil_pH, data = df,
     xlab = "Soil pH", 
     ylab = "Microplastic Count",
     pch = 19, col = "black", cex = 0.8)

# Add correlation and p-value text slightly below max
text(min(df$Soil_pH), max(df$MC) - 5,
     labels = paste0("r = ", round(correlation, 2), "\n",
                     "p = ", format.pval(p_value, digits = 2)),
     pos = 4, col = "red", cex = 1)

# ggplot2 version (no regression line, no gridlines)
library(ggplot2)

ggplot(df, aes(x = Soil_pH, y = MC)) +
  geom_point(color = "black", alpha = 0.7, size = 2) +
  labs(x = "Soil pH", 
       y = "Microplastic Count") +
  annotate("text", x = min(df$Soil_pH), y = max(df$MC) - 5,
           label = paste0("r = ", round(correlation, 2), 
                          "\n", "p = ", format.pval(p_value, digits = 2)),
           hjust = 0, vjust = 1, color = "red", size = 4.5) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    panel.grid.major = element_blank(),  # remove major gridlines
    panel.grid.minor = element_blank()   # remove minor gridlines
  )
