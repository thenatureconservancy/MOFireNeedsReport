

######  make starter dumbbell plot with min and max annual acres as points, order by mean

#  load packages
library(tidyverse)
library(scales)

# read in data
fire_data <- read.csv('data/mfri-evt-mnad.csv') %>%
  top_n(n = 10, wt = acres)

# set order
fire_data$evts <- factor(fire_data$evts, levels = rev(fire_data$evts)) 
# try chart

# Create a dumbbell chart
dumbbell <-
  ggplot(fire_data) +
  geom_segment(aes(x = min.annual.acres, xend = max.annual.acres,
                   y = evts, yend = evts)) +
  geom_point(aes(x = min.annual.acres, y = evts), size = 3, color = '#32a8a6') +
  geom_point(aes(x = max.annual.acres, y = evts), size = 3, color = '#d1841f') +
  theme_minimal(base_size = 14)  +
  scale_x_continuous(labels = scales::comma) +
  labs(
    x = "Acres",
    y = "Existing Vegetation Type",
    title = "Range of annual acres needed to maintain ecosystems",
    subtitle = "EVTs with < 1,000ac removed. Minimum acres statewide = 2,635,008"
  )

dumbbell
