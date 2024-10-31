activity <- read.csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/refs/heads/main/data/tyler_activity_laps_10-24.csv")
running <- activity %>% filter(sport == "running") %>%  
  filter(minutes_per_mile < 10 & minutes_per_mile > 5) %>% 
  mutate(pace = case_when(
    minutes_per_mile < 6 ~ "fast",
    minutes_per_mile >= 6 & minutes_per_mile <= 8 ~ "medium",
    minutes_per_mile > 8 ~ "slow") )
running$form <- ifelse(running$year == 2024, yes = "new", no = "old")

average_steps <- running %>% 
  group_by(pace, form) %>% 
  summarize(average_steps = mean(steps_per_minute)) %>% 
  pivot_wider(id_cols = form, values_from = average_steps, names_from = pace) %>% 
  select(form, slow, medium, fast)
average_steps

comparison <- running %>% 
  filter(year == 2024) %>% 
  mutate(months = ifelse(month <= 6,'early 2024','late 2024')) %>% 
  group_by(months) %>% 
  summarize(minimum = min(steps_per_minute), mean = mean(steps_per_minute), median = median(steps_per_minute), maximum = max(steps_per_minute))

comparison


  