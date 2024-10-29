library(tidyverse)
library(readxl)

# Tidy Data Rule #1: Every Column is a Variable

billboard_tidy <-
  billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    values_to = "ranking"
  )

ggplot(
  data = billboard_tidy,
  aes(
    x = week,
    y = ranking,
    group = track
  )
) +
  geom_line() +
  facet_wrap(
    vars(track)
  )

# Tidy Data Rule #2: Every Row is an Observation

survey_data <-
  read_csv("data-raw/survey_data.csv")

demographics <-
  survey_data |>
  select(respondent_id, location) |>
  separate_wider_delim(
    cols = location, delim = ", ", names = c("city", "state")
  )

favorite_parts <-
  survey_data |>
  select(respondent_id, favorite_parts) |>
  separate_longer_delim(
    cols = favorite_parts,
    delim = ", "
  )

survey_data |>
  count(favorite_parts)

# Also tidy pre/post/satisfaction questions

# Tidy Data Rule #3: Every Cell is a Single Value

addresses <-
  read_csv("data-raw/addresses.csv")

addresses |>
  separate_wider_delim(
    cols = Address,
    delim = ", ",
    names = c("city", "state")
  )

# Survey Monkey data

read_xlsx("data-raw/survey-monkey-data.xlsx")
