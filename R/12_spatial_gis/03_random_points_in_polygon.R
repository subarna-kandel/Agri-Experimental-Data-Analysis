# Generate random points inside a polygon study boundary
# st_sample() samples locations in polygon geometry; sample_n() on polygon rows does not.
library(sf)

boundary_path <- "data/study_area_boundary.shp"
n_points <- 500
set.seed(2026) # reproducibility; change or remove as appropriate

boundary <- st_read(boundary_path, quiet = TRUE)
if (nrow(boundary) == 0L) stop("Boundary contains no features.")
area <- st_union(st_make_valid(st_geometry(boundary)))
random_geom <- st_sample(area, size = n_points, type = "random")
random_points <- st_sf(point_id = seq_along(random_geom), geometry = random_geom)

print(random_points)
dir.create("outputs", showWarnings = FALSE)
st_write(random_points, "outputs/random_points.gpkg", delete_dsn = TRUE, quiet = TRUE)
