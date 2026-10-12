# Load required packages
library(stats)
library(MASS)
library(ggplot2)
library(factoextra)

# Example data (replace with your own dataset)
# Creating sample data
set.seed(123)
n <- 100
data <- data.frame(
    var1 = rnorm(n),
    var2 = rnorm(n),
    var3 = rnorm(n),
    var4 = rnorm(n)
)

# 1. Principal Component Analysis (PCA)
pca_result <- prcomp(data, scale. = TRUE)
summary(pca_result)

# Visualize PCA results
fviz_pca_biplot(pca_result)

# 2. Correlation Analysis
correlation_matrix <- cor(data)
print("Correlation Matrix:")
print(correlation_matrix)

# Visualize correlation matrix
heatmap(correlation_matrix)

# 3. Cluster Analysis
# Hierarchical clustering
dist_matrix <- dist(scale(data))
hc <- hclust(dist_matrix, method = "ward.D2")
plot(hc, main = "Hierarchical Clustering Dendrogram", hang = -1)

# K-means clustering
k <- 3  # number of clusters
kmeans_result <- kmeans(scale(data), centers = k)
fviz_cluster(kmeans_result, data = data)

# 4. MANOVA (if you have grouping variables)
# Example grouping variable
data$group <- factor(sample(c("A", "B", "C"), n, replace = TRUE))
manova_result <- manova(cbind(var1, var2, var3, var4) ~ group, data = data)
summary(manova_result)

# 5. Canonical Correlation Analysis (if you have two sets of variables)
set1 <- data[, c("var1", "var2")]
set2 <- data[, c("var3", "var4")]
cca_result <- cancor(set1, set2)
print("Canonical Correlations:")
print(cca_result$cor)

# 6. Factor Analysis
fa_result <- factanal(data[,1:4], factors = 2, rotation = "varimax")
print("Factor Analysis Results:")
print(fa_result)
