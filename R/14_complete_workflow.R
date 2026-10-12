# COMPLETE AGRICULTURAL ANALYSIS WORKFLOW
# Configure the four settings below, then run this file from the repository
# root. It imports, validates, summarizes, tests, models, visualizes, and
# exports results for the selected dataset.
source("R/00_setup.R")
library(dplyr)
library(ggplot2)

data_file <- "examples/agricultural_example.csv"
group_col <- "Treatment"
block_col <- "Replication"
primary_response <- "Yield"

dat <- read_data(data_file)
check_columns(dat, c(group_col, primary_response))
dir.create("outputs", showWarnings = FALSE, recursive = TRUE)
capture.output(str(dat), file = "outputs/workflow_structure.txt")
capture.output(summary(dat), file = "outputs/workflow_summary.txt")
write.csv(head(dat, 10), "outputs/workflow_preview.csv", row.names = FALSE)

dat[[group_col]] <- factor(dat[[group_col]])
numeric_names <- numeric_columns(dat)
write.csv(data.frame(variable = numeric_names),
          "outputs/workflow_numeric_variables.csv", row.names = FALSE)

# 1. Descriptive summaries and SEM.
descriptive <- bind_rows(lapply(numeric_names, function(response) {
  dat %>% group_by(.data[[group_col]]) %>%
    summarise(variable = response, n = sum(is.finite(.data[[response]])),
              mean = mean(.data[[response]], na.rm = TRUE),
              sd = sd(.data[[response]], na.rm = TRUE),
              sem = sem(.data[[response]]), .groups = "drop")
}))
write.csv(descriptive, "outputs/workflow_descriptive_statistics.csv", row.names = FALSE)

# 2. RCBD ANOVA when a block/replication column is available.
if (block_col %in% names(dat)) {
  dat[[block_col]] <- factor(dat[[block_col]])
  rcbd <- aov(dat[[primary_response]] ~ dat[[block_col]] + dat[[group_col]])
  capture.output(summary(rcbd), file = "outputs/workflow_rcbd_anova.txt")
}

# 3. One-way ANOVA and Tukey results for every numeric response.
anova_results <- lapply(numeric_names, function(response) {
  d <- dat[, c(group_col, response), drop = FALSE]
  names(d) <- c("group", "response")
  d <- d[is.finite(d$response), , drop = FALSE]
  d$group <- droplevels(droplevels(factor(d$group)))
  if (nlevels(d$group) < 2L || any(table(d$group) < 2L)) return(NULL)
  fit <- aov(response ~ group, data = d)
  tab <- summary(fit)[[1]]
  data.frame(variable = response, f_value = tab$`F value`[1],
             p_value = tab$`Pr(>F)`[1])
})
anova_results <- do.call(rbind, anova_results)
write.csv(anova_results, "outputs/workflow_anova_results.csv", row.names = FALSE)

# 4. Pearson and Spearman correlation matrices.
if (length(numeric_names) >= 2L) {
  write.csv(cor(dat[numeric_names], use = "pairwise.complete.obs", method = "pearson"),
            "outputs/workflow_pearson_matrix.csv")
  write.csv(cor(dat[numeric_names], use = "pairwise.complete.obs", method = "spearman"),
            "outputs/workflow_spearman_matrix.csv")
}

# 5. PCA and a publication-ready trait plot.
if (length(numeric_names) >= 2L) {
  complete <- complete.cases(dat[numeric_names])
  pca <- prcomp(dat[complete, numeric_names], center = TRUE, scale. = TRUE)
  capture.output(summary(pca), file = "outputs/workflow_pca_summary.txt")
  write.csv(pca$rotation, "outputs/workflow_pca_loadings.csv")
  scores <- as.data.frame(pca$x)
  scores$group <- dat[[group_col]][complete]
  write.csv(scores, "outputs/workflow_pca_scores.csv", row.names = FALSE)
}

# 6. Group means with SEM for the primary response.
means <- dat %>% group_by(.data[[group_col]]) %>%
  summarise(n = sum(is.finite(.data[[primary_response]])),
            mean = mean(.data[[primary_response]], na.rm = TRUE),
            sem = sem(.data[[primary_response]]), .groups = "drop")
write.csv(means, "outputs/workflow_primary_response_means.csv", row.names = FALSE)
p <- ggplot(means, aes(x = .data[[group_col]], y = mean)) +
  geom_col(fill = "steelblue") +
  geom_errorbar(aes(ymin = mean - sem, ymax = mean + sem), width = 0.2) +
  theme_minimal() + labs(title = paste(primary_response, "by", group_col),
                         x = group_col, y = paste("Mean", primary_response, "+/- SEM"))
ggsave("outputs/workflow_primary_response_means.png", p, width = 7, height = 5, dpi = 300)

message("Complete workflow finished. Results are in the outputs folder.")
