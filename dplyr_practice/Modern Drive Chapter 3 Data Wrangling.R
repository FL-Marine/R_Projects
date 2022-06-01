# Going thru data wrangling exercises listed in Chapter 3 of Modern Drive https://moderndive.com/3-wrangling.html

# Needed Packages ---------------------------------------------------------

library(dplyr)
library(ggplot2)
install.packages("nycflights13")
library(nycflights13)

alaska_flights <- flights %>% 
  filter(carrier == "AS")
View(flights)

# Filter rows -------------------------------------------------------------

# filter() function works similarly to excel allows to specify the criteria about the values of a variable and filters out only those values that match the criteria.

portland_flights <- flights %>% 
  filter(dest == "PDX")
View(portland_flights)
# filtering dataset to just see flights going to Portland

btv_sea_flights_fall <- flights %>% 
  filter(origin == "JFK" & (dest == "BTV" | dest == "SEA") & month >= 10)
View(btv_sea_flights_fall)
# filtering flights leaving from JFK with destination in Burlington, Vermont or Seattle, Washington in the months of October, November, or December

btv_sea_flights_fall <- flights %>% 
  filter(origin == "JFK", (dest == "BTV" | dest == "SEA"), month >= 10)
View(btv_sea_flights_fall)
# same code as above^ just without the & symbol
