# Going thru data viz exercises listed in Chapter 2 of Modern Drive https://moderndive.com/2-viz.html

# Needed packages ---------------------------------------------------------

library(nycflights13)
library(ggplot2)
# library(moderndive) this library doesn't exist

# The framework of data visualization for the pacakge ggplot2 is based on the "grammar of graphics."

# Components of the grammar
# A statistical graphic is a mapping of data variables to aesthetic attributes of geometric objects.

# 1. data: the dataset containing the variables of interest.

# 2. geom: the geometric object in question. This refers to the type of object we can observe in a plot. For example: points, lines, and bars.

# 3. aes: aesthetic attributes of the geometric object. For example, x/y position, color, shape, and size. Aesthetic attributes are mapped to variables in the dataset.

# Five named graphs - the 5NG ---------------------------------------------

# 1. scatterplots
# 2. linegraphs
# 3. histograms
# 4. boxplots
# 5. barplots

## Scatterplots via geom_point -----------------------------------------------------

# Scatterplots allow the visualize the relationships between 2 numerical variables.

alaska_flights <- flights %>% 
  filter(carrier == "AS")

ggplot(data = alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) +
  geom_point()
# A positive relationship exists between dep_delay and arr_delay: as departure delays increase, arrival delays tend to also increase.
# Large cluster around (0,0) indicating flights neither departed or arrived late.

## Two Components of ggplot() -----------------------------------------------

# 1. The data as the alaska_flights data frame via data = alaska_flights.
 
# 2. The aesthetic mapping by setting mapping = aes(x = dep_delay, y = arr_delay). Specifically, the variable dep_delay maps to the x position aesthetic, while the variable arr_delay maps to the y position.

# To add a layer to the ggplot() function use a + sign. The added layer specifies 3rd component of the grammar the geometric object.

## Overplotting ------------------------------------------------------------

# Hard to tell true data points with previous plot since points are on top of each other
# 2 methods to overcome overplotting
#   1. adjusting transparency
#   2. adding a random jitter or nudge to each data point

## Method 1: Changing the transparency -------------------------------------

ggplot(data = alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) +
  geom_point(alpha = 0.2)
# Addressed overplotting by changing the transparency/opacity of the points by setting the alpha argument in geom_point()
# Can change the alpha argument to be any value between 0 and 1, where 0 sets the points to be 100% transparent and 1 sets the points to be 100% opaque.
# By default, alpha is set to 1
# areas with a high-degree of overplotting are darker, whereas areas with a lower degree are less dark

## Method 2: Jittering the points ------------------------------------------

ggplot(data = alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) +
  geom_point(alpha = 0.2)
# Addressed overplotting by changing the transparency/opacity of the points by setting the alpha argument in geom_point()
# Can change the alpha argument to be any value between 0 and 1, where 0 sets the points to be 100% transparent and 1 sets the points to be 100% opaque.
# By default, alpha is set to 1
# areas with a high-degree of overplotting are darker, whereas areas with a lower degree are less dark

## Method 2: Jittering the points ------------------------------------------

# jittering points means given them a small nudge in random direction
# Think of jittering as shaking the points up a bit on the plot
# Original values stay the same, jittering is just for visualization purposes

ggplot(data = alaska_flights, mapping = aes(x = dep_delay, y = arr_delay)) +
  geom_jitter(width = 50, height = 50)
# width & height corresponds to how hard you want the plot to be shaken up

# Linegraphs --------------------------------------------------------------

# Linegraphs show the relationship between two numerical variables when the variable on the x-axis, also called the explanatory variable, is of a sequential nature.

# The most common examples of linegraphs have some notion of time on the x-axis: hours, days, weeks, years, etc

## Linegraphs via geom_line ------------------------------------------------

early_january_weather <- weather %>% 
filter(origin == "EWR" & month == 1 & day <= 15)

ggplot(data = early_january_weather, 
       mapping = aes(x = time_hour, y = temp)) +
  geom_line()

# Histograms --------------------------------------------------------------

# histograms are good for understanding:
# 1. smallest & largest balues
# 2. what is center value
# 3. spread of values
# 4. frequency of values

# Histograms via geom_histogram ------------------------------------------

ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram()
# only 1 variable being mapped in aes

# Warning: Removed 1 rows containing non-finite values (stat_bin).

# The first message is telling us that the histogram was constructed using bins = 30 for 30 equally spaced bins.
# This is known in computer programming as a default value; unless you override this default number of bins with a number you specify, R will choose 30 by default.

ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(color = "white")
# values below 25 and above 80 are rare
# added white boarders to make data easier to understand


ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(color = "white", fill = "steelblue")
# Can adjust colors of bar by setting the fill to the desired color

# running colors() allows to see all possible choice colors in R

# Adjusting the bins ------------------------------------------------------

## 2 methods to adjust bins----
# 1.bins argument 
# 2. binwidth argument

### bins ----

ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(bins = 40, color = "white")
# default bin # is 30
# can use this method to override default bin width
# specifying how many bins are in x-axis

### binwidth ----

ggplot(data = weather, mapping = aes(x = temp)) +
  geom_histogram(binwidth = 10, color = "white")
# instead of specifying the number of bins, we specify the width of the bins by using the binwidth argument 

# Facets ------------------------------------------------------------------









