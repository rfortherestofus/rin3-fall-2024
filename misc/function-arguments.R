library(tidyverse)

gss_cat |>
  view()

# Write code to count the number of unique responses to the partyid question

gss_cat |>
  separate_longer_delim(
    cols = partyid,
    delim = ","
  ) |>
  select(partyid)

gss_cat |>
  separate_longer_delim(
    partyid,
    ","
  ) |>
  select(partyid)

ggplot(
  data = gss_cat,
  mapping = aes(
    x = age,
    y = tvhours
  )
) +
  geom_point()

ggplot(
  gss_cat,
  aes(
    age,
    tvhours
  )
) +
  geom_point()
