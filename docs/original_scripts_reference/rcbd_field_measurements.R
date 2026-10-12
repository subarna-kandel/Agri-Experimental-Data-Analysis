library(agricolae)
library(doebioresearch)
library(readxl)

lam <- read_excel("data/field_measurements.xlsx")
attach(lam)
head(lam)
as.factor(replication)
as.factor(treatment)

plot(totalperplant)

rcbd <- rcbd(lam[3:10], treatment, replication, 2)
rcbd
 

lam2 <- read_excel("data/working_data.xlsx")
attach(lam2)
rcbd <- rcbd(lam2[49], treatment, replication, 2)
rcbd
plot(BLMBIDW)
