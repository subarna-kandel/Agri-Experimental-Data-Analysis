# One-way ANOVA and Tukey HSD across multiple response variables
# Use only when Treatment is a suitable fixed grouping factor and observations/design support this model.

data_file <- "examples/agricultural_example.csv"
group_col <- "Treatment"
response_cols <- NULL # NULL = all numeric columns

 dat <- read.csv(data_file, check.names = FALSE)
if (!group_col %in% names(dat)) stop("Grouping column not found.")
dat[[group_col]] <- factor(dat[[group_col]])
if (is.null(response_cols)) response_cols <- names(dat)[vapply(dat, is.numeric, logical(1))]
response_cols <- setdiff(response_cols, group_col)
if (nlevels(droplevels(dat[[group_col]])) < 2L) stop("At least two treatment levels are required.")

all_results <- list()
for (response in response_cols) {
  sub <- dat[, c(group_col, response), drop = FALSE]
  sub <- sub[complete.cases(sub), , drop = FALSE]
  names(sub) <- c("Treatment", "response")
  sub$Treatment <- droplevels(factor(sub$Treatment))
  if (nlevels(sub$Treatment) < 2L || any(table(sub$Treatment) < 2L)) {
    message("Skipping ", response, ": insufficient observations in one or more groups.")
    next
  }
  fit <- aov(response ~ Treatment, data = sub)
  cat("\n--- Response:", response, "---\n")
  print(summary(fit))
  print(TukeyHSD(fit))
  all_results[[response]] <- list(anova = summary(fit), tukey = TukeyHSD(fit))
}
