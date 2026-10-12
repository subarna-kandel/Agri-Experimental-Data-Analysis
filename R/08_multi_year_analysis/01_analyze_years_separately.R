# Analyze each year separately as a starting point.
# A combined multi-environment model may be preferable, but must reflect the
# trial design and account for year-by-treatment effects where appropriate.
source("R/00_setup.R")

year_files <- c(
  Year1 = "examples/year_1_example.csv",
  Year2 = "examples/year_2_example.csv"
)

for (year in names(year_files)) {
  path <- year_files[[year]]
  if (!file.exists(path)) {
    message("Skipping ", year, ": example file not found: ", path)
    next
  }

  dat <- read.csv(path, stringsAsFactors = FALSE, check.names = FALSE)
  check_columns(dat, c("Treatment", "Replication"))
  dat$Treatment <- factor(dat$Treatment)
  dat$Replication <- factor(dat$Replication)

  responses <- names(dat)[vapply(dat, is.numeric, logical(1))]
  for (response in responses) {
    d <- dat[, c(response, "Treatment", "Replication")]
    names(d)[1] <- "response"
    d <- d[complete.cases(d), ]
    if (nlevels(droplevels(d$Treatment)) < 2) next

    fit <- aov(response ~ Replication + Treatment, data = d)
    capture.output(
      summary(fit),
      file = file.path("outputs", paste0(tolower(year), "_anova_", safe_name(response), ".txt"))
    )
  }
}
