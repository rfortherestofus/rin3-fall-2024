library(tidyverse)
library(sf)
library(janitor)

# Portland ----------------------------------------------------------------

portland_boundaries <-
  read_sf("data-raw/City_Boundaries.geojson") |>
  clean_names() |>
  filter(cityname == "Portland")

ggplot(data = portland_boundaries) +
  geom_sf()

traffic_signals <-
  read_sf("data-raw/Traffic_Signals.geojson") |>
  clean_names()

ggplot(data = traffic_signals) +
  geom_sf()

snow_and_ice_routes <-
  read_sf("data-raw/Snow_and_Ice_Routes.geojson") |>
  clean_names()

ggplot() +
  geom_sf(data = portland_boundaries) +
  geom_sf(
    data = snow_and_ice_routes,
    aes(
      color = priority
    ),
    linewidth = 0.1
  ) +
  geom_sf(
    data = traffic_signals,
    size = 0.5,
    alpha = 0.5
  ) 

# Tigris ------------------------------------------------------------------

library(tigris)

us_states <- states()

us_states

ggplot(data = us_states) +
  geom_sf()

oregon_counties <- counties(state = "Oregon")

ggplot(data = oregon_counties) +
  geom_sf()

# Median Income -----------------------------------------------------------

library(tidycensus)
library(scales)

median_income <-
  get_acs(
    state = "Oregon",
    geography = "county",
    variables = "B19013_001",
    geometry = TRUE
  )

median_income |>
  ggplot(aes(fill = estimate)) +
  geom_sf() +
  labs(fill = NULL,
       title = "Median Household Income by County") +
  scale_fill_viridis_c(
    option = "magma",
    labels = dollar_format()
  ) +
  theme_void() +
  theme(plot.title = element_text(face = "bold",
                                  hjust = 0.5))



# International Data ------------------------------------------------------

library(rnaturalearth)

iceland <-
  ne_countries(
    country = "Iceland",
    scale = "large",
    returnclass = "sf"
  )

ggplot(data = iceland) +
  geom_sf()
