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







