library(ggplot2)

data <- data.frame(
  Treatment = factor(c(rep("Conventional Farming", 14), rep("Organic Farming", 13))),
  cp = c(8.5, 8.1875, 7.6875, 7.875, 4.625, 7.5625, 8.625, 10.1875,
         7.9375, 9.5625, 7.875, 6.9375, 7.1875, 8.4375,
         7.8125, 7.8125, 9.1875, 8.6875, 7.25, 5.25, 9.125,
         7.8125, 7.875, 6.9375, 7.125, 6.25, 8.875)
)

ggplot(data, aes(x = Treatment, y = cp)) +
  geom_boxplot(fill = "white", color = "black", 
               width = 0.4, outlier.size = 1.5) +
  ggtitle("Crude Protein Content in Conventional and Organic Farming") +
  ylab("Crude Protein (%)") +
  xlab("Farming System") +
  theme_bw() +
  theme(
    panel.grid = element_blank(),  # Removes all grid lines
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10),
    panel.border = element_rect(colour = "black", fill=NA, linewidth=0.5)
  )

ggsave("yield_comparison.pdf", width = 8, height = 6, dpi = 300)
