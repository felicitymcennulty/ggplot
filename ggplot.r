#01/04/2020 intro to ggplot

library(tidyverse)

gapminder <- read_csv("data/gapminder_data.csv")
gapminder_1977 <- filter(gapminder, year == 1977)

gapminder_1977

#ggplot (<DATA>, <AETHETIC MAPPINGS>) + <GEOMETRY LAYER> + <GEOMETRY LAYER2>
ggplot(
      data = gapminder_1977, 
      mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop)
      )+
  geom_point()+
  scale_x_log10()

#is the same as below uses pipe to refer to dataframe
gapminder_1977 %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop))+
  geom_point()+
  scale_x_log10()

# to use multiple graph types need to put aethetics for each geom()
gapminder_1977 %>% 
  ggplot()+
  geom_point(mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop))+
  geom_line(mapping = aes(x= gdpPercap, y = lifeExp))+
  scale_x_log10()


#geom_point can use colour shape, size, fill, alpha(transperancy)

gapminder_1977 %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop))+
  geom_point(colour = 'blue', size = 5)+
  scale_x_log10()


#shape = 25, alpha = 0.7, fill = 'blue', stroke = 2, colour = 'orange' - this shape can fill
#shape = 5, alpha = 0.7, fill = 'blue', stroke = 2, colour = 'red' - this shape doesnt fill


gapminder_1977 %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop))+
  geom_point(shape = 25, alpha = 0.7, fill = 'blue', stroke = 2, colour = 'orange')+
  scale_x_log10()

#setting alpha
gapminder_1977 %>% 
  ggplot(mapping = aes(x = gdpPercap, y = lifeExp, shape = continent, size = pop))+
  geom_point(alpha = 0.4)+
  scale_x_log10()

#Create a scatterplot using gapminder that shows how life expectancy has changed over time: - not very useful
gapminder %>% 
  ggplot(mapping = aes(x = year, y = lifeExp, colour = continent))+
  geom_point()

#make it better, line, group by country
gapminder %>% 
  ggplot(mapping = aes(x = year, y = lifeExp, colour = continent, group = country))+
  geom_line()+
  geom_point()

#Modify the code from the example above so that only the lines are coloured by continent and the points remain black.
gapminder %>% 
  ggplot(mapping = aes(x = year, y = lifeExp,colour = continent, group = country))+
  geom_line()+
  geom_point(colour = "black")

#map a variable to a geom
gapminder %>% 
  ggplot(mapping = aes(x = year, y = lifeExp, group = country))+
  geom_line(mapping = aes(colour = continent))+ #need to set it as an aethetic mapping to colour a variable
  geom_point(alpha = 0.3)

#Then switch the order of the geom_line() and geom_point() layers. What do you notice?
gapminder %>% 
  ggplot(mapping = aes(x = year, y = lifeExp,colour = continent, group = country))+
  geom_point(colour = "black")+
  geom_line()

gapminder %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp))+
  geom_point(alpha = 0.5)+
  scale_x_log10()+
  geom_smooth(method = "lm", size = 2)

#Modify the color and size of the points on the point layer in the previous example.
gapminder %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp))+
  geom_point(alpha = 0.5, colour = "purple", size = 2)+
  scale_x_log10()+
  geom_smooth(method = "lm", size = 2)

#Modify your solution to Challenge 9 so that the points are now a different shape 
#and are colored by continent with new trendlines. Hint: The color argument can be used inside the aesthetic
gapminder %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp, colour = continent))+
  geom_point(alpha = 0.5, size = 2, shape = 15)+
  scale_x_log10()+
  geom_smooth(method = "lm", size = 2)+
  geom_smooth(method = "lm")

#to map the colour lines as aethetics to the different geom
gapminder %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp))+
  geom_point(mapping = aes(colour = continent),alpha = 0.5, size = 2, shape = 15)+
  scale_x_log10()+
  geom_smooth(mapping = aes(colour = continent),method = "lm", size = 2)+
  geom_smooth(method = "lm")

#Scales 

#colors

#provide a manual list of colour values in a vector
gapminder %>% 
  ggplot(aes(x = year, y = lifeExp, colour = continent))+
  geom_point()+
  scale_colour_manual(values = c("red", "green", 'blue', "purple", "black"))
 
#run colours() to see list of R colours by name and number

gapminder %>% 
  ggplot(aes(x = year, y = lifeExp, colour = continent))+
  geom_point()+
  scale_colour_brewer(palette = "BrBG")
 # scale_color_brewer(palette = 1)

#Try modifying the plot above by changing some colours in the scale to see if you can find a pleasing combination. 
#Run the colours() function if you want to see a list of colour names R can use.
colours()

#There is also a scale_colour_brewer() scale that takes an argument palette that is the name of a ColorBrewer palette. 
#Select an appropriate colour palette for the continents from ColorBrewer and apply it to your plot instead
gapminder %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp, colour = continent))+
  geom_point(alpha = 0.5, size = 2, shape = 15)+
  scale_x_log10()+
  scale_color_brewer(palette = "Dark2")+
  geom_smooth(method = "lm", size = 2)+
  geom_smooth(method = "lm")

#Separating plots

a_countries <- filter(gapminder, str_starts(country, "A")) #any countries that start with A

ggplot(a_countries, aes(x = year, y = lifeExp, colour = continent, group - country))+
  geom_line()+
  facet_wrap(~country)


#task12

gapminder %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop)) +
  geom_point() +
  scale_x_log10()+
  scale_color_brewer(palette = "Dark2")+
  facet_wrap(~year)

#ggplot(<DATA>, <AESTHETIC MAPPINGS>) + <GEOM> + <GEOM> + <SCALES> + <FACETS>


