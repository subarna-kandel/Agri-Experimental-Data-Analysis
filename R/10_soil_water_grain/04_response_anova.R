# One-way ANOVA, Tukey HSD, and SEM for soil, water, or grain responses.
# This replaces repeated soil_anova/wateranova loops.
source("R/00_setup.R")
library(dplyr)

data_file <- "examples/agricultural_example.csv"
group_col <- "Treatment"
response_cols <- NULL

dat <- read_data(data_file)
check_columns(dat, group_col)
dat[[group_col]] <- factor(dat[[group_col]])
if (is.null(response_cols)) response_cols <- numeric_columns(dat)
response_cols <- setdiff(response_cols, group_col)
if (length(response_cols) == 0L) stop("No numeric responses selected.")

results <- lapply(response_cols, function(response) {
  d <- dat[, c(group_col, response), drop = FALSE]
  names(d) <- c("group", "response")
  d <- d[is.finite(d$response), , drop = FALSE]
  d$group <- droplevels(droplevels(factor(d$group)))
  if (nlevels(d$group) < 2L || any(table(d$group) < 2L)) {
    return(data.frame(response = response, df = NA_real_, f_value = NA_real_,
                      p_value = NA_real_, note = "Insufficient replication"))
  }
  fit <- aov(response ~ group, data = d)
  tab <- summary(fit)[[1]]
  tukey <- TukeyHSD(fit)$group
  write.csv(as.data.frame(tukey),
            file.path("outputs", paste0("tukey_", safe_name(response), ".csv")))
  data.frame(response = response, df = tab$Df[1], f_value = tab$`F value`[1],
             p_value = tab$`Pr(>F)`[1], note = NA_character_)
})
anova_results <- do.call(rbind, results)
print(anova_results)
write.csv(anova_results, "outputs/multi_response_anova.csv", row.names = FALSE)

sem_results <- bind_rows(lapply(response_cols, function(response) {
  dat %>% group_by(.data[[group_col]]) %>%
    summarise(response = response, n = sum(is.finite(.data[[response]])),
              mean = mean(.data[[response]], na.rm = TRUE),
              sem = sem(.data[[response]]), .groups = "drop")
}))
write.csv(sem_results, "outputs/multi_response_sem.csv", row.names = FALSE)
