# Import a workbook and create basic data-quality reports.
source("R/00_setup.R")

data_file <- "examples/agricultural_example.csv"

if (grepl("\\.csv$", data_file, ignore.case = TRUE)) {
  dat <- read.csv(data_file, stringsAsFactors = FALSE, check.names = FALSE)
} else {
  dat <- as.data.frame(read_agri_data(data_file))
}

write.csv(head(dat, 10), "outputs/data_preview.csv", row.names = FALSE)
capture.output(str(dat), file = "outputs/data_structure.txt")
capture.output(summary(dat), file = "outputs/data_summary.txt")

cat("Rows:", nrow(dat), "\nColumns:", ncol(dat), "\n")
print(names(dat))
print(head(dat))
print(summary(dat))
