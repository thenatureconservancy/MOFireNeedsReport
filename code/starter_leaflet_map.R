

## notes -----
# make starter leaflet map of min-max acres for MO
# Randy tries Feb 26, 2024


## load packages and data -----

library(htmlwidgets)
library(leaflet)
library(sf)
library(tidyverse)

# read in raw data to explore
cntys_min_max_raw <- st_read("data/cntys_min_max_mnad.shp",
                                      quiet = TRUE)


## clean up the data a bit -----

cntys_min_max <- cntys_min_max_raw %>%
  dplyr::select(2, 15:18) %>% # keep these fields
  rename(county_name = COUNTYNAME) %>% # quick rename
  st_transform("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0")


## prep color pallet and for popup

pal <- colorBin("OrRd", domain = cntys_min_max$min_annual)

popup <- paste(
  "County Name:", cntys_min_max$county_name, "<br>",
  "Minimum annual acres burned:", cntys_min_max$min_annual, "<br>",
  "Maximum annual acres burned:", cntys_min_max$max_annual)


## make da map -----

map <-
  leaflet(cntys_min_max) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%
  setView(-91.8318334, 37.9642529, zoom = 6) %>%  
  addPolygons(
    data = cntys_min_max,
    smoothFactor = 0,
    fillColor = ~pal(min_annual),
    fillOpacity = 1, 
    weight = 0.6,
    opacity = 0.8,
    color = "grey",
    popup = ~popup) %>%
  addLegend(
    pal = pal,
    values = ~min_annual,
    position = "bottomright",
    opacity = 1) 

map
