# Load Packages -----------------------------------------------------------

library(tidyverse)
library(janitor)
library(here)
library(readxl)
library(usethis)


# Import from Excel -------------------------------------------------------

all_data_raw <- read_excel(here("data-raw/2021-RaceEthnicity-ResultsforR-2021-11-05.xlsx"),
  na = c("999", "Not available")
) %>%
  clean_names() %>%
  left_join(states,
    by = c("location" = "abbreviation")
  ) %>%
  left_join(race_ethnicity_abbrevations, by = "group") %>%
  mutate(location = state_name) %>%
  mutate(group = fct_relevel(group, "Hispanic or Latino", after = Inf)) %>%
  mutate(group_abbreviation = fct_relevel(group_abbreviation, "HL", after = Inf)) %>%
  relocate(group_abbreviation, .after = group)


# Population --------------------------------------------------------------

population_under_25 <- all_data_raw %>%
  select(group:pop_percent0to24) %>%
  rename(
    population = pop0to24,
    population_pct = pop_percent0to24
  ) %>%
  mutate(population_pct = case_when(
    group == "All Persons" ~ 1,
    TRUE ~ population_pct
  )) %>%
  fill(population) %>%
  mutate(population = case_when(
    group == "All Persons" ~ population,
    TRUE ~ population * population_pct
  )) %>%
  mutate(race_ethnicity = case_when(
    group == "Hispanic or Latino" ~ "Ethnicity",
    TRUE ~ "Race"
  )) %>%
  relocate(race_ethnicity, .after = group)

use_data(population_under_25,
  overwrite = TRUE
)


# CBEM --------------------------------------------------------------------

cbem <- all_data_raw %>%
  select(group, group_abbreviation, location, contains("cbem")) %>%
  pivot_longer(cols = -c(group, group_abbreviation, location)) %>%
  mutate(name = str_replace(name, "by", "_by")) %>%
  mutate(name = str_remove(name, "cbem_")) %>%
  separate(name, into = c("measure", "age_group"), sep = "_") %>%
  mutate(age_group = str_replace(age_group, "by", "Under ")) %>%
  pivot_wider(
    id_cols = -measure,
    names_from = measure,
    values_from = value
  ) %>%
  mutate(ratio = str_glue("1 in {ratio}")) %>%
  mutate(race_ethnicity = case_when(
    group == "Hispanic or Latino" ~ "Ethnicity",
    TRUE ~ "Race"
  )) %>%
  relocate(race_ethnicity, .after = group) %>%
  mutate(location = str_replace(location, "AANational", "National"))

use_data(cbem,
  overwrite = TRUE
)


# LCOD --------------------------------------------------------------------

lcod_rates <- all_data_raw %>%
  filter(group != "All Persons") %>%
  select(group, group_abbreviation, location, contains("cod")) %>%
  select(group, group_abbreviation, location, contains("rate")) %>%
  pivot_longer(cols = -c(group, group_abbreviation, location)) %>%
  mutate(age_group = case_when(
    str_detect(name, "0to24") ~ "0 to 24",
    TRUE ~ "25 to 60"
  )) %>%
  mutate(cod_number = str_extract(name, "[1-9]$")) %>%
  rename(rate = value) %>%
  select(group, group_abbreviation, location, age_group, cod_number, rate)

lcod_rates_causes <- all_data_raw %>%
  filter(group != "All Persons") %>%
  select(group, group_abbreviation, location, contains("cod")) %>%
  select(group, group_abbreviation, location, !contains("rate")) %>%
  pivot_longer(cols = -c(group, group_abbreviation, location)) %>%
  mutate(age_group = case_when(
    str_detect(name, "0to24") ~ "0 to 24",
    TRUE ~ "25 to 60"
  )) %>%
  mutate(cod_number = str_extract(name, "[1-9]$")) %>%
  rename(cod = value) %>%
  select(group, group_abbreviation, location, age_group, cod_number, cod)


lcod <- lcod_rates %>%
  left_join(lcod_rates_causes, by = c("group", "group_abbreviation", "location", "age_group", "cod_number")) %>%
  mutate(race_ethnicity = case_when(
    group == "Hispanic or Latino" ~ "Ethnicity",
    TRUE ~ "Race"
  )) %>%
  relocate(race_ethnicity, .after = group) %>%
  mutate(location = str_replace(location, "AANational", "National"))

use_data(lcod,
  overwrite = TRUE
)


# Colors ------------------------------------------------------------------

cbem_race_ethnicity_colors <- (
  c(
    "American Indian or Alaska Native" = cbem_colors("Light Green"),
    "Asian or Pacific Islander" = cbem_colors("Dark Blue"),
    "Black or African American" = cbem_colors("Dark Green"),
    "White" = cbem_colors("Light Blue"),
    "Hispanic or Latino" = cbem_colors("Orange"),
    "Not Hispanic or Latino" = cbem_colors("Extra Light Grey")
))

use_data(cbem_race_ethnicity_colors,
  overwrite = TRUE
)
