library(readxl)
experimental_data <- read_excel("data/experimental_data.xlsx")

print(experimental_data)
head(experimental_data)
str(experimental_data)
is.data.frame(experimental_data)

summary(experimental_data)
attach(experimental_data)
  
  data
)
lmsd14 <- lm(treatment ~ sd14das, data = experimental_data)
avsd14 <- anova(lmsd14)
anova <- aov(data$treatment ~ data$sd14das, data = "data")
