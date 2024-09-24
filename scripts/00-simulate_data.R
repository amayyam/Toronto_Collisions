#### Preamble ####
# Purpose: Simulates data
# Author: Maryam Ansari
# Date: 22 September, 2024
# Contact: mayyam.ansari@mail.utoronto.ca
# License: MIT
# Pre-requisites: None.
# Any other information needed? None.


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(304)

# Define the date range
start_date <- as.Date("2014-01-01")
end_date <- as.Date("2024-12-31")
number_of_rows <- 300  # Number of rows to simulate

# Generate simulated data
collision_data <- tibble(
  # Generate a unique ID for each row
  id = 1:number_of_rows,
  
  # Random date and time details
  date = as.Date(runif(n = number_of_rows, 
                           min = as.numeric(start_date), 
                           max = as.numeric(end_date)), 
                     origin = "1970-01-01"),
  year = sample(2014:2024, size = number_of_rows, replace = TRUE),
  month = sample(1:12, size = number_of_rows, replace = TRUE),
  week_day = sample(c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"), 
                   size = number_of_rows, replace = TRUE),
  hour = sample(0:23, size = number_of_rows, replace = TRUE),
  
  # Collision details
  fatalcount = rpois(n = number_of_rows, lambda = 0.05),  # Simulating rare fatalities
  injurycount = sample(c(0, 1), size = number_of_rows, replace = TRUE, prob = c(0.7, 0.3)),
  pdcollcount = sample(c(0, 1), size = number_of_rows, replace = TRUE, prob = c(0.6, 0.4)),
  
  # Involvement of different parties
  auto = sample(c(0, 1), size = number_of_rows, replace = TRUE),
  motorcycle = sample(c(0, 1), size = number_of_rows, replace = TRUE, prob = c(0.95, 0.05)),
  bicycle = sample(c(0, 1), size = number_of_rows, replace = TRUE, prob = c(0.9, 0.1)),
  pedestrian = sample(c(0, 1), size = number_of_rows, replace = TRUE, prob = c(0.85, 0.15))
)

#### Save Data ####
write_csv(collision_data, file = "data/raw_data/simulated_data.csv")