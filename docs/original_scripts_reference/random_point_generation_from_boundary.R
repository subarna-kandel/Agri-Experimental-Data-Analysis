library(readxl)
an_random_points <- read_excel("data/soil_data.xlsx")
summary_rand_points <- an_random_points %>%
  summarize(across(where(is.numeric), list(mean = ~mean(.x, na.rm = TRUE), 
                                           sd = ~sd(.x, na.rm = TRUE))))
print(summary_rand_points)

plot(summary_rand_points)
plot(_random_points$pH)
