library(tidyverse)
library(janitor)

# https://or.water.usgs.gov/non-usgs/bes/
# https://or.water.usgs.gov/non-usgs/bes/hayden_island.rain

portland_precipitation <-
  read_csv("data-raw/portland-precipitation.csv") 