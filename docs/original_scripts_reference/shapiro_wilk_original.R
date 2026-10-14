

# Load necessary libraries
library(readxl)

# Set the working directory (optional, but helps locate your file)
setwd("E:/Aayusha/Thesis/Microplastic/Results")

# File path
file_path <- "depth.xlsx"

# Read the Excel file (using the first sheet by default)
data <- read_excel(file_path, sheet = 1)

# Display the first few rows of the data to inspect
print(head(data))

# Display the column names to identify the relevant columns
print(colnames(data))

# Define a function to perform Shapiro-Wilk test on all numeric columns
perform_shapiro_test <- function(data) {
  cat("\n=== Shapiro-Wilk Normality Test Results ===\n")
  
  # Loop through each column in the data
  for (col_name in colnames(data)) {
    # Check if the column is numeric
    if (is.numeric(data[[col_name]])) {
      cat("\nTesting column:", col_name, "\n")
      
      # Perform the Shapiro-Wilk test
      test_result <- shapiro.test(data[[col_name]])
      print(test_result)
      
      # Interpretation of the result
      if (test_result$p.value < 0.05) {
        cat("The data in column", col_name, "does NOT follow a normal distribution (p-value =", test_result$p.value, ").\n")
      } else {
        cat("The data in column", col_name, "follows a normal distribution (p-value =", test_result$p.value, ").\n")
      }
    } else {
      cat("\nSkipping column:", col_name, "- not numeric.\n")
    }
  }
}

# Run the Shapiro-Wilk test on all numeric columns
perform_shapiro_test(data)

