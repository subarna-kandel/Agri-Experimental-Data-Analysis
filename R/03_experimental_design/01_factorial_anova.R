# Two-factor factorial ANOVA with an optional block/replication term.
# Example factors: Variety and Mulching; response: Yield.
source("R/00_setup.R")

data_file <- "examples/agricultural_example.csv"
dat <- read.csv(data_file, stringsAsFactors = FALSE, check.names = FALSE)
check_columns(dat, c("Yield", "Variety", "Mulching", "Replication"))

dat$Variety <- factor(dat$Variety)
dat$Mulching <- factor(dat$Mulching)
dat$Replication <- factor(dat$Replication)

fit <- aov(Yield ~ Replication + Variety * Mulching, data = dat)
capture.output(summary(fit), file = "outputs/factorial_anova_yield.txt")
print(summary(fit))

# Interpret the interaction first. Do not automatically run pairwise tests
# without considering the design and the study's planned analysis.
if (requireNamespace("agricolae", quietly = TRUE)) {
  capture.output(
    agricolae::duncan.test(fit, "Variety", group = TRUE),
    file = "outputs/duncan_variety_yield.txt"
  )
  capture.output(
    agricolae::duncan.test(fit, "Mulching", group = TRUE),
    file = "outputs/duncan_mulching_yield.txt"
  )
}
