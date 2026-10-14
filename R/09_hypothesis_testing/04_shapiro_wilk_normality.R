# Shapiro-Wilk normality checks for numeric columns in an Excel workbook.
# Update data_file and sheet_name before running.
# Note: Shapiro-Wilk accepts 3 to 5000 non-missing observations.

if (!requireNamespace("readxl", quietly = TRUE)) {
  install.packages("readxl")
}
library(readxl)

data_file <- "data/your_data.xlsx"
sheet_name <- 1

dat <- read_excel(data_file, sheet = sheet_name)
numeric_cols <- names(dat)[vapply(dat, is.numeric, logical(1))]

if (length(numeric_cols) == 0L) {
  stop("No numeric columns found in the input workbook.")
}

results <- lapply(numeric_cols, function(nm) {
  x <- dat[[nm]]
  x <- x[is.finite(x)]

  if (length(x) < 3L || length(x) > 5000L || length(unique(x)) < 2L) {
    return(data.frame(
      variable = nm, n = length(x), W = NA_real_, p_value = NA_real_,
      interpretation = "Not tested: check sample size or variation"
    ))
  }

  test <- shapiro.test(x)
  data.frame(
    variable = nm,
    n = length(x),
    W = unname(test$statistic),
    p_value = test$p.value,
    interpretation = if (test$p.value < 0.05) {
      "Evidence against normality at alpha = 0.05"
    } else {
      "Insufficient evidence against normality at alpha = 0.05"
    }
  )
})

results <- do.call(rbind, results)
print(results)

dir.create("outputs", showWarnings = FALSE, recursive = TRUE)
write.csv(results, "outputs/shapiro_wilk_results.csv", row.names = FALSE)
