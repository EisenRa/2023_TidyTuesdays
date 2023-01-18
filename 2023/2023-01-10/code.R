library(tidyverse)
library(camcorder)

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














gg_playback(
  name = file.path(tempdir(), "recording", "vignette_gif.gif"),
  first_image_duration = 5,
  last_image_duration = 15,
  frame_duration = .4,
  image_resize = 800
)