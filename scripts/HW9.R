library(tidyverse)
surveys <- read.csv("data/portal_data_joined.csv")

for(i in unique(surveys$taxa)){
  mytaxon <- surveys %>% filter(taxa == i)
  print(i)
  myspecies <- unique(mytaxon$species)
  maxlength <- max(nchar(myspecies))
  
  print(mytaxon %>% filter(nchar(species) == maxlength) %>% 
    select(species) %>% unique())
  
}


mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

mycols <- mloa %>% select("windDir", "windSpeed_m_s", "baro_hPa", "temp_C_2m", "temp_C_10m", "temp_C_towertop", "rel_humid", "precip_intens_mm_hr")

mycols %>% map(max)
# map applies a function to every element of a vector. 

C_to_F <- function(x){
  x * 1.8 + 32
}

mloa <- mloa %>% mutate(temp_f_2m = C_to_F(temp_C_2m),
                temp_f_10m = C_to_F(temp_C_10m),
                temp_f_towertop = C_to_F(temp_C_towertop))

mloa$newcolumn <- C_to_F(mloa$temp_C_2m)


# Bonus using map_df
newmloa <- mloa %>% select("temp_C_2m",
                           "temp_C_10m",
                           "temp_C_towertop") %>% 
  map_df(., C_to_F) %>% rename("temp_F_2m" = "temp_C_2m",
                               "temp_F_10m" = "temp_C_10m",
                               "temp_F_towertop" = "temp_C_towertop") %>% 
  bind_cols(mloa)

#challenge
surveys %>% mutate(genusspecies = lapply(
  1:nrow(surveys), function(i){
    paste0(surveys$genus[i], " ", surveys$species[i])
  }
))
