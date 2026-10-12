
# Load necessary libraries
library(stats)

# Load necessary libraries
library(readxl)

# Load data from Excel file
data_main <- read_excel("data/soil_data.xlsx")
attach(data_main)
str(data_main)
head(data_main)

as.factor(Treatment)
as.factor(Sample No)

# Fit a linear model


linear_model  <- lm(y ~ x, data = data)

# Print the summary of the linear model
summary(linear_model)

# Perform ANOVA on the linear model
anova_result <- anova(linear_model)

# Print the ANOVA result
print(anova_result)


#prinicpal component analysis
pca <- prcomp(data, scale = TRUE)
summary(pca)
plot(pca, type = "l")
biplot(pca)


#soil quality index
# Load necessary libraries
library(dplyr)
library(SQI)

# Load data from Excel file
data <- read_excel("data/soil_data.xlsx")
attach(data)
str(data)

# Calculate Soil Quality Index
