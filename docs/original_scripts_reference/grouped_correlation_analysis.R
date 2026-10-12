# Load required libraries
library(dplyr)
library(broom)

# Combine all data into one dataframe
data_all <- data.frame(
  District = c(rep("RegionB", 20),
               rep("RegionA", 20),
               rep("RegionC", 20)),
  Land_use_type = c(rep(c(rep("M", 10), rep("N", 10)), 3)),
  Depth = rep("D1", 60),
  MC = c(
    # RegionB data
    10, 13, 2, 18, 21, 4, 11, 8, 6, 6, 36, 7, 4, 8, 6, 8, 10, 19, 4, 9,
    # RegionA data
    48, 23, 13, 19, 12, 9, 17, 8, 23, 28, 16, 10, 17, 18, 19, 9, 9, 16, 18, 8,
    # RegionC data
    25, 25, 21, 19, 45, 36, 24, 27, 15, 27, 14, 12, 20, 25, 13, 15, 24, 10, 36, 10
  )
)

# Check combined data structure
str(data_all)

# Perform independent t-tests by District
t_test_results <- data_all %>%
  group_by(District) %>%
  do(tidy(t.test(MC ~ Land_use_type, data = .)))

# View the results
print(t_test_results)
boxplot(MC ~ Land_use_type + District, data = data_all,
        main = "Moisture Content by Land Use Type in Each District",
        xlab = "District and Land Use Type",
        ylab = "Moisture Content (%)",
        col = c("lightblue", "lightgreen"))
