library(tidyverse)

# Theme -------------------------------------------------------------------

theme_dk <- function(base_font = "Inter") {
  custom_theme <-
    theme_minimal(base_family = base_font) +
    theme(
      axis.title = element_blank(),
      axis.text = element_text(
        color = "grey60",
        size = 18
      )
    )

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
    y = bill_depth_mm
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
  theme_dk()
