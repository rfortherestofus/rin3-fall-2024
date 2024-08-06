# Load Packages
library(janitor)

# Load Data
# This data is from Tidy Tuesday
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-03-05/readme.md

trashwheel <- "trashwheel.csv"

trashwheel <- trashwheel |>
  clean_names()

glimpse(trashwheel)

# Some of the months are in lowercase (september and july) creating duplicates.
# We will need to change this to all caps for analysis later.
unique(trashwheel$month)

# Convert all month names to uppercase
trashwheel$month <- toupper(trashwheel$month)


# Analysis
# How much trash (weight) is collected per year?
trash_year <- trashwheel |>
  select(year, weight) |>
  group_by(year) |>
  summarize (sum_trash_weight = sum(weight)) |>
  arrange(desc(sum_trash_weight))

trash_year
# The weight of trash collected has increased almost every year.
# In 2014, 141 metric tons of trash was collected.
# In 2023, 505 metric tons of trash was collected.




# Let's go further and check out the difference by month as well
trash_month <- trashwheel |>
  select(year, month, weight) |>
  group_by(year, month) |>
  summarize (sum_trash_weight = sum(weight)) |>
  arrange(desc(sum_trash_weight))

trash_month |>
  group_by(month) |>
  summarize(mean_trash_month = mean(sum_trash_weight)) |>
  arrange(desc(mean_trash_month))

# It seems like the dog days of summer (June and July) tend to be the busiest
# for trash collection on average.


# As for the slowest months on average, January and February tend to have the
# least amount of trash collection. March is very slow too.

# Maybe weather stops the trash collection to some extent in late winter (Jan - Mar)
# Perhaps less trash comes into harbor for some reason, or the machines cannot be operated


# What months did average trash collection exceed 60 metric tons?
trash_month |>
  filter(sum_trash_weight > 60) |>
  arrange(sum_trash_weight)
# There are only 10 months where trash collection exceeded 60 tons
# 7 or those 10 months were in the 2020 decade

# Has there been a decrease in cigarette butts collected?
trashwheel |>
  select(year, cigarette_butts) |>
  group_by(year) |>
  summarize (cigarette_count = sum(cigarette_butts, na.rm = TRUE)) |>
  arrange(year)
# Seems like the number of cigarette butts collected has largely declined
# Rise in vaping, decrease in cigarette usage?

# What trash collectors collect the most trash (weight) each year?
trash_id_year <- trashwheel |>
  select(year, month, id, weight, volume) |>
  group_by(year, id) |>
  summarize(sum_trash_weight = sum(weight),
            mean_trash_weight = mean(weight),
            sum_trash_volume = sum(volume),
            mean_trash_volume = mean(volume)) |>
  arrange(year)


# Gwynnda is the newest trash collector, starting in 2021. It had a slow first year,
# but has collected the most trash in 2022 and 2023 (unseating mister as number 1)
trash_id_year |>
  filter(year == 2021 | year == 2022 | year == 2023) |>
  arrange(year)

# Let's look specifically at the trends for each collector
# Mister was the original collector. It is collecting about 200 tons of trash annually.
trash_id_year |>
  filter(id == "mister") |>
  arrange(year)

# Professor was the second collector added, in 2017.
# It tends to collect 30-40 tons of garbage annually
# Volume for this compactor is about 15, similar to mister
# This collector may tend to be capturing trash that takes up a lot of space
# but is somewhat light.
trash_id_year |>
  filter(id == "professor") |>
  arrange(year)

# Captain started in 2018
# This collector seems to be support, as its trash collection is quite low compared to others
# Trash volume tends to be around 10, which might mean it is slightly smaller than other collectors
# Interestingly, it collected the most trash in its first year (weight).
trash_id_year |>
  filter(id == "captain") |>
  arrange(year)

# Gwynnda started in 2021, making it the newest
# While it had a slow first year, it now collects more trash than any other collector annually
trash_id_year |>
  filter(id == "gwynnda") |>
  arrange(year)

