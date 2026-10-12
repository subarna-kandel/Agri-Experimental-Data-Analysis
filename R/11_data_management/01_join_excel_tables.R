# Join tables using a shared identifier, e.g. lab_id.
# Update paths, sheet names, and key after inspecting each workbook.
# install.packages(c("readxl", "dplyr", "writexl"))
library(readxl)
library(dplyr)
library(writexl)

file_a <- "data/table_a.xlsx"
file_b <- "data/table_b.xlsx"
key <- "lab_id"
sheet_a <- 1
sheet_b <- 1

a <- read_excel(file_a, sheet = sheet_a)
b <- read_excel(file_b, sheet = sheet_b)
if (!key %in% names(a) || !key %in% names(b)) stop("Join key is missing from one or both tables.")
if (anyDuplicated(a[[key]]) || anyDuplicated(b[[key]])) {
  warning("Duplicate keys found. A join may create multiple rows per key; inspect before proceeding.")
}
joined <- full_join(a, b, by = key, suffix = c("_a", "_b"))
print(dim(joined))
print(head(joined))
dir.create("outputs", showWarnings = FALSE)
write_xlsx(joined, "outputs/joined_tables.xlsx")
