gapminder <- read.csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv")
pop_growth <- gapminder %>% 
  group_by(country, year, pop, continent) %>% 
  summarize() %>% 
  filter(year == 2002 | year == 2007) %>% 
  pivot_wider(names_from = year, values_from = pop, names_prefix = "year") %>%    mutate(pop_diff = year2007 - year2002) %>% 
  arrange(continent)

pop_growth

pop_growth %>% 
  filter(continent != "Oceania") %>% 
  ggplot(aes(x = reorder(country, pop_diff), y = pop_diff )) +
  geom_col(aes(fill = continent)) +
  facet_wrap(~continent, scales = "free") +
  scale_fill_viridis_d() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")+
  xlab("Country") +
  ylab("Change in Population Between 2002 and 2007") 

# That was exhausting.



