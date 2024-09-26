
# Load Packages -----------------------------------------------------------

library(tidyverse)
library(scales)


# Import Data -------------------------------------------------------------

# read_csv("https://gist.githubusercontent.com/joelehman1/ac215c9e358be0c0280678db6d865446/raw/f5df4f621b4a27b65fedebb8ac30b69874675220/mn_age_data_v4.csv") |>
#   mutate(age = str_remove(age, "age_")) |>
#   mutate(age = str_trim(age)) |>
#   mutate(age = str_replace_all(age, "_", " ")) |>
#   mutate(sex = case_when(
#     str_detect(sex_and_year, "female") ~ "female",
#     .default = "male"
#   )) |> 
#   mutate(year = parse_number(sex_and_year)) |> 
#   filter(year == 2019) |>
#   select(age, sex, population) |>
#   write_csv("data-raw/minnesota_population_2019.csv")

minnesota_population_2019 <- read_csv("data-raw/minnesota_population_2019.csv")


# Plot --------------------------------------------------------------------

minnesota_population_2019 |> 
  mutate(population = if_else(sex == "male",
                              true = population,
                              false = population * -1)) |> 
  ggplot(
    aes(x = population,
        y = age,
        fill = sex)
  ) +
  geom_col()
  


