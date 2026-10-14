# Levene's test for homogeneity of variance across groups.
# Update data_file and the group/response column names before running.
# Median-centering gives the Brown-Forsythe version of Levene's test.

if (!requireNamespace("readxl", quietly = TRUE)) {
  install.packages("readxl")
}
if (!requireNamespace("car", quietly = TRUE)) {
  install.packages("car")
}
library(readxl)
library(car)

data_file <- "data/your_data.xlsx"
sheet_name <- 1
group_column <- "Treatment"
response_column <- "Response"

dat <- read_excel(data_file, sheet = sheet_name)

required_columns <- c(group_column, response_column)
missing_columns <- setdiff(required_columns, names(dat))
if (length(missing_columns) > 0L) {
  stop("Missing column(s): ", paste(missing_columns, collapse = ", "))
}

test_data <- data.frame(
  group = as.factor(dat[[group_column]]),
  response = dat[[response_column]]
)
test_data <- test_data[complete.cases(test_data), , drop = FALSE]

if (!is.numeric(test_data$response)) {
  stop("The response column must be numeric.")
}
if (nlevels(droplevels(test_data$group)) < 2L) {
  stop("At least two groups with non-missing observations are required.")
}
test_data$group <- droplevels(test_data$group)

test_result <- car::leveneTest(response ~ group, data = test_data, center = median)
print(test_result)

dir.create("outputs", showWarnings = FALSE, recursive = TRUE)
capture.output(test_result, file = "outputs/levene_test_results.txt")
