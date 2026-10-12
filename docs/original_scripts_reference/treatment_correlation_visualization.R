
data <- data.frame(
  District = rep("RegionB", 20),
  Land_use_type = c(rep("M", 10), rep("N", 10)),
  Depth = rep("D1", 20),
  MC = c(10, 13, 2, 18, 21, 4, 11, 8, 6, 6, 36, 7, 4, 8, 6, 8, 10, 19, 4, 9)
)

# Check the data structure
str(data)

# Perform independent t-test based on Land use type
t_test_result <- t.test(MC ~ Land_use_type, data = data)

# View the result
print(t_test_result)

# RegionA data
data_chitwan <- data.frame(
  District = rep("RegionA", 20),
  Land_use_type = c(rep("M", 10), rep("N", 10)),
  Depth = rep("D1", 20),
  MC = c(48, 23, 13, 19, 12, 9, 17, 8, 23, 28, 16, 10, 17, 18, 19, 9, 9, 16, 18, 8)
)

# Check data structure
str(data_chitwan)

# Perform independent t-test based on Land use type
t_test_result_chitwan <- t.test(MC ~ Land_use_type, data = data_chitwan)

# View the result
print(t_test_result_chitwan)

# RegionC data
data_kathmandu <- data.frame(
  District = rep("RegionC", 20),
  Land_use_type = c(rep("M", 10), rep("N", 10)),
  Depth = rep("D1", 20),
  MC = c(25, 25, 21, 19, 45, 36, 24, 27, 15, 27, 14, 12, 20, 25, 13, 15, 24, 10, 36, 10)
)

# Check data structure
str(data_kathmandu)

# Perform independent t-test based on Land use type
t_test_result_kathmandu <- t.test(MC ~ Land_use_type, data = data_kathmandu)

# View the result
print(t_test_result_kathmandu)

# Create the dataset
data <- data.frame(
  District = rep("RegionB", 20),
  Group = c(rep("M", 10), rep("N", 10)),
  Category = rep("D2", 20),
  Value = c(9,6,18,8,8,4,10,7,22,2,20,5,6,16,4,7,7,4,3,2)
)

# Perform independent two-sample t-test
t_test_result <- t.test(Value ~ Group, data = data)

# Print result
print(t_test_result)

# Create the dataset
data_chitwan <- data.frame(
  District = rep("RegionA", 20),
  Group = c(rep("M", 10), rep("N", 10)),
  Category = rep("D2", 20),
  Value = c(11,15,17,20,8,9,16,15,32,9,14,14,14,24,18,22,11,25,20,12)
)

# Perform independent two-sample t-test
t_test_result_chitwan <- t.test(Value ~ Group, data = data_chitwan)

# Print result
print(t_test_result_chitwan)

# Create the dataset
data_kathmandu <- data.frame(
  District = rep("RegionC", 20),
  Group = c(rep("M", 10), rep("N", 10)),
  Category = rep("D2", 20),
  Value = c(22,28,11,25,34,32,29,14,16,16,21,17,9,15,12,16,23,9,15,6)
)

# Perform independent two-sample t-test
t_test_result_kathmandu <- t.test(Value ~ Group, data = data_kathmandu)

# Print result
print(t_test_result_kathmandu)
