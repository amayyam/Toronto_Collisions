#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Maryam Ansari
# Date: 22 September, 2024
# Contact: mayyam.ansari@mail.utoronto.ca
# License: MIT
# Pre-requisites: None.
# Any other information needed? None.


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)

### Download Data ###
# get package
package <- show_package("ec53f7b2-769b-4914-91fe-a37ee27a90b3")
package

# get all resources for this package
resources <- list_package_resources("ec53f7b2-769b-4914-91fe-a37ee27a90b3")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% 
  get_resource()

### Save Data ###
write_csv(data, "data/raw_data/raw_data.csv") 