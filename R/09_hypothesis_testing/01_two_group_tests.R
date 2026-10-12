# Two-group inference templates for agricultural/environmental data
# Expected columns: Treatment (two groups) and one or more numeric response variables.

# install.packages(c("readxl", "dplyr", "ggplot2"))
library(readxl)
library(dplyr)
library(ggplot2)

# ---- User settings ----
data_file <- "examples/agricultural_example.csv"
group_col <- "Treatment"
response_cols <- NULL  # NULL = all numeric columns other than grouping column
preferred_groups <- NULL  # e.g. c("T3", "T4"); NULL keeps all observed groups

# ---- Import and validate ----
dat <- read.csv(data_file, check.names = FALSE)
if (!group_col %in% names(dat)) stop("Grouping column not found: ", group_col)
dat[[group_col]] <- factor(dat[[group_col]])
if (!is.null(preferred_groups)) {
  dat <- dat[dat[[group_col]] %in% preferred_groups, , drop = FALSE]
  dat[[group_col]] <- droplevels(dat[[group_col]])
}
if (nlevels(droplevels(dat[[group_col]])) != 2L) {
  stop("This template requires exactly two observed groups.")
}
if (is.null(response_cols)) {
  response_cols <- names(dat)[vapply(dat, is.numeric, logical(1))]
}
response_cols <- setdiff(response_cols, group_col)
if (!length(response_cols)) stop("No numeric response columns were selected.")

# Standard error of the mean, excluding missing values.
sem <- function(x) {
  x <- x[is.finite(x)]
  if (length(x) < 2L) return(NA_real_)
  stats::sd(x) / sqrt(length(x))
}

results <- lapply(response_cols, function(response) {
  sub <- dat[, c(group_col, response), drop = FALSE]
  names(sub) <- c("group", "response")
  sub <- sub[complete.cases(sub) & is.finite(sub$response), , drop = FALSE]
  sub$group <- droplevels(factor(sub$group))
  if (nlevels(sub$group) != 2L || any(table(sub$group) < 2L)) {
    return(data.frame(response = response, test = NA_character_, statistic = NA_real_,
                      p_value = NA_real_, note = "Need at least two observations in each group"))
  }
  # Welch t-test is the default; Wilcoxon is reported as a nonparametric alternative.
  tt <- tryCatch(t.test(response ~ group, data = sub), error = function(e) NULL)
  wt <- tryCatch(wilcox.test(response ~ group, data = sub, exact = FALSE), error = function(e) NULL)
  data.frame(response = response,
             welch_t = if (is.null(tt)) NA_real_ else unname(tt$statistic),
             welch_p = if (is.null(tt)) NA_real_ else tt$p.value,
             wilcoxon_w = if (is.null(wt)) NA_real_ else unname(wt$statistic),
             wilcoxon_p = if (is.null(wt)) NA_real_ else wt$p.value,
             note = "Choose the test based on design and assumptions; do not select solely by a normality p-value.")
})
test_results <- bind_rows(results)
print(test_results)
dir.create("outputs", showWarnings = FALSE)
write.csv(test_results, "outputs/two_group_test_results.csv", row.names = FALSE)

# Group summary: sample size, mean, SD, and SEM for each response.
summary_results <- bind_rows(lapply(response_cols, function(response) {
  dat %>% group_by(.data[[group_col]]) %>%
    summarise(response = response, n = sum(is.finite(.data[[response]])),
              mean = mean(.data[[response]], na.rm = TRUE),
              sd = sd(.data[[response]], na.rm = TRUE),
              sem = sem(.data[[response]]), .groups = "drop")
}))
print(summary_results)
write.csv(summary_results, "outputs/two_group_summary.csv", row.names = FALSE)
