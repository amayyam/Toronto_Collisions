#### Preamble ####
# Purpose: Cleans Toronto collision data to prepare it for analysis
# Author: Maryam Ansari
# Date: 22 September, 2024
# Contact: mayyam.ansari@mail.utoronto.ca
# License: MIT
# Pre-requisites: Data should be downloaded.
# Any other information needed? None.

### Workspace setup ####
library(tidyverse)

#### Clean data ####
# Read the raw data
raw_data <- read_csv("data/raw_data/raw_data.csv")

# Clean the data
cleaned_data <-
  raw_data |>
  janitor::clean_names() |>  # Clean column names
  mutate(fatalities = replace_na(fatalities, 0))  # Only replace NA in fatalities with 0

#### Save cleaned data ####
write_csv(cleaned_data, "data/analysis_data/analysis_data.csv")
