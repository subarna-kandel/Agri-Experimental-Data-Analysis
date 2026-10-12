library(readxl)
data <- read_excel("data/harvest_data.xlsx")
attach(data)
library(doebioresearch)

variety <- as.factor(variety)
mulching <- as.factor(mulching)
#forrcbd 3 factriol
final <- frbd2fact(data[4],rep, var, mul, 3)
final

finalcrd<- fcrd2fact(data, var, mul, 3)
