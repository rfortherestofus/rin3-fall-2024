# case_match() vs case_when() ---------------------------------------------

library(tidyverse)
library(palmerpenguins)

data(penguins)

penguins |>
  select(species) |>
  mutate(species_v2 = case_match(
    species,
    "Adelie" ~ "Island 1",
    "Chinstrap" ~ "Island 2",
    "Gentoo" ~ "Island 3"
  )) 

penguins |>
  select(species, bill_length_mm) |>
  mutate(species_and_length = case_when(
    species == "Adelie" & bill_length_mm > 35 ~ "Big Adelie Penguins",
    .default = "Other"
  ))


# Joins with mismatched variable types ------------------------------------

fruits <- tibble(
  id = c(1, 2, 3, 4),
  value = c("apple", "banana", "cherry", "date")
)

prices <- tibble(
  id = c("1", "2", "3", "4"),
  price = c(0.99, 1.50, 2.00, 2.50)
) |> 
  mutate(id = as.numeric(id))

fruits |> 
  left_join(prices,
            join_by(id))

# Many-to-many joins ------------------------------------------------------

orders <-
  tibble(
    order_date = c("2024-01-01", "2024-01-01", "2024-01-02"),
    product = c("apple", "apple", "banana"),
    quantity = c(5, 3, 2)
  ) |> 
  mutate(location = "Store A")

inventory <-
  tibble(
    product = c("apple", "apple", "banana"),
    location = c("Store A", "Store B", "Store A"),
    stock = c(100, 150, 75)
  )

orders |>
  left_join(
    inventory,
    join_by(product, location)
  ) 

