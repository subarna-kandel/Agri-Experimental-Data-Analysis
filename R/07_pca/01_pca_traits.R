# Principal Component Analysis for numeric agricultural traits.
# Keep genotype/treatment identifiers as labels, not numeric measurements.
source("R/00_setup.R")

data_file <- "examples/agricultural_example.csv"
dat <- read.csv(data_file, stringsAsFactors = FALSE, check.names = FALSE)
label_column <- "Genotype"
check_columns(dat, label_column)

numeric_data <- dat[, vapply(dat, is.numeric, logical(1)), drop = FALSE]
numeric_data <- numeric_data[, vapply(numeric_data, function(x) {
  sum(!is.na(x)) > 1 && sd(x, na.rm = TRUE) > 0
}, logical(1)), drop = FALSE]

if (ncol(numeric_data) < 2) stop("PCA requires at least two numeric, non-constant traits.")

complete_rows <- complete.cases(numeric_data)
numeric_data <- numeric_data[complete_rows, , drop = FALSE]
labels <- dat[[label_column]][complete_rows]

if (nrow(numeric_data) < 3) stop("PCA needs at least three complete observations.")

pca <- prcomp(numeric_data, center = TRUE, scale. = TRUE)
capture.output(summary(pca), file = "outputs/pca_summary.txt")
write.csv(pca$rotation, "outputs/pca_variable_loadings.csv")
scores <- as.data.frame(pca$x)
scores[[label_column]] <- labels
write.csv(scores, "outputs/pca_observation_scores.csv", row.names = FALSE)

if (requireNamespace("factoextra", quietly = TRUE)) {
  p1 <- factoextra::fviz_eig(pca)
  p2 <- factoextra::fviz_pca_ind(pca, repel = TRUE)
  p3 <- factoextra::fviz_pca_var(pca, repel = TRUE)
  p4 <- factoextra::fviz_pca_biplot(pca, repel = TRUE)
  ggplot2::ggsave("outputs/pca_scree_plot.png", p1, width = 7, height = 5, dpi = 300)
  ggplot2::ggsave("outputs/pca_individuals.png", p2, width = 7, height = 5, dpi = 300)
  ggplot2::ggsave("outputs/pca_variables.png", p3, width = 7, height = 5, dpi = 300)
  ggplot2::ggsave("outputs/pca_biplot.png", p4, width = 8, height = 6, dpi = 300)
}
