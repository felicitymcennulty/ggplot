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
