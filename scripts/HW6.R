gapminder <- read.csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")
gapminder %>% 
  group_by(continent, year) %>% 
  summarize(meanlife = mean(lifeExp)) %>% 
  ggplot()+
  geom_line(aes(x = year, y = meanlife, color = continent))

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()

# The scale_x_log10() changes the scale of the x-axis and makes it logarithmic instead of linear. The geom_smooth seems to create a line of best fit with some specifications that you can change.

gapminder %>% 
  filter(country %in% c("Brazil", "China", "El Salvador", "Niger", "United States")) %>% 
  ggplot(aes(x = country, y = lifeExp))+
  geom_boxplot()+
  geom_jitter()+
  ggtitle("Life Expectancy of Five Countries")+
  xlab("Country")+ 
  ylab("Life Expectancy")
  

  