library(terra)
library(sf)

# Load the land use raster file
land_use_raster <- rast("data/land_use_raster.tif")
# Inspect unique values in the raster
unique_values <- unique(values(land_use_raster))
print(unique_values) # Check the unique land use classes

# Define the value representing agricultural land use (replace with actual value)
agriculture_value <- 5

# Create a binary mask for agriculture
agriculture_mask <- land_use_raster == agriculture_value

# Convert raster to polygons
agriculture_polygons <- as.polygons(agriculture_mask, dissolve = TRUE)

# Convert to sf object
agriculture_sf <- st_as_sf(agriculture_polygons)

# Save as shapefile
st_write(agriculture_sf, "agriculture_land_use.shp", driver = "ESRI Shapefile")

print("Shapefile created successfully!")
