library(ggplot2)
library(dplyr)

# Create corrected data structure
data_all <- data.frame(
  District = c(rep("RegionB", 20), rep("RegionA", 20), rep("RegionC", 20)),
  Group = rep(rep(c("M", "N"), each = 10), 3),  # Properly structured grouping
  Category = rep("D2", 60),
  Value = c(
    # RegionB values (M first 10, N next 10)
    9,6,18,8,8,4,10,7,22,2,20,5,6,16,4,7,7,4,3,2,
    # RegionA values
    11,15,17,20,8,9,16,15,32,9,14,14,14,24,18,22,11,25,20,12,
    # RegionC values
    22,28,11,25,34,32,29,14,16,16,21,17,9,15,12,16,23,9,15,6
  )
)

# Calculate summary statistics
summary_data <- data_all %>%
  group_by(District, Group) %>%
  summarise(
    Mean_Value = mean(Value),
    SD = sd(Value),
    SE = SD / sqrt(n()),
    .groups = 'drop'
  ) %>%
  mutate(District = factor(District, 
                           levels = c("RegionB", "RegionA", "RegionC")))

# Create visualization
ggplot(summary_data, aes(x = District, y = Mean_Value, fill = Group)) +
  geom_col(position = position_dodge(0.8), width = 0.7, color = "black") +
  geom_errorbar(aes(ymin = Mean_Value - SE, ymax = Mean_Value + SE),
                position = position_dodge(0.8), width = 0.2) +
  geom_text(aes(label = round(Mean_Value, 1)), 
            position = position_dodge(0.8), vjust = -3) +
  scale_fill_manual(values = c("M" = "#1f77b4", "N" = "#ff7f0e")) +
  labs(title = "Mean Value Comparison Across Districts",
       subtitle = "Error bars represent standard error",
       x = "District",
       y = "Mean Value") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5),
        legend.position = "top")
