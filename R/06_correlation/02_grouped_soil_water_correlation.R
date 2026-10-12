# Correlation analysis for soil, groundwater, grain, or treatment groups.
# This replaces repeated historical water and soil correlation scripts.
source("R/00_setup.R")

data_file <- "examples/agricultural_example.csv"
group_col <- "Treatment"       # Set to NULL for one overall analysis.
x_col <- "PlantHeight"
y_col <- "Yield"
method <- "spearman"           # "pearson", "spearman", or "kendall"

dat <- read_data(data_file)
check_columns(dat, c(x_col, y_col))
if (!is.null(group_col)) {
  check_columns(dat, group_col)
  dat[[group_col]] <- factor(dat[[group_col]])
}

run_pair <- function(d, label) {
  d <- d[complete.cases(d[, c(x_col, y_col), drop = FALSE]), , drop = FALSE]
  if (nrow(d) < 3L) {
    return(data.frame(group = label, n = nrow(d), estimate = NA_real_,
                      p_value = NA_real_, note = "At least three complete pairs required"))
  }
  test <- cor.test(d[[x_col]], d[[y_col]], method = method, exact = FALSE)
  data.frame(group = label, n = nrow(d), estimate = unname(test$estimate),
             p_value = test$p.value, note = NA_character_)
}

if (is.null(group_col)) {
  results <- run_pair(dat, "All observations")
} else {
  results <- do.call(rbind, lapply(levels(droplevels(dat[[group_col]])), function(g) {
    run_pair(dat[dat[[group_col]] == g, , drop = FALSE], g)
  }))
  results <- rbind(results, run_pair(dat, "All observations"))
}

print(results)
write.csv(results, "outputs/grouped_correlation_results.csv", row.names = FALSE)

pair <- dat[complete.cases(dat[, c(x_col, y_col), drop = FALSE]), , drop = FALSE]
if (nrow(pair) >= 3L) {
  library(ggplot2)
  mapping <- aes(x = .data[[x_col]], y = .data[[y_col]])
  if (!is.null(group_col)) mapping <- aes(x = .data[[x_col]], y = .data[[y_col]],
                                           colour = .data[[group_col]])
  p <- ggplot(pair, mapping) +
    geom_point(alpha = 0.8) +
    geom_smooth(method = "lm", se = TRUE, formula = y ~ x,
                inherit.aes = is.null(group_col)) +
    theme_minimal() +
    labs(title = paste(method, "correlation:", x_col, "and", y_col),
         x = x_col, y = y_col, colour = group_col)
  print(p)
  ggsave("outputs/grouped_correlation.png", p, width = 7, height = 5, dpi = 300)
}
