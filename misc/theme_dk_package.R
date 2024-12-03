library(tidyverse)
library(palmerpenguins)

theme_dk <- function(base_family = "Inter Tight", base_size = 14) {
  theme_dk <-
    ggplot2::theme_minimal(
      base_size = base_size,
      base_family = base_family
    ) +
    ggplot2::theme(
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(
        color = "grey90",
        linewidth = 0.5,
        linetype = "dashed"
      ),
      axis.ticks = ggplot2::element_blank(),
      axis.text = ggplot2::element_text(
        color = "grey50",
        size = ggplot2::rel(0.8)
      ),
      axis.title = ggplot2::element_blank(),
      plot.title.position = "plot",
      plot.title = ggplot2::element_text(
        face = "bold",
        size = ggplot2::rel(1.5)
      ),
      plot.subtitle = ggplot2::element_text(
        color = "grey40",
        size = ggplot2::rel(1.1)
      ),
      plot.caption = ggplot2::element_text(
        color = "grey50",
        margin = ggplot2::margin(t = 20)
        # hjust = 0
      ),
      plot.margin = ggplot2::margin(10, 10, 10, 10),
      strip.text = ggplot2::element_text(
        color = "grey40",
        # hjust = 0,
        size = ggplot2::rel(0.9)
      ),
      panel.spacing = ggplot2::unit(2, "lines")
    )
  
  theme_dk
}

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
