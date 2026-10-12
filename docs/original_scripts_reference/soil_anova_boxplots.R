library(doebioresearch)
library(agricolae)
library(dplyr)
library(readxl)
library(ggplot2)

soil_init <- read_excel("data/soil_data.xlsx")
anova <- aov(K~Treatment, data=soil_init)
summary(anova)
hsd <- HSD.test(anova, "Treatment", console = TRUE)
sem <- function(x) sd(x, na.rm = TRUE) / sqrt(length(na.omit(x)))

sem_results <-soil_init %>%
  group_by(Treatment) %>%
  summarise(sem_results = sem(Po))  
print(sem_results)

soil_mc <- read_excel("data/soil_physical_properties.xlsx")
attach(soil_mc)
head(soil_mc)
anova <- aov(MC~Treatment, data=soil_mc)
summary(anova)
hsd <- HSD.test(anova, "Treatment", console = TRUE)



# Load necessary library
library(ggplot2)

# Rename Treatment levels
soil_init$Treatment <- factor(soil_init$Treatment, 
                              levels = c("T1", "T3", "T4"), 
                              labels = c("Forest", "Conventional Farming", "Organic Farming"))

# Create a box-and-whisker plot
ggplot(soil_init, aes(x = Treatment, y = pH, fill = Treatment)) +
  geom_boxplot(outlier.colour = "red", outlier.shape = 16, outlier.size = 3) +  # Highlight outliers
  theme_minimal() +  # Apply a clean theme
  labs(title = "Soil pH Levels by Treatment",
       x = "Treatment",
       y = "Soil pH") +
  scale_fill_brewer(palette = "Set2") +  # Use a color palette
  theme(axis.text.x = element_text(angle = 30, hjust = 1))  # Rotate labels for clarity
