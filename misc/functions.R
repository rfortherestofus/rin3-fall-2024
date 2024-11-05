# Load Packages -----------------------------------------------------------

library(tidycensus)


# Without Function --------------------------------------------------------

get_acs(
  geography = "state",
  variables = c("B03002_003",
                "B03002_004",
                "B03002_005",
                "B03002_006",
                "B03002_007",
                "B03002_008",
                "B03002_009",
                "B03002_012")
)

get_acs(
  geography = "state",
  variables = c(
    "White" = "B03002_003",
    "Black/African American" = "B03002_004",
    "American Indian/Alaska Native" = "B03002_005",
    "Asian" = "B03002_006",
    "Native Hawaiian/Pacific Islander" = "B03002_007",
    "Other race" = "B03002_008",
    "Multi-Race" = "B03002_009",
    "Hispanic/Latino" = "B03002_012"
  )
)

# First version -----------------------------------------------------------

get_acs_race_ethnicity <- function() {
  race_ethnicity_data <-
    get_acs(
      geography = "state",
      variables = c(
        "White" = "B03002_003",
        "Black/African American" = "B03002_004",
        "American Indian/Alaska Native" = "B03002_005",
        "Asian" = "B03002_006",
        "Native Hawaiian/Pacific Islander" = "B03002_007",
        "Other race" = "B03002_008",
        "Multi-Race" = "B03002_009",
        "Hispanic/Latino" = "B03002_012"
      )
    )
  
  race_ethnicity_data
}


# Clean Names -------------------------------------------------------------


# Pass Arguments to Another Function --------------------------------------

get_acs_race_ethnicity <- function(
    clean_variable_names = FALSE,
    my_geography
) {
  race_ethnicity_data <-
    get_acs(
      geography = my_geography,
      variables = c(
        "White" = "B03002_003",
        "Black/African American" = "B03002_004",
        "American Indian/Alaska Native" = "B03002_005",
        "Asian" = "B03002_006",
        "Native Hawaiian/Pacific Islander" = "B03002_007",
        "Other race" = "B03002_008",
        "Multi-Race" = "B03002_009",
        "Hispanic/Latino" = "B03002_012"
      )
    )
  
  if (clean_variable_names == TRUE) {
    race_ethnicity_data <- clean_names(race_ethnicity_data)
  }
  
  race_ethnicity_data
}


# Pass Arguments to Another Function with ... -----------------------------

get_acs_race_ethnicity <- function(clean_variable_names = FALSE) {
  race_ethnicity_data <-
    get_acs(
      geography = "state",
      variables = c(
        "White" = "B03002_003",
        "Black/African American" = "B03002_004",
        "American Indian/Alaska Native" = "B03002_005",
        "Asian" = "B03002_006",
        "Native Hawaiian/Pacific Islander" = "B03002_007",
        "Other race" = "B03002_008",
        "Multi-Race" = "B03002_009",
        "Hispanic/Latino" = "B03002_012"
      )
    )
  
  if (clean_variable_names == TRUE) {
    race_ethnicity_data <- clean_names(race_ethnicity_data)
  }
  
  race_ethnicity_data
}



get_acs_race_ethnicity <- function(
    clean_variable_names = FALSE,
    ...
) {
  race_ethnicity_data <-
    get_acs(
      ...,
      variables = c(
        "White" = "B03002_003",
        "Black/African American" = "B03002_004",
        "American Indian/Alaska Native" = "B03002_005",
        "Asian" = "B03002_006",
        "Native Hawaiian/Pacific Islander" = "B03002_007",
        "Other race" = "B03002_008",
        "Multi-Race" = "B03002_009",
        "Hispanic/Latino" = "B03002_012"
      )
    )
  
  if (clean_variable_names == TRUE) {
    race_ethnicity_data <- clean_names(race_ethnicity_data)
  }
  
  race_ethnicity_data
}
