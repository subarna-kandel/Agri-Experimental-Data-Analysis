# Grain quality workflow based on the historical grain testing and
# crude-protein visualization reference scripts.
source("R/00_setup.R")
library(dplyr)
library(ggplot2)

data_file <- "examples/agricultural_example.csv"
group_col <- "Treatment"
response_cols <- c("Yield", "PlantHeight", "LeafCount")
preferred_groups <- NULL       # e.g. c("T3", "T4")

dat <- read_data(data_file)
check_columns(dat, c(group_col, response_cols))
dat[[group_col]] <- factor(dat[[group_col]])
if (!is.null(preferred_groups)) {
  dat <- dat[dat[[group_col]] %in% preferred_groups, , drop = FALSE]
  dat[[group_col]] <- droplevels(dat[[group_col]])
}
if (nlevels(dat[[group_col]]) != 2L) {
  stop("Grain two-group tests require exactly two treatment levels.")
}

test_one <- function(response) {
  d <- dat[, c(group_col, response), drop = FALSE]
  names(d) <- c("group", "value")
  d <- d[is.finite(d$value), , drop = FALSE]
  if (any(table(d$group) < 2L)) return(data.frame(response = response,
    t_p = NA_real_, wilcoxon_p = NA_real_, shapiro_p = NA_real_,
    note = "At least two observations per group required"))
  tt <- t.test(value ~ group, data = d)
  wt <- wilcox.test(value ~ group, data = d, exact = FALSE)
  sh <- shapiro.test(d$value)
  data.frame(response = response, t_p = tt$p.value,
             wilcoxon_p = wt$p.value, shapiro_p = sh$p.value,
             note = "Select the inferential test from the design and assumptions.")
}

results <- do.call(rbind, lapply(response_cols, test_one))
print(results)
write.csv(results, "outputs/grain_quality_two_group_tests.csv", row.names = FALSE)

long <- do.call(rbind, lapply(response_cols, function(response) {
  data.frame(group = dat[[group_col]], response = response,
             value = dat[[response]])
}))
p <- ggplot(long, aes(x = group, y = value, fill = group)) +
  geom_boxplot(alpha = 0.35, outlier.shape = NA) +
  geom_jitter(width = 0.08, alpha = 0.75) +
  facet_wrap(~ response, scales = "free_y") +
  theme_minimal() + theme(legend.position = "none") +
  labs(title = "Grain/trait distributions by treatment", x = group_col, y = NULL)
print(p)
ggsave("outputs/grain_quality_boxplots.png", p, width = 9, height = 6, dpi = 300)
