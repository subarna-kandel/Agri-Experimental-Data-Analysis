#load the library
library(sf, ggplot2, ggspatial)
 #load shapefile
 study_area_boundaries <- st_read("data/administrative_boundaries.shp")
head(study_area_boundaries)
# Select study areas by the values used in the boundary dataset.
study_area_a <- subset(study_area_boundaries, UNIT_NAME == "StudyAreaA")
study_area_b <- subset(study_area_boundaries, UNIT_NAME == "StudyAreaB")
study_area_c <- subset(study_area_boundaries, UNIT_NAME == "StudyAreaC")
plot(study_area_c)
s <- plot(study_area_boundaries)
s
# Create the map
ggplot() +
  # Base layer with the selected study-area boundary
  geom_sf(data = study_area_a,
          size = 0.8,
          color = "black", 
          fill = NA) +
  # Add title
  ggtitle("Study area") +
  # Replace this subtitle with the relevant region.
  labs(subtitle = "Region and administrative unit") +
  # Customize theme
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, 
                              size = 16, 
                              face = "bold",
                              margin = margin(b = 10)),
    plot.subtitle = element_text(hjust = 0.5, 
                                 size = 12,
                                 margin = margin(b = 20)),
    panel.background = element_blank(),
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black", 
                                fill = NA, 
                                size = 1),
    axis.text = element_text(size = 10),
    axis.title = element_blank()
  ) +
  # Add scale bar
  annotation_scale(
    location = "bl",
    width_hint = 0.3,
    style = "ticks"
  ) +
  # Add north arrow
  annotation_north_arrow(
    location = "tr",
    which_north = "true",
    pad_x = unit(0.2, "in"),
    pad_y = unit(0.2, "in"),
    style = north_arrow_fancy_orienteering
  ) +
  # Set coordinate system
  coord_sf()


# Create the map
ggplot() +
  # Base layer with StudyAreaA boundary
  geom_sf(data = study_area_c_sf, 
          size = 0.8,
          color = "black", 
          fill = NA) +
  # Add title
  ggtitle("Study Location") +
  # Add subtitle
  labs(subtitle = "StudyAreaC, Country") +
  # Customize theme
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, 
                              size = 16, 
                              face = "bold",
                              margin = margin(b = 10)),
    plot.subtitle = element_text(hjust = 0.5, 
                                 size = 12,
                                 margin = margin(b = 20)),
    panel.background = element_blank(),
    panel.grid = element_blank(),
    panel.border = element_rect(color = "black", 
                                fill = NA, 
                                size = 1),
    axis.text = element_text(size = 10),
    axis.title = element_blank()
  ) +
  # Add scale bar
  annotation_scale(
    location = "bl",
    width_hint = 0.3,
    style = "ticks"
  ) +
  # Add north arrow
  annotation_north_arrow(
    location = "tr",
    which_north = "true",
    pad_x = unit(0.03, "in"),
    pad_y = unit(0.03, "in"),
    style = north_arrow_fancy_orienteering
  ) +
  # Set coordinate system
  coord_sf()
