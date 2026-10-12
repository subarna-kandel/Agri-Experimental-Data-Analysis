getwd()
library(agricolae)
library(readxl)

veg <- read_excel("data/vegetation_data.xlsx")
str(veg)
is.data.frame((veg))
attach(veg)
head(veg
)
#change variety to factor
veg$variety <- as.factor(veg$variety)   #factor variety
veg$mulching <- as.factor(veg$mulching) #factor mulching

str(veg)

#anova15 day after transplanting
anova15<- aov(veg$HT15dat~veg$replication +veg$variety+ veg$mulching+veg$variety:veg$mulching) 
summary(anova15)

#dmrt test
var_dmrt15 <- duncan.test(HT15dat, veg$variety, 14,0.8393)   #due to variety
mul_dmrt15 <- duncan.test(HT15dat, veg$mulching, 14,0.8393)  #due to mulching
inter_dmrt15<- duncan.test(HT15dat, veg$variety:veg$mulching, 14,0.8393)  #due to interaction
var_dmrt15
mul_dmrt15
inter_dmrt15
