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

## and/or filtering & = and | = or ----

btv_sea_flights_fall <- flights %>% 
  filter(origin == "JFK" & (dest == "BTV" | dest == "SEA") & month >= 10)
View(btv_sea_flights_fall)
# filtering flights leaving from JFK with destination in Burlington, Vermont or Seattle, Washington in the months of October, November, or December

btv_sea_flights_fall <- flights %>% 
  filter(origin == "JFK", (dest == "BTV" | dest == "SEA"), month >= 10)
View(btv_sea_flights_fall)
# same code as above^ just without the & symbol

## not operator ! filtering ----
not_BTV_SEA <- flights %>% 
  filter(!(dest == "BTV" | dest == "SEA"))
View(not_BTV_SEA)
# filtering rows where flights Burlington, VT or Seattle, WA
# Note where parentheses is around (dest == "BTV" | dest == "SEA")

flights %>% filter(!dest == "BTV" | dest == "SEA")
# This would result in df returning all flights NOT headed to BTV or SEA

## returning large amount of results using %in% operator ----

many_airports <- flights %>% 
  filter(dest == "SEA" | dest == "SFO" | dest == "PDX" | 
         dest == "BTV" | dest == "BDL")

many_airports <- flights %>% 
  filter(dest %in% c("SEA", "SFO", "PDX", "BTV", "BDL"))
View(many_airports)
# Both return the same result but more efficent approach is the use of the %in% operator along with c() function
# c() combines or concatenates values into a single vector of values

# As a final note, we recommend that filter() should often be among the first verbs you consider applying to your data. 
# This cleans your dataset to only those rows you care about, or put differently, it narrows down the scope of your data frame to just the observations you care about.


# summarize variables -----------------------------------------------------
