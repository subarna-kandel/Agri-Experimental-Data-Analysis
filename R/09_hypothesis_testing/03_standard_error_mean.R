# Calculate group means, SD, and standard error of the mean (SEM)
library(dplyr)

data_file <- "examples/agricultural_example.csv"
group_col <- "Treatment"
response_col <- "PlantHeight" # Change to a numeric response in your dataset

dat <- read.csv(data_file, check.names = FALSE)
stopifnot(group_col %in% names(dat), response_col %in% names(dat))
if (!is.numeric(dat[[response_col]])) stop("Response column must be numeric.")
sem <- function(x) {
  x <- x[is.finite(x)]
  if (length(x) < 2L) return(NA_real_)
  sd(x) / sqrt(length(x))
}
summary_table <- dat %>% group_by(.data[[group_col]]) %>%
  summarise(n = sum(is.finite(.data[[response_col]])),
            mean = mean(.data[[response_col]], na.rm = TRUE),
            sd = sd(.data[[response_col]], na.rm = TRUE),
            sem = sem(.data[[response_col]]), .groups = "drop")
print(summary_table)
dir.create("outputs", showWarnings = FALSE)
write.csv(summary_table, "outputs/group_summary_sem.csv", row.names = FALSE)
