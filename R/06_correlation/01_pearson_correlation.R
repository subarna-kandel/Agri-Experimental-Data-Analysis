# Pearson correlations among numeric agricultural traits.
source("R/00_setup.R")

data_file <- "examples/agricultural_example.csv"
dat <- read.csv(data_file, stringsAsFactors = FALSE, check.names = FALSE)
numeric_data <- dat[, vapply(dat, is.numeric, logical(1)), drop = FALSE]
numeric_data <- numeric_data[, vapply(numeric_data, function(x) {
  sum(!is.na(x)) > 1 && sd(x, na.rm = TRUE) > 0
}, logical(1)), drop = FALSE]

if (ncol(numeric_data) < 2) {
  stop("At least two numeric, non-constant variables are required.")
}

cor_matrix <- cor(numeric_data, use = "pairwise.complete.obs", method = "pearson")
write.csv(cor_matrix, "outputs/pearson_correlation_matrix.csv")
print(round(cor_matrix, 3))

if (requireNamespace("Hmisc", quietly = TRUE)) {
  result <- Hmisc::rcorr(as.matrix(numeric_data), type = "pearson")
  write.csv(result$r, "outputs/pearson_correlations.csv")
  write.csv(result$P, "outputs/pearson_p_values.csv")

  if (requireNamespace("corrplot", quietly = TRUE)) {
    png("outputs/correlation_plot.png", width = 1600, height = 1200, res = 180)
    corrplot::corrplot(
      result$r, method = "color", type = "upper",
      p.mat = result$P, sig.level = 0.05,
      insig = "blank", addCoef.col = "black", diag = FALSE
    )
    dev.off()
  }
}
