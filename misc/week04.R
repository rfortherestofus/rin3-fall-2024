library(tidyverse)
library(palmerpenguins)

data("penguins")

penguins |> 
  select(species, island) |> 
  set_names("species1", "island1")
  # rename("observation_year" = "year")

ggplot(data = penguins,
       aes(x = bill_length_mm,
           y = bill_depth_mm)) +
  geom_point() +
  theme_minimal(base_family = "Georgia")

ggsave(
  filename = "misc/penguins-plot.pdf",
  device = cairo_pdf,
  width = 8,
  height = 8
)  
