library(tidyverse)
library(camcorder)
library(ggimage)
library(ggtext)

gg_record(
  dir = file.path(tempdir(), "recording100"), # where to save the recording
  device = "png", # device to use to save images
  width = 4,      # width of saved image
  height = 6,     # height of saved image
  units = "in",   # units for width and height
  dpi = 300       # dpi to use when saving image
)

# Load in the data

feederwatch <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-10/PFW_2021_public.csv')
site_data <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-01-10/PFW_count_site_data_public_2021.csv')

# Filter for only blujays 
blujay <- feederwatch %>%
  filter(species_code == "blujay")

# Get map data
world_map <- map_data("world") %>%
  filter(region != "Antarctica")

# Get map limits for North America (exclude Hawaii)
north_america <- map_data(map = "world") %>%
  filter(region == "USA" | region == "Canada") %>%
  filter(subregion != "Hawaii" & subregion != "Alaska")

#Toronto lat long:
toronto <- tibble(
  lat = 43.6532,
  long = -79.3832
)

#logo
logo <- tibble(
  lat = 53.5,
  long = -70,
  image = c("https://www.mlbstatic.com/team-logos/team-cap-on-dark/141.svg")
  )

blujay %>%
  ggplot(aes(x = longitude, y = latitude)) +
  geom_map(data = world_map, aes(map_id = region),
           map = world_map, fill = "white", color = "black", size = 0.5,
           inherit.aes = FALSE) +
  expand_limits(x = -122, y = 60) +
  coord_fixed() +
  geom_image(data = logo, aes(x = long, y = lat, image = image),
             size = 0.2, asp = 1.7, inherit.aes = FALSE) +
  geom_point(size = 0.3, colour = "#134A8E", alpha = 0.5) +
  geom_point(data = toronto, aes(x = long, y = lat), inherit.aes = FALSE, colour = "#E8291C", alpha = 0.8, size = 4, shape = 15) +
  theme_void() +
  theme(
    plot.title = element_markdown(size = 26),
    text = element_text(family = "Roboto")
    ) +
  labs(title = "<span style = 'font-size:26pt; color:#134A8E;'>**Blue jay**</span>* sightings recorded in 2021 <br>
       <span style = 'font-size:14pt'> \\*the bird, not the baseball team from </span><span style = 'font-size:14pt; color:#E8291C'>**Toronto**</span> <br>
       <span style = 'font-size:8pt; color:#808080'> (Data source: FeederWatch) </span>")
  
ggsave("2023/2023-01-10/Final_plot.png", device = "png", bg = "white", height = 5, width = 10)



gg_playback(
  name = file.path(tempdir(), "recording100", "vignette_gif.gif"),
  first_image_duration = 5,
  last_image_duration = 15,
  frame_duration = .1,
  image_resize = 800
)
