# Study-area map from a local shapefile
# Required packages: sf, ggplot2, ggspatial
# Supply your own local shapefile and a field/value identifying the study area.
library(sf)
library(ggplot2)
library(ggspatial)

shapefile_path <- "data/study_area_boundary.shp"
name_field <- "UNIT_NAME"
study_area_name <- "Bharatpur"
map_title <- "Study Area"
map_subtitle <- "Update subtitle to your district/province/country"

boundary <- st_read(shapefile_path, quiet = TRUE)
if (!name_field %in% names(boundary)) stop("Field not found: ", name_field)
study_area <- boundary[boundary[[name_field]] == study_area_name, , drop = FALSE]
if (nrow(study_area) == 0L) stop("No feature matched study_area_name.")

p <- ggplot() +
  geom_sf(data = study_area, fill = NA, color = "black", linewidth = 0.7) +
  annotation_scale(location = "bl", width_hint = 0.25) +
  annotation_north_arrow(location = "tr", which_north = "true",
                         style = north_arrow_minimal) +
  coord_sf() + theme_minimal() +
  labs(title = map_title, subtitle = map_subtitle, x = NULL, y = NULL)
print(p)
dir.create("outputs", showWarnings = FALSE)
ggsave("outputs/study_area_map.png", p, width = 8, height = 6, dpi = 300)
