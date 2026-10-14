# RCBD analysis for multiple response traits using doebioresearch.
# Confirm the data layout, treatment column, block/replication column,
# and response columns before interpreting the results.

if (!requireNamespace("doebioresearch", quietly = TRUE)) {
  install.packages("doebioresearch")
}
library(doebioresearch)

data_file <- "data/azotobacter.csv"
treatment_column <- "trt"
replication_column <- "rep"
response_columns <- 3:16

dat <- read.csv(data_file, stringsAsFactors = FALSE, check.names = FALSE)

required_columns <- c(treatment_column, replication_column)
missing_columns <- setdiff(required_columns, names(dat))
if (length(missing_columns) > 0L) {
  stop("Missing required column(s): ", paste(missing_columns, collapse = ", "))
}
if (max(response_columns) > ncol(dat)) {
  stop("response_columns includes a column index beyond the dataset.")
}

dat[[treatment_column]] <- as.factor(dat[[treatment_column]])
dat[[replication_column]] <- as.factor(dat[[replication_column]])

analysis_data <- dat[, response_columns, drop = FALSE]
analysis_data[[treatment_column]] <- dat[[treatment_column]]
analysis_data[[replication_column]] <- dat[[replication_column]]

# The original script passed selected response columns and the treatment/block
# vectors to rcbd(). Verify the package's expected argument structure for your
# installed version before running this call.
analysis_result <- rcbd(
  analysis_data[, response_columns, drop = FALSE],
  dat[[treatment_column]],
  dat[[replication_column]],
  2
)

print(analysis_result)
dir.create("outputs", showWarnings = FALSE, recursive = TRUE)
capture.output(analysis_result, file = "outputs/azotobacter_rcbd_results.txt")
