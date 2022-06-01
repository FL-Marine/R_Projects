# Going thru data wrangling exercises listed in Chapter 3 of Modern Drive https://moderndive.com/3-wrangling.html


# Needed Packages ---------------------------------------------------------

library(dplyr)
library(ggplot2)
install.packages("nycflights13")
library(nycflights13)

alaska_flights <- flights %>% 
  filter(carrier == "AS")
View(flights)
