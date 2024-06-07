# Your job is to update the TODOs below to recreate this visualization
# https://show.rfor.us/4MwDlgt2

# A few notes:
# 1. The house icon was added outside of R. Don't worry about adding it.
# 2. Don't worry about adding the county labels. Just add the labels that show the median household income.
# 3. The colors you can use to get close to the viz are "darkgreen" and "gray"

# This is part of Oregon by the Numbers
# See https://www.tfff.org/oregon-numbers/

library(tidyverse)

median_income_yamhill <- read_csv("https://raw.githubusercontent.com/rfortherestofus/rin3-fall-2023/main/data-raw/oregon-median-income-by-county.csv") |> 
  filter(geography %in% c("Yamhill", "Oregon"))

ggplot(data = median_income_yamhill,
       aes(x = amount,
           y = geography,
           label = amount_formatted,
           fill = geography)) +
  geom_col(show.legend = FALSE) +
  geom_text(color = "white",
            hjust = 1.2) +
  geom_text(aes(
    x = 10000,
    label = geography
  ),
  color = "white") +
  scale_fill_manual(values = c(
    "gray", "darkgreen"
  )) +
  theme_void()
