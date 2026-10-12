# Install and load the necessary packages
library(sf)
library(sf)
library(dplyr)
library(readxl)
# Read the shapefile
study_area_a_sf <- st_read("data/study_area_boundary.shp")
plot(study_area_a_sf)
head(study_area_a_sf)
# Randomly select 500 points
random_points <- study_area_a_sf %>% sample_n(500, replace = TRUE)

# Plot the selected points (optional)
plot(st_geometry(study_area_a_sf), col = "white") # Original points in gray
plot(st_geometry(random_points), col = "red", add = TRUE) # Selected points in red

#load Gps points
soil_gps <- read_excel("data/gps_points.xlsx")
water_gps <- read.csv("data/sampling_locations.csv")
grain_gps <- read.csv("data/sampling_locations.csv")

st_geometry_type(study_area_a_sf)
st_crs(study_area_a_sf)
st_bbox(study_area_a_sf)
# Plot the shapefile
head(study_area_a_sf)
print(study_area_a_sf)
plot(study_area_a_sf)

#study area map
library(ggplot2)
library(ggspatial)  # For north arrow

ggplot() + 
  geom_sf(data = study_area_a_sf, 
          size = 1.5, 
          color = "black", 
          fill = NA) +  # Removed fill color
  ggtitle("Study Area") +
  theme(
    plot.title = element_text(hjust = 0.5),  # Center the title
    panel.background = element_blank(),       # Remove graphical background
    panel.grid = element_blank(),            # Remove grid
    panel.border = element_rect(            # Add border
      color = "black",
      fill = NA,
      size = 1
    )
  ) +
  annotation_north_arrow(
    location = "tr",                        # top right position
    style = north_arrow_minimal()           # minimal style north arrow
  ) +
  coord_sf()
# Plot the shapefile with ggplot2
library(ggplot2)
ggplot() +
  geom_sf(data = study_area_a_sf) +
  theme_minimal()

# Convert GPS points to sf object (assuming columns are named longitude and latitude)
soil_gps_sf <- st_as_sf(soil_gps, 
                        coords = c("x", "y"),
                        crs = 4326)  # WGS84 coordinate system

# Make sure both layers have the same CRS
# Check current CRS of both layers
st_crs(study_area_a_sf)
st_crs(soil_gps_sf)

# If they're different, transform soil_gps to match study_area_a_sf
soil_gps_sf <- st_transform(soil_gps_sf, st_crs(study_area_a_sf))

# Create the plot
plot(st_geometry(study_area_a_sf),  # Plot the boundary first
     main = "Soil Sampling Locations in StudyAreaA",
     col = "lightgrey")
plot(st_geometry(soil_gps_sf),   # Add points on top
     col = "red",
     pch = 19,     # Solid circles
     add = TRUE)   # Add to existing plot

# Add a legend
legend("topright", 
       legend = c("Boundary", "Soil Samples"),
       col = c("lightgrey", "red"),
       pch = c(NA, 19),
       pt.bg = c("lightgrey", "red"),
       fill = c("lightgrey", NA))
#using ggplot2 for more asthetic plots
ggplot() +
  geom_sf(data = study_area_a_sf, fill = "lightgrey") +
  geom_sf(data = soil_gps_sf, color = "red", size = 3) +
  theme_minimal() +
  labs(title = "Soil Sampling Locations in StudyAreaA")

# Convert GPS points for water samples
water_gps_sf <- st_as_sf(water_gps, 
                         coords = c("longitude", "latitude"),
                         crs = 4326)
water_gps_sf <- st_transform(water_gps_sf, st_crs(study_area_a_sf))

# Convert GPS points for grain samples
grain_gps_sf <- st_as_sf(grain_gps, 
                         coords = c("longitude", "latitude"),
                         crs = 4326)
grain_gps_sf <- st_transform(grain_gps_sf, st_crs(study_area_a_sf))

# Plot water samples
ggplot() +
  geom_sf(data = study_area_a_sf, fill = "lightgrey") +
  geom_sf(data = water_gps_sf, color = "blue", size = 3) +
  theme_minimal() +
  labs(title = "Water Sampling Locations in StudyAreaA")

# Plot grain samples  
ggplot() +
  geom_sf(data = study_area_a_sf, fill = "lightgrey") +
  geom_sf(data = grain_gps_sf, color = "green", size = 3) +
  theme_minimal() +
  labs(title = "Grain Sampling Locations in StudyAreaA")
