# Run a simple RCBD ANOVA for each numeric response column.
source("R/00_setup.R")

data_file <- "examples/agricultural_example.csv"
dat <- read.csv(data_file, stringsAsFactors = FALSE, check.names = FALSE)
check_columns(dat, c("Treatment", "Replication"))

dat$Treatment <- factor(dat$Treatment)
dat$Replication <- factor(dat$Replication)
responses <- names(dat)[vapply(dat, is.numeric, logical(1))]

if (!length(responses)) stop("No numeric response variables were found.")

results <- list()
for (response in responses) {
  d <- dat[, c(response, "Treatment", "Replication")]
  names(d)[1] <- "response"
  d <- d[complete.cases(d), ]
  if (nlevels(droplevels(d$Treatment)) < 2) next

  model <- aov(response ~ Replication + Treatment, data = d)
  model_summary <- summary(model)
  capture.output(
    list(response = response, anova = model_summary),
    file = file.path("outputs", paste0("anova_", safe_name(response), ".txt"))
  )

  tab <- model_summary[[1]]
  treatment_row <- which(rownames(tab) == "Treatment")
  p_value <- if (length(treatment_row)) tab[["Pr(>F)"]][treatment_row[1]] else NA_real_
  results[[response]] <- data.frame(
    response = response,
    treatment_p_value = p_value
  )
}

if (length(results)) {
  result_table <- do.call(rbind, results)
  write.csv(result_table, "outputs/anova_summary.csv", row.names = FALSE)
  print(result_table)
}
