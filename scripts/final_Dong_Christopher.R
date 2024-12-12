laps <- read.csv("https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv")

running_laps <- laps %>% 
  filter(sport == "running") %>% 
  filter(minutes_per_mile <= 10) %>% 
  filter(minutes_per_mile >= 5) %>% 
  filter(total_elapsed_time_s > 60) %>% 
  mutate(time_period = case_when(
    year != 2024 ~ "pre-2024",
    year = 2024 & month <= 6 ~ "Jan-Jun",
    year = 2024 & month > 6 ~ "Jul-Dec"
  ))  
  #I am not sure what question 4 is asking for exactly.
  
#For question 5, I am assuming strides per minute is steps_per_minute and speed by lap is minutes_per_mile. 

ggplot(running_laps, aes(x = steps_per_minute, y = minutes_per_mile, color = time_period)) +
 geom_point(size = .2, alpha = .6) + 
 theme_classic() + 
 ggtitle("Speed Compared to Steps per Minute") + 
 xlab("Minutes per mile") + ylab("Steps per minute") + 
 geom_smooth(method = "lm", aes(group = time_period))
# I lost a lot of time because I didn't realize that you can't have any scale colors like scale_color_viridis when mapping color to a discrete value.  

#I see that question 8 explains what speed by lap is supposed to mean. I don't have the mental capacity nor time to finish this question. I assume you would first filter out the Jul-Dec runs, and then mutate a new column using the rank function to assign a lap number to each timestamp on each day. Then you would filter for laps 1-3. I would make a scatterplot with x = steps_per_minute, y = minutes_per_mile and color by lap with corresponding trend lines to see if the trendlines are significantly different. 



