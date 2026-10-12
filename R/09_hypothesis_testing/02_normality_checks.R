# Shapiro-Wilk checks for numeric variables
# Note: the test accepts 3 to 5000 non-missing observations. Use diagnostic plots too.

data_file <- "examples/agricultural_example.csv"
dat <- read.csv(data_file, check.names = FALSE)
numeric_cols <- names(dat)[vapply(dat, is.numeric, logical(1))]

normality_results <- lapply(numeric_cols, function(nm) {
  x <- dat[[nm]]
  x <- x[is.finite(x)]
  if (length(x) < 3L || length(x) > 5000L || length(unique(x)) < 2L) {
    return(data.frame(variable = nm, n = length(x), W = NA_real_, p_value = NA_real_,
                      note = "Outside Shapiro-Wilk limits or no variation"))
  }
  test <- shapiro.test(x)
  data.frame(variable = nm, n = length(x), W = unname(test$statistic),
             p_value = test$p.value, note = "Interpret with Q-Q plots and study context")
})
normality_results <- do.call(rbind, normality_results)
print(normality_results)
dir.create("outputs", showWarnings = FALSE)
write.csv(normality_results, "outputs/normality_checks.csv", row.names = FALSE)
