library(ggplot2)

# Data
data <- data.frame(
  Treatment = c(rep("T3", 14), rep("T4", 13)),
  cp = c(
    8.5,8.1875,7.6875,7.875,4.625,7.5625,8.625,10.1875,7.9375,9.5625,7.875,6.9375,7.1875,8.4375,
    7.8125,7.8125,9.1875,8.6875,7.25,5.25,9.125,7.8125,7.875,6.9375,7.125,6.25,8.875
  )
)

# Rename treatment labels
data$Farming_System <- factor(data$Treatment, levels = c("T3", "T4"),
                              labels = c("Conventional Farming", "Organic Farming"))

# Plot
ggplot(data, aes(x=Farming_System, y=cp)) +
  geom_boxplot(color="black", fill=NA, size=1) +
  geom_jitter(width=0.1, size=2, color="black") +
  labs(x="Farming System", y="Crude Protein Content (%)",
       title="Crude Protein Content under Different Farming Systems") +
  theme_minimal(base_size = 14) +
  theme(panel.grid = element_blank(),
        panel.border = element_rect(color="black", fill=NA, size=1),
        plot.title = element_text(hjust=0.5))
