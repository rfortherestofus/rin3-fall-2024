#  Recreating this: https://show.rfor.us/cditiy

# Load Packages -----------------------------------------------------------

library(tidyverse)
library(scales)
library(ggchicklet)
library(patchwork)

# Import Data ------------------------------------------------------------

cbem <- read_csv("data-raw/cbem.csv")

# Plot --------------------------------------------------------------------

cbem_plot <- function(state, age) {

cbem_filtered <-
  cbem |>
  filter(location == state) |>
  filter(age_group == age) |>
  filter(group != "All Persons") |>
  select(-c(group_abbreviation, location, ratio)) |>
  mutate(group = fct(group,
    levels = c(
      "American Indian or Alaska Native",
      "Asian or Pacific Islander",
      "Black or African American",
      "White",
      "Hispanic or Latino"
    )
  )) |>
  mutate(percent_formatted = percent(percent)) |>
  mutate(group_position = case_when(
    group == "American Indian or Alaska Native" ~ 1,
    group == "Asian or Pacific Islander" ~ 2,
    group == "Black or African American" ~ 3,
    group == "White" ~ 4,
    group == "Hispanic or Latino" ~ 5.5
  ))

state_average <-
  cbem |>
  filter(location == state) |>
  filter(age_group == age) |>
  filter(group == "All Persons") |>
  pull(percent)


state_average_annotation <-
  str_glue("CBEM State Rate\n{percent(state_average)}")

ggplot(
  data = cbem_filtered,
  aes(
    x = group_position,
    y = percent,
    fill = group,
    label = percent_formatted
  )
) +
  geom_hline(
    yintercept = state_average,
    linetype = "dashed",
    color = "grey40"
  ) +
  geom_chicklet() +
  geom_text(
    vjust = 1.5,
    color = "white",
    size = 5,
    family = "Inter"
  ) +
  annotate(
    geom = "text",
    label = state_average_annotation,
    y = state_average,
    x = 5.5,
    vjust = -0.5,
    color = "grey40",
    family = "Inter"
  ) +
  scale_fill_manual(
    values = c(
      "American Indian or Alaska Native" = "#9CC892",
      "Asian or Pacific Islander" = "#0066cc",
      "Black or African American" = "#477A3E",
      "White" = "#6CC5E9",
      "Hispanic or Latino" = "#ff7400"
    )
  ) +
  theme_void() +
  theme(
    legend.position = "none"
  )

}

cbem_plot(state = "Missouri", 
          age = "Under 25")
