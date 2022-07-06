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

## mean & standard deviation ----

summary_temp <- weather %>% 
  summarize(mean = mean(temp), std_dev = sd(temp))
View(summary_temp)
# For now summary_temp shows NA's
# By default anytime calculating a summary statistic that has one or more NA, NA is returned
# The workaround is setting na.rm = TRUE where rm means "remove"
# This will ignore missing values and only return summary for all non-missing values

summary_temp <- weather %>% 
  summarize(mean = mean(temp, na.rm = TRUE), std_dev = sd(temp, na.rm = TRUE))
View(summary_temp)
# This code computes the mean and standard deviation of all non-missing values of temp
# na.rm = TRUE are used as individually to mean() and sd()

summary_temp_counts <- weather %>% 
  summarize(count = n(temp))
View(summary_temp_counts)
# The returned value corresponds to the count of rows in the dataset

### Ignoring missing values caution ----
# na.rm is set to FALSE by default because R does not ignore rows with missing values
# R is alerting me of the presence of missing data data
# Need to be mindful of missing data and potential issues
# DO NOT BLINDLY REMOVE NA'S UNTIL THERE IS AN UNDERSTANING OF WHAT TO DO WITH THEM

# group_by rows -----------------------------------------------------------

# Computing mean & sd by month which will result in 12 rows

summary_monthly_temps <- weather %>% 
  group_by(month) %>% 
  summarize(mean = mean(temp, na.rm = TRUE),
            std_dev = sd(temp, na.rm = TRUE))
summary_monthly_temps
# group_by function does not change df but changes the metadata
# only after summarize() is applied does the df change

## diamonds df example ----

# running diamonds df
diamonds
# tibble reads 53,940 x 10
# example of meta data

diamonds %>% 
  group_by(cut)
# piping diamonds df into group_by(cut)
# additional meta-data Groups: cut [5]
# the data has not change it is still table of 53,940 x 10

diamonds %>% 
  group_by(cut) %>% 
  summarize(avg_price = mean(price))
# by combining group_by() with another data wrangling operation in this case summarize() will the data be transformed
# tibble of 5 x 2

diamonds %>% 
  group_by(cut) %>% 
  ungroup()
# removing the grouping structure to restore original meta-data

## counting summary function ----

# n() counts number of rows/observations

by_origin <- flights %>% 
  group_by(origin) %>% 
  summarize(count = n())
by_origin

# airports with most flights by origin
# 1. EWR
# 2. JFK
# 3. LGA

# Grouping by more than one variable --------------------------------------

by_origin_monthly <- flights %>% 
  group_by(origin, month) %>% 
  summarize(count = n())
by_origin_monthly
# Viewing flights leaving each NYC airport by month

## Incorrect way to group more then 1 variable -----------------------------

by_origin_monthly_incorrect <- flights %>% 
  group_by(origin) %>% 
  group_by(month) %>% 
  summarize(count = n())
by_origin_monthly_incorrect

# month overwrote origin which changes grouping to only group by month.
# Include all variables to be group_by adding a common between variables

# mutate existing variables -----------------------------------------------

# create/compute new variables based on existing ones

weather <- weather %>% 
  mutate(temp_in_C = (temp - 32) / 1.8) 
# converting temperature from Fahrenheit to Celsius
# created a new variable temp_in_C = (temp - 32) / 1.8

summary_monthly_temp <- weather %>% 
  group_by(month) %>% 
  summarize(mean_temp_in_F = mean(temp, na.rm = TRUE),
            mean_temp_in_C = mean(temp_in_C, na.rm = TRUE))
summary_monthly_temp
# avg temp in both F and C

flights <- flights %>% 
  mutate(gain = dep_delay - arr_delay)
# gain is time pilots make up for departing late but arriving early

gain_summary <- flights %>% 
  summarize(
    min = min(gain, na.rm = TRUE),
    q1 = quantile(gain, 0.25, na.rm = TRUE),
    median = quantile(gain, 0.5, na.rm = TRUE),
    max = max(gain, na.rm = TRUE),
    mean = mean(gain, na.rm = TRUE),
    sd = sd(gain, na.rm = TRUE),
    missing = sum(is.na(gain))
 )
gain_summary
# summary stats of the gained flight time

ggplot(data = flights, mapping = aes(x = gain)) +
  geom_histogram(color = "white", bins = 20)
# histogram of gain df since it is a numerical variable
# provides a different perspective when compared to gain_summary df

flights <- flights %>% 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours
)
# Creating multiple new variables at once in same mutate()

# arrange and sort rows ---------------------------------------------------
# arrange allows for a data frame values to be sorted/reordered

freq_dest <- flights %>% 
  group_by(dest) %>% 
  summarize(num_flights = n())
freq_dest
# data is sorted in alphabetical order of destination

freq_dest %>% 
  arrange(num_flights)
# arrange automatically sorts in ascending order

freq_dest %>% 
  arrange(desc(num_flights))
# to show data from lowest to highest need to add desc to get descending

# join data frames --------------------------------------------------------

# merging/joining 2 data frames together
# flights df has the carrier variable which is carrier code for different flights, UA
# name is the full name of the airline UA = United Airlines
# join on key variables which like primary keys
View(airlines)

## Matching “key” variable names -------------------------------------------

# Must join flights & airlines dataframe on the key variable carrier since both df's has this field.

flights_joined <- flights %>% 
  inner_join(airlines, by = "carrier")
View(flights)
View(flights_joined)

## Different “key” variable names ------------------------------------------

 # airport codes in airports df are under faa
# flights has airport codes listed under origin & dest

flights_with_airport_names <- flights %>% 
  inner_join(airports, by = c("dest" = "faa"))
View(flights_with_airport_names)
# since the same column to join on was called someting else in another df, by = c("dest" = "faa") was used in join section

name_dests <- flights %>% 
  group_by(dest) %>% 
  summarize(num_flights = n()) %>% 
  arrange(desc(num_flights)) %>% 
  inner_join(airports, by = c("dest" = "faa")) %>% 
  rename(airport_name = name)
name_dests
# This is a chain of pipe operators %>% that computes number of flights from NYC to each destination

  

