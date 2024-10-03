# Load Packages -----------------------------------------------------------

library(tidyverse)
library(gapminder)

# Import Data -------------------------------------------------------------

penguins <- read_csv("data-raw/penguins.csv")

penguins_bill_length_by_island <- penguins |>
  group_by(island) |>
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))

data("gapminder")

# Dropping Points in Scatterplots ----------------------------------------

ggplot(
  data = penguins,
  mapping = aes(
    x = flipper_length_mm,
    y = body_mass_g
  )
) +
  geom_point() +
  scale_x_continuous(
    limits = c(170, 200)
  )


penguins_filtered <- penguins |>
  drop_na(flipper_length_mm, body_mass_g) |>
  filter(flipper_length_mm < 200)

ggplot(
  data = penguins_filtered,
  mapping = aes(
    x = flipper_length_mm,
    y = body_mass_g
  )
) +
  geom_point() +
  scale_x_continuous(
    limits = c(170, 210),
    breaks = seq(from = 170, to = 210, by = 1)
  )

# Bar Chart Width ---------------------------------------------------------

ggplot(
  data = penguins_bill_length_by_island,
  aes(
    x = island,
    y = mean_bill_length,
    label = mean_bill_length
  )
) +
  geom_col(width = 0.9) +
  theme_minimal()

# Center Text in Bar Chart ------------------------------------------------

ggplot(
  data = penguins_bill_length_by_island,
  aes(
    x = 1,
    y = mean_bill_length,
    fill = island
  )
) +
  geom_col() +
  geom_text(
    aes(
      x = 1.5,
      y = mean_bill_length,
      label = mean_bill_length
    ),
    position = position_stack(vjust = 0.5)
  ) +
  scale_fill_viridis_d(option = "D") +
  coord_flip() +
  theme_minimal()


# Reordering Bar Charts ---------------------------------------------------

ggplot(
  data = penguins_bill_length_by_island,
  aes(
    x = island,
    y = mean_bill_length
  )
) +
  geom_col()

ggplot(
  data = penguins_bill_length_by_island,
  aes(
    x = reorder(island, mean_bill_length),
    y = mean_bill_length
  )
) +
  geom_col()

penguins_bill_length_by_island |>
  mutate(island = fct_reorder(island, mean_bill_length)) |>
  ggplot(
    aes(
      x = island,
      y = mean_bill_length
    )
  ) +
  geom_col()


# Wrapping Long Text ------------------------------------------------------

ggplot(
  data = gapminder,
  aes(
    x = year,
    y = lifeExp,
    group = country
  )
) +
  geom_line() +
  facet_wrap(vars(country))

gapminder_wrapped <-
  gapminder |>
  mutate(country_wrapped = str_wrap(country, width = 10))

ggplot(
  data = gapminder_wrapped,
  aes(
    x = year,
    y = lifeExp
  )
) +
  geom_line() +
  facet_wrap(vars(country_wrapped))


# Adjust Axis Text Labels -------------------------------------------------

penguins_bill_length_by_island

penguins_bill_length_by_island_v2 <- penguins_bill_length_by_island |>
  mutate(island = c("Island 1!", "Island 2!", "Island 3!"))

ggplot(
  data = penguins_bill_length_by_island_v2,
  aes(
    x = island,
    y = mean_bill_length,
    label = mean_bill_length
  )
) +
  geom_col() +
  theme_minimal()
