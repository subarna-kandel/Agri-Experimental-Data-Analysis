library(ggplot2)

data <- data.frame(
  Treatment = factor(c(rep("Conventional (T3)", 14), rep("Organic (T4)", 13))),
  cp = c(8.5, 8.1875, 7.6875, 7.875, 4.625, 7.5625, 8.625, 10.1875,
         7.9375, 9.5625, 7.875, 6.9375, 7.1875, 8.4375,
         7.8125, 7.8125, 9.1875, 8.6875, 7.25, 5.25, 9.125,
         7.8125, 7.875, 6.9375, 7.125, 6.25, 8.875)
)

ggplot(data, aes(x = Treatment, y = cp)) +
  geom_boxplot(fill = "white", color = "black", 
               width = 0.4,  # Reduced from 0.6 to 0.4
               outlier.size = 1.5) +
  ggtitle("Crop Yield Comparison: Conventional vs Organic Farming") +
  ylab("Crop Yield (cp)") +
  xlab("Farming Method") +
  theme_bw() +
  theme(
    panel.grid.major.x = element_blank(),
    panel.grid.minor.x = element_blank(),
    panel.grid.major.y = element_line(linetype = "dashed"),
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10)
  )

ggsave("yield_comparison.pdf", width = 8, height = 6, dpi = 300)
