# Multivariate analysis: PCA, hierarchical clustering, k-means, MANOVA,
# canonical correlation, and factor analysis where the data support them.
# Based on the historical multivariate and yearly PCA reference scripts.
source("R/00_setup.R")

data_file <- "examples/agricultural_example.csv"
group_col <- "Treatment"
cluster_count <- 3L

dat <- read_data(data_file)
numeric_names <- numeric_columns(dat)
if (length(numeric_names) < 2L) stop("At least two varying numeric variables are required.")
complete <- complete.cases(dat[, numeric_names, drop = FALSE])
x <- dat[complete, numeric_names, drop = FALSE]
scaled <- scale(x)

pca <- prcomp(x, center = TRUE, scale. = TRUE)
capture.output(summary(pca), file = "outputs/multivariate_pca_summary.txt")
write.csv(pca$rotation, "outputs/multivariate_pca_loadings.csv")
write.csv(as.data.frame(pca$x), "outputs/multivariate_pca_scores.csv")

hc <- hclust(dist(scaled), method = "ward.D2")
png("outputs/hierarchical_clustering.png", width = 1400, height = 1000, res = 160)
plot(hc, main = "Hierarchical clustering", xlab = "", sub = "")
dev.off()

k <- min(cluster_count, nrow(x) - 1L)
if (k >= 2L) {
  set.seed(2026)
  km <- kmeans(scaled, centers = k, nstart = 25)
  write.csv(data.frame(row_id = which(complete), cluster = km$cluster),
            "outputs/kmeans_clusters.csv", row.names = FALSE)
}

if (!is.null(group_col) && group_col %in% names(dat) &&
    length(unique(dat[[group_col]][complete])) >= 2L) {
  groups <- factor(dat[[group_col]][complete])
  if (nrow(x) > length(levels(groups)) && length(numeric_names) >= 2L) {
    fit <- manova(as.matrix(x) ~ groups)
    capture.output(summary(fit), file = "outputs/manova_summary.txt")
  }
}

if (length(numeric_names) >= 4L) {
  cca <- cancor(x[, seq_len(2), drop = FALSE], x[, 3:4, drop = FALSE])
  write.csv(data.frame(canonical_correlation = cca$cor),
            "outputs/canonical_correlations.csv", row.names = FALSE)
  factors <- min(2L, floor(length(numeric_names) / 2L))
  if (nrow(x) > length(numeric_names) && factors >= 1L) {
    fa <- factanal(x, factors = factors, rotation = "varimax")
    capture.output(print(fa), file = "outputs/factor_analysis.txt")
  }
}
