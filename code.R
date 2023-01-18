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

