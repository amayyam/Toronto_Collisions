#### Preamble ####
# Purpose: Performing sanity checks
# Author: Maryam Ansari
# Date: 22 September, 2024
# Contact: mayyam.ansari@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to have simulated data.
# Any other information needed? None.


#### Workspace setup ####
library(tidyverse)

#### Test data ####
data <- read_csv("data/raw_data/simulated_data.csv")

# Check for negative numbers in fatalcount (there should be none)
any(data$fatalcount < 0)
any(data$injurycount < 0)
any(data$pdcollcount < 0)

# Check if any dates are outside the expected range (2014-2024)
min(data$date) < as.Date("2014-01-01") | max(data$date) > as.Date("2024-12-31")

# Check for NAs in critical columns (fatalcount, injurycount, pdcollcount)
any(is.na(data$fatalcount))
any(is.na(data$injurycount))
any(is.na(data$pdcollcount))

#### Logical inconsistency: remove rows where all (fatalcount, injurycount, pdcollcount) are 0 ####
# Count the rows to be removed first
logical_inconsistency_count <- data |> 
  filter(fatalcount == 0 & injurycount == 0 & pdcollcount == 0) |> 
  nrow()

# Remove rows where all severity measures are 0
data_cleaned <- data |> 
  filter(!(fatalcount == 0 & injurycount == 0 & pdcollcount == 0))

#### Vehicle involvement: remove rows where all vehicle types (auto, motorcycle, bicycle, pedestrian) are 0 ####
# Count the rows to be removed
vehicle_involvement_count <- data_cleaned |> 
  filter(auto == 0 & motorcycle == 0 & bicycle == 0 & pedestrian == 0) |> 
  nrow()

# Remove rows where no vehicle or pedestrian was involved
data_cleaned <- data_cleaned |> 
  filter(!(auto == 0 & motorcycle == 0 & bicycle == 0 & pedestrian == 0))

#### Display the number of removed rows ####
cat("Number of rows removed due to logical inconsistencies: ", logical_inconsistency_count, "\n")
cat("Number of rows removed due to lack of vehicle involvement: ", vehicle_involvement_count, "\n")

#### Summary statistics to check for outliers or unrealistic values ####
summary(data_cleaned)