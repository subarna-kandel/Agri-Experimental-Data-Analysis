library(lwgeom)
library(sf)
study_area_a_sf <- st_read("data/study_area_boundary.shp")
plot(study_area_a_sf)
head(study_area_a_sf)

# Generate 500 random points within the polygon area
random_points <- st_sample(study_area_a_sf, 500)

# Convert to an sf object
random_points_sf <- st_as_sf(random_points)

# Plot (optional)
plot(st_geometry(study_area_a_sf), col = "gray")  # Original polygons
plot(st_geometry(random_points_sf), col = "red", add = TRUE)  # Selected points
class(random_points_sf)
library(writexl)
# Convert to data frame
#random_points_df <- random_points_sf %>%
 # st_as_sf() %>%                       # Ensure it's an sf object
  #st_drop_geometry()                    # Remove geometry column for Excel
# Export to Excel
#write_xlsx(random_points_df, "random_points.xlsx")

write.csv(random_points_sf, "randompoinr.csv")
