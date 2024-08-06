# Load packages----------------------------------------------------------------
library(tidyverse)
library(janitor)
library(scales)

# Load Data -------------------------------------------------------------------

# Bring in Tidy Tuesday data
# This is NCAA March Madness tournament data
# https://github.com/rfordatascience/tidytuesday/blob/master/data/2024/2024-03-26/readme.md

team_results <- read_csv("team_results.csv")

# Team results are how the NCAA teams (mens) have historically performed
# I will be mostly using that data for analysis

glimpse(team_results)

# Cleaning up the names, and changing some columns with percentages that were
# imported as characters but should be numeric

team_results <-
  team_results |>
  clean_names() |>
  mutate(across(c(f4percent, champpercent),
                ~ parse_number(.) / 100))

glimpse(team_results)


# Analysis & Visualization ----------------------------------------------------

# Let's look at the schools that have historically been the best
# First, let's just look at the win percentage of schools
# However, I want to filter out schools that have fewer than 10 NCAA games played

results_10_win_plus <- team_results |>
  select(team, games, winpercent) |>
  filter(games >= 10) |>
  arrange(desc(winpercent)) |>
  mutate(win_perc_format = winpercent * 100) |>
  mutate(win_perc_format = sprintf("%.1f%%", win_perc_format))

results_10_win_plus

# Now, I would like to make a separate data set that keeps
# only the top 10 winning percentage teams

results_10_win_plus_top_10 <- results_10_win_plus |>
  top_n(10, winpercent) |>
  arrange(desc(win_perc_format))

results_10_win_plus_top_10

# Now, let's make a bar chart based on highest win percentage
# Just for fun, I'd like to include the team colors
# I got approximate hex codes from chatGPT

ggplot(data = results_10_win_plus_top_10,
       mapping = aes(x = winpercent,
                     y = reorder(team, winpercent), # order teams by winpercent
                     fill = team,
                     label = win_perc_format)) +
  geom_col(show.legend = FALSE) +
  geom_text(color = "white",
            hjust = 1.3) +
  scale_x_continuous(labels = scales::percent) + # Add percent format to x-axis
  theme_minimal() +
  labs(title = "Best Performing Schools in Men's NCAA Tournament History",
       subtitle = "Based on highest win percentage for schools with at least 10 games played",
       x = "Win Percentage",
       y = NULL) +
  scale_fill_manual(values = c(
    "Connecticut" = "#001E62",
    "North Carolina" = "#7BAFD4",
    "Kansas" = "#0051BA",
    "Kentucky" = "#0033A0",
    "Duke" = "#001A57",
    "Villanova" = "#003366",
    "Louisville" = "#AD0000",
    "Michigan St." = "#18453B",
    "Texas Tech" = "#CC0000",
    "Michigan" = "#00274C"
  ))

# Connecticut and North Carolina have the highest win percentages
# Texas Tech and Louisville are little unexpected
# Other teams are the traditional "blue bloods"
# Interestingly, a lot of shades of blue in the top 10!
