library(tidyverse)
library(palmerpenguins)

# Theme -------------------------------------------------------------------

theme_dk <- function(base_font = "Inter",
                     show_gridlines = TRUE,
                     show_legend = TRUE) {
  custom_theme <-
    theme_minimal(base_family = base_font) +
    theme(
      axis.title = element_blank(),
      axis.text = element_text(
        color = "grey60",
        size = 18
      )
    )
  
  if (show_gridlines == FALSE) {
    custom_theme <-
      custom_theme +
      theme(
        panel.grid = element_blank()
      )
  }
  
  if (show_legend == FALSE) {
    custom_theme <-
      custom_theme +
      theme(
        legend.position = "none"
      )
  }

  return(custom_theme)
}


# Plots -------------------------------------------------------------------

ggplot(
  data = penguins,
  aes(
    x = bill_length_mm,
    y = bill_depth_mm
  )
) +
  geom_point()

ggplot(
  data = penguins,
  aes(
    x = bill_length_mm,
    y = bill_depth_mm,
    color = island
  )
) +
  geom_point() +
  theme_dk()

penguins |>
  group_by(island) |>
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE)) |>
  ggplot(
    aes(
      x = island,
      y = mean_bill_length,
      label = island,
      fill = island
    )
  ) +
  geom_col()

penguins |>
  group_by(island) |>
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE)) |>
  ggplot(
    aes(
      x = island,
      y = mean_bill_length,
      label = island,
      fill = island
    )
  ) +
  geom_col() +
  theme_dk(show_gridlines = FALSE,
           show_legend = FALSE) +
  theme(
    panel.grid.major.y = element_line()
  )
