library(tidyverse)
library(janitor)

# https://or.water.usgs.gov/non-usgs/bes/
# https://or.water.usgs.gov/non-usgs/bes/hayden_island.rain

portland_precipitation <-
  read_csv("https://raw.githubusercontent.com/rfortherestofus/rin3-fall-2024/refs/heads/main/data-raw/portland-precipitation.csv") |> 
  clean_names() |> 
  mutate(date = dmy(date)) |> 
  mutate(total = parse_number(total)) |> 
  mutate(total = total * 0.01) |> 
  mutate(
    year = year(date),
    month = month(date),
    day = day(date)
  ) |> 
  pivot_longer(
    cols = starts_with("x"),
    names_to = "hour",
    values_to = "precipitation"
  ) |> 
  mutate(hour = parse_number(hour)) |> 
  mutate(precipitation = parse_number(precipitation)) |> 
  mutate(date_time = make_datetime(
    year = year,
    month = month,
    day = day,
    hour = hour
  )) |> 
  select(date_time, precipitation)

portland_precipitation |> 
  ggplot(
    aes(
      x = date_time,
      y = precipitation
    )
  ) +
  geom_col()
