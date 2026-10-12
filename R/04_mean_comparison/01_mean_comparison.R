# Examples of post-hoc mean comparison after fitting a suitable model.
# Choose the method according to the study protocol and model assumptions.
source("R/00_setup.R")

data_file <- "examples/agricultural_example.csv"
dat <- read.csv(data_file, stringsAsFactors = FALSE, check.names = FALSE)
check_columns(dat, c("Treatment", "Replication", "Yield"))
dat$Treatment <- factor(dat$Treatment)
dat$Replication <- factor(dat$Replication)

fit <- aov(Yield ~ Replication + Treatment, data = dat)

if (!requireNamespace("agricolae", quietly = TRUE)) {
  stop("Install agricolae: install.packages('agricolae')")
}

lsd_result <- agricolae::LSD.test(fit, "Treatment", group = TRUE)
duncan_result <- agricolae::duncan.test(fit, "Treatment", group = TRUE)

capture.output(lsd_result, file = "outputs/lsd_comparison.txt")
capture.output(duncan_result, file = "outputs/duncan_comparison.txt")
print(lsd_result)
print(duncan_result)
