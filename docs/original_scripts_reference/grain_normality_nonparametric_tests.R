library(readxl)

grain_init <- read_xlsx("data/grain_zinc_data.xlsx")




data <- grain_init
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

mann_whitney_result <- wilcox.test(data$Zn ~ data$Treatment, exact = FALSE)
print(mann_whitney_result)
t_test <- t.test(data$Zn ~ data$Treatment, exact = FALSE)
t_test
