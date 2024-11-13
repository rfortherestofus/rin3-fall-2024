#  Recreating this: https://show.rfor.us/cditiy

# Load Packages -----------------------------------------------------------

library(tidyverse)
library(scales)
library(ggchicklet)
library(patchwork)

# Import Data ------------------------------------------------------------

cbem <- read_csv("data-raw/cbem.csv")

# Plot --------------------------------------------------------------------

# scale_fill_manual(
#   values = c(
#     "American Indian or Alaska Native" = "#9CC892",
#     "Asian or Pacific Islander" = "#0066cc",
#     "Black or African American" = "#477A3E",
#     "White" = "#6CC5E9",
#     "Hispanic or Latino" = "#ff7400"
#   )
# )