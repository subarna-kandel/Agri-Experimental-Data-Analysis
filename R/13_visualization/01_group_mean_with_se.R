# Plot treatment means with standard-error bars
library(dplyr)
library(ggplot2)

data_file <- "examples/agricultural_example.csv"
group_col <- "Treatment"
response_col <- "PlantHeight"

dat <- read.csv(data_file, check.names = FALSE)
if (!all(c(group_col, response_col) %in% names(dat))) stop("Check selected column names.")
if (!is.numeric(dat[[response_col]])) stop("Response must be numeric.")
sem <- function(x) {
  x <- x[is.finite(x)]
  if (length(x) < 2L) return(NA_real_)
  sd(x) / sqrt(length(x))
}
summ <- dat %>% group_by(.data[[group_col]]) %>%
  summarise(n = sum(is.finite(.data[[response_col]])),
            mean = mean(.data[[response_col]], na.rm = TRUE),
            se = sem(.data[[response_col]]), .groups = "drop")
print(summ)
p <- ggplot(summ, aes(x = .data[[group_col]], y = mean)) +
  geom_col() + geom_errorbar(aes(ymin = mean - se, ymax = mean + se), width = 0.2) +
  theme_minimal() + labs(x = group_col, y = paste("Mean", response_col), title = "Group means ± SEM")
print(p)
dir.create("outputs", showWarnings = FALSE)
write.csv(summ, "outputs/group_means_sem.csv", row.names = FALSE)
ggsave("outputs/group_means_sem.png", p, width = 7, height = 5, dpi = 300)
