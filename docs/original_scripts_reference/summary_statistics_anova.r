library(doebioresearch)
library(readxl)
data <- read_excel("data/average_data.xlsx")
attach(data)
var...3 <- as.factor(var...3)
med <- as.factor(med)



final <- fcrd2fact(data[5:20],var...3,med,2)

final


sink("anantm.txt")
print(final)
sink()
