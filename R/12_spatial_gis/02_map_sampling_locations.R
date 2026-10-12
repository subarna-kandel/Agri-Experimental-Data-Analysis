# Plot sampling GPS coordinates on a study-area boundary
# Coordinates must be longitude/latitude in WGS84 unless the CRS is changed below.
library(sf)
library(ggplot2)

boundary_path <- "data/study_area_boundary.shp"
gps_path <- "data/soil_gps.csv"
longitude_col <- "longitude"
latitude_col <- "latitude"

boundary <- st_read(boundary_path, quiet = TRUE)
gps <- read.csv(gps_path, check.names = FALSE)
needed <- c(longitude_col, latitude_col)
if (!all(needed %in% names(gps))) stop("GPS file must contain: ", paste(needed, collapse = ", "))
gps <- gps[is.finite(gps[[longitude_col]]) & is.finite(gps[[latitude_col]]), , drop = FALSE]
gps_sf <- st_as_sf(gps, coords = needed, crs = 4326, remove = FALSE)
if (is.na(st_crs(boundary))) stop("Boundary CRS is missing; assign the correct CRS before mapping.")
gps_sf <- st_transform(gps_sf, st_crs(boundary))

p <- ggplot() + geom_sf(data = boundary, fill = "grey95", color = "grey30") +
  geom_sf(data = gps_sf, color = "red3", size = 1.8) +
  theme_minimal() + labs(title = "Sampling locations", x = NULL, y = NULL)
print(p)
dir.create("outputs", showWarnings = FALSE)
ggsave("outputs/sampling_locations.png", p, width = 8, height = 6, dpi = 300)
