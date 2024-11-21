mloa <- read.csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")
mloa 
#remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s
mloa_filtered <- mloa %>% 
  filter(rel_humid != -99) %>% 
  filter(temp_C_2m != -999.9) %>% 
  filter(windSpeed_m_s != -999.9) %>% 
  mutate(datetime = ymd_hm(paste0(year,"/", month, "/", day, "/", " ", hour24, ":", min), tz = "UTC")) %>% 
  mutate(datetimeLocal = with_tz(datetime, tz = "Pacific/Honolulu"))

mloa_filtered %>% 
  mutate(new_month = month(datetimeLocal, label = TRUE),
         new_hour = hour(datetimeLocal)) %>% 
  group_by(new_month, new_hour) %>% 
  summarize(mean_temp = mean(temp_C_2m)) %>% 
  ggplot(aes(x = new_month, y = mean_temp)) + 
           geom_point(aes(col = new_hour)) + 
           scale_color_viridis_c()
      

