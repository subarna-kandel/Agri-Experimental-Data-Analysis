library(readxl)
data <- read_excel("data/analysis_data.xlsx")
attach(data)
str(data)
is.data.frame(data)
head(data)
library(doebioresearch)
final <-  rcbd(data[3],trt,rep,2)
final
