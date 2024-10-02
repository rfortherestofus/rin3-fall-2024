# Load Packages -----------------------------------------------------------

library(tidyverse)
library(zip)
library(haven)
library(labelled)

# Download Data -----------------------------------------------------------

# download.file("https://gss.norc.org/content/dam/gss/get-the-data/documents/stata/2022_stata.zip",
#   destfile = "data-raw/gss-2022.zip"
# )
#
# unzip(
#   zipfile = "data-raw/gss-2022.zip",
#   exdir = "data-raw",
#   junkpaths = TRUE
# )

# Work with Labelled Data -------------------------------------------------

gss_marital_status <-
  read_dta("data-raw/GSS2022.dta") |>
  select(marital)

gss_marital_status

gss_marital_status |> 
  count(marital) |> 
  ggplot(
    aes(
      x = n,
      y = marital
    ) 
  ) +
  geom_col()


# Convert to Factor -------------------------------------------------------

gss_marital_status |>
  generate_dictionary()

gss_marital_status |>
  as_factor()

gss_marital_status_factor <-
  gss_marital_status |>
  as_factor()

gss_marital_status_factor |> 
  count(marital) |> 
  ggplot(
    aes(
      x = n,
      y = marital
    ) 
  ) +
  geom_col()
