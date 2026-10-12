getwd()
library(readxl)
data <- read_excel("data/leaf_area_data.xlsx")
 str(data)

attach(data)
library(doebioresearch)

 
 is.data.frame(data)
 final <-  rcbd(data[3:6],trt,Rep,2)
 
print (final)
 
sink("draftslai.txt")
print(final)
sink()
