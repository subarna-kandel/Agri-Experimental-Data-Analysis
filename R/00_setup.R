# Shared helpers for the Agricultural R Analysis collection.
# Run scripts from the repository root in R or RStudio.

dir.create("outputs", showWarnings = FALSE, recursive = TRUE)

read_data <- function(path, sheet = NULL) {
  if (!file.exists(path)) {
    stop("Data file not found: ", path,
         "\nUpdate data_file or place the dataset in the data folder.")
  }
  if (grepl("\\.xlsx?$", path, ignore.case = TRUE)) {
    if (!requireNamespace("readxl", quietly = TRUE)) {
      stop("Install readxl first: install.packages('readxl')")
    }
    return(as.data.frame(read_agri_data(path, sheet = sheet)))
  }
  if (grepl("\\.csv$", path, ignore.case = TRUE)) {
    return(read.csv(path, stringsAsFactors = FALSE, check.names = FALSE))
  }
  stop("Supported data formats are .csv, .xls, and .xlsx.")
}

read_agri_data <- function(path, sheet = NULL) {
  if (!file.exists(path)) {
    stop("File not found: ", path,
         "\nPlace your dataset in the data folder or update the path.")
  }
  if (!requireNamespace("readxl", quietly = TRUE)) {
    stop("Install readxl first: install.packages('readxl')")
  }
  if (is.null(sheet)) {
    readxl::read_excel(path)
  } else {
    readxl::read_excel(path, sheet = sheet)
  }
}

sem <- function(x) {
  x <- x[is.finite(x)]
  if (length(x) < 2L) return(NA_real_)
  stats::sd(x) / sqrt(length(x))
}

numeric_columns <- function(data, min_non_missing = 2L) {
  candidates <- names(data)[vapply(data, is.numeric, logical(1))]
  candidates[vapply(data[candidates], function(x) {
    sum(is.finite(x)) >= min_non_missing &&
      isTRUE(stats::sd(x, na.rm = TRUE) > 0)
  }, logical(1))]
}

check_columns <- function(data, required) {
  missing <- setdiff(required, names(data))
  if (length(missing) > 0) {
    stop("Missing required column(s): ", paste(missing, collapse = ", "),
         "\nAvailable columns: ", paste(names(data), collapse = ", "))
  }
  invisible(TRUE)
}

safe_name <- function(x) {
  x <- gsub("[^A-Za-z0-9_-]+", "_", x)
  gsub("^_|_$", "", x)
}
