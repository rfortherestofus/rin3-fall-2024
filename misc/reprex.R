
# Bad example -------------------------------------------------------------

library(tidyverse)

cbem <- read_csv("data-raw/cbem.csv")

cbem |> 
  filter(location == "Oregon") |> 
  filter(age_group == "Under 18") |> 
  ggplot(aes(
    x = percent,
    y = group
  )) +
  geom_col()

# Good example ------------------------------------------------------------

library(tidyverse)

diamonds |>
  mutate(cut = as.character(cut)) |>
  mutate(cut = fct_rev(cut)) |> 
  group_by(cut) |>
  summarize(avg_price = mean(price)) |>
  ggplot(aes(
    x = avg_price,
    y = cut
  )) +
  geom_col()
