library(readxl)
library(writexl)
library(dplyr)

df_code <- read_excel("data/coding_table.xlsx")
df_mn <- read_excel("data/soil_metal_data.xlsx", 
                    sheet = "mn")
df_zn <- read_excel("data/soil_metal_data.xlsx", 
                    sheet = "zn_soil")

df_cu <- read_excel("data/soil_metal_data.xlsx", 
                    sheet = "cu")
df_fe <- read_excel("data/iron_data.xlsx", 
                              sheet = "fes")

merged_df <- df_code %>%
  full_join(df_mn, by = "lab_id") %>%
  full_join(df_zn, by = "lab_id") %>%
  full_join(df_cu, by = "lab_id") %>%
  full_join(df_fe, by = "lab_id")

# View merged data
print(merged_df)

# Save merged data to a new Excel file
write_xlsx(merged_df, "outputs/merged_data.xlsx")

print("Merging complete! Check merged_data.xlsx")
