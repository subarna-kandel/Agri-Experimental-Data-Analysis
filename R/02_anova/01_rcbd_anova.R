# Randomized Complete Block Design (RCBD) ANOVA.
# Example columns: Treatment, Replication, PlantHeight, Yield.
# Confirm the model matches the actual randomization before use.
source("R/00_setup.R")

data_file <- "examples/agricultural_example.csv"
dat <- read.csv(data_file, stringsAsFactors = FALSE, check.names = FALSE)

check_columns(dat, c("Treatment", "Replication", "Yield"))
dat$Treatment <- factor(dat$Treatment)
dat$Replication <- factor(dat$Replication)

fit <- aov(Yield ~ Replication + Treatment, data = dat)
capture.output(summary(fit), file = "outputs/rcbd_anova_yield.txt")
print(summary(fit))

if (requireNamespace("agricolae", quietly = TRUE)) {
  lsd <- agricolae::LSD.test(fit, "Treatment", group = TRUE)
  capture.output(lsd, file = "outputs/rcbd_lsd_yield.txt")
}
