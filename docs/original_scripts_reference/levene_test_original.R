# Load the necessary libraries
if (!require(car)) install.packages("car")
if (!require(readxl)) install.packages("readxl")

library(car)
library(readxl)

# Define the file path and read the Excel file
file_path <- "E:/Aayusha/Thesis/Microplastic/Results/whisker plot - Copy.xlsx"
data <- read_excel(file_path, sheet = "Sheet")

# Extract the relevant columns and remove NA values
plastic_mulched <- na.omit(data$`Plastic mulched soil`)
non_mulched <- na.omit(data$`Non-mulched soil`)
forest_soil <- na.omit(data$`Forest soil`)

# Combine the data into a long format
group <- c(rep("Plastic Mulched Soil", length(plastic_mulched)),
           rep("Non-Mulched Soil", length(non_mulched)),
           rep("Forest Soil", length(forest_soil)))

values <- c(plastic_mulched, non_mulched, forest_soil)

# Perform Levene's test for equality of variances
levene_test <- leveneTest(values ~ group)
print(levene_test)

