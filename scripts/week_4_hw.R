library(tidyverse)
surveys <- read.csv("data/portal_data_joined.csv")

#Subset surveys using Tidyverse methods to keep rows with
#weight between 30 and 60, and print out the first 6 rows.

surveys_subset <- surveys %>% 
  filter(weight > 30 & weight < 60) 
  
head(surveys_subset)

#Create a new tibble showing the maximum weight for each 
#species + sex combination and name it biggest_critters. 
#Sort the tibble to take a look at the biggest and smallest
#species + sex combinations. 
#HINT: it’s easier to calculate max if there are no NAs in the dataframe…

biggest_critters <- surveys %>% 
   filter(!is.na(weight)) %>% 
   group_by(species_id, sex) %>% 
   summarize(max_weight = max(weight))

biggest_critters  
biggest_critters %>% arrange(max_weight)
biggest_critters %>% arrange(desc(max_weight))


#Try to figure out where the NA weights are concentrated in the 
#data- is there a particular species, taxa, plot, or whatever, 
#where there are lots of NA values? 

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(species) %>% 
  tally() %>% 
  arrange(desc(n))

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(plot_id) %>% 
  tally() %>% 
  arrange(desc(n))

#Take surveys, remove the rows where weight is NA and add a column 
#that contains the average weight of each species+sex combination
#to the full surveys dataframe. Then get rid of all the columns 
#except for species, sex, weight, and your new average weight column. 
#Save this tibble as surveys_avg_weight.
  
surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(average_weights = mean(weight)) %>% 
  select(species_id, sex, weight, average_weights)
surveys_avg_weight

#Take surveys_avg_weight and add a new column called above_average 
#that contains logical values stating whether or not a row’s weight 
#is above average for its species+sex combination 
#(recall the new column we made for this tibble).

surveys_avg_weight <- surveys_avg_weight %>% 
  group_by(species_id, sex) %>% 
  mutate(above_avg = weight > average_weights)
surveys_avg_weight     

print(surveys_avg_weight, n = 100)
