# Correlation analysis for soil, groundwater, grain, or other numeric variables
# Correlation indicates association, not causation.

library(ggplot2)

data_file <- "examples/agricultural_example.csv"
x_col <- "PlantHeight"
y_col <- "GrainYield"
method <- "spearman" # "pearson" or "kendall" are also supported

dat <- read.csv(data_file, check.names = FALSE)
required <- c(x_col, y_col)
if (!all(required %in% names(dat))) stop("Missing column(s): ", paste(setdiff(required, names(dat)), collapse = ", "))
if (!all(vapply(dat[required], is.numeric, logical(1)))) stop("Selected columns must be numeric.")

numeric_dat <- dat[, vapply(dat, is.numeric, logical(1)), drop = FALSE]
cor_matrix <- cor(numeric_dat, method = method, use = "pairwise.complete.obs")
print(cor_matrix)

pair <- dat[complete.cases(dat[, required]), required, drop = FALSE]
if (nrow(pair) < 3L) stop("At least three complete pairs are required.")
cor_test <- cor.test(pair[[x_col]], pair[[y_col]], method = method, exact = FALSE)
print(cor_test)

p <- ggplot(pair, aes(x = .data[[x_col]], y = .data[[y_col]])) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE, formula = y ~ x) +
  theme_minimal() +
  labs(title = paste(method, "correlation:", x_col, "and", y_col),
       x = x_col, y = y_col, caption = "Trend line is descriptive; correlation method is specified separately.")
print(p)
dir.create("outputs", showWarnings = FALSE)
write.csv(cor_matrix, "outputs/correlation_matrix.csv")
ggsave("outputs/correlation_scatterplot.png", p, width = 7, height = 5, dpi = 300)
