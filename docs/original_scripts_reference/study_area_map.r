# Load required packages
library(sf)
library(ggplot2)
library(ggspatial)
library(rnaturalearth)

# Get world map data as background
world <- ne_countries(scale = "medium", returnclass = "sf")

# Example coordinates for study area (replace with your actual coordinates)
study_area <- data.frame(
    lon = c(100, 100, 105, 105),  # Example longitude coordinates
    lat = c(10, 15, 15, 10)       # Example latitude coordinates
) %>%
    st_as_sf(coords = c("lon", "lat")) %>%
    st_bbox() %>%
    st_as_sfc() %>%
    st_sf()

# Create the map
ggplot() +
    geom_sf(data = world, fill = "lightgray", color = "darkgray") +
    geom_sf(data = study_area, fill = NA, color = "red", size = 1) +
    coord_sf(
        xlim = c(min(study_area$lon) - 1, max(study_area$lon) + 1),
        ylim = c(min(study_area$lat) - 1, max(study_area$lat) + 1)
    ) +
    annotation_scale() +
    annotation_north_arrow(
        location = "tr",
        which_north = "true",
        style = north_arrow_fancy_orienteering
    ) +
    theme_minimal() +
    labs(title = "Study Area Map")

# Save the map
ggsave("study_area_map.png", width = 8, height = 6, dpi = 300)
