library(readxl)
data <- read_excel("data/analysis_data.xlsx")
attach(data)
library(doebioresearch)

variety <- as.factor(variety)
mulching <- as.factor(mulching)
final <- frbd2fact(data[4:7],replication, variety, mulching, 3)
final
#sink("output.txt")
#print(doe)
#sink()
