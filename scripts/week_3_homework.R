survey <- read.csv("data/portal_data_joined.csv")

surveys_base <- survey[c("species_id", "weight", "plot_type")]

surveys_base <- head(surveys_base, 5000)

surveys_base[c("species_id")] <- factor(surveys_base$species_id)
surveys_base[c("plot_type")] <- factor(surveys_base$plot_type)

surveys_base <- na.omit(surveys_base)

surveys_base
str(surveys_base)
levels(surveys_base$species_id)
levels(surveys_base$plot_type)
class(surveys_base$species_id[1])
# The factor is a different type of data that shows you the 
# levels first and lists out the level of each character instead of
# the actual character itself.

## It's nice that we can see the possible characters in each column
## and how many there are. 

challenge_base <- surveys_base[surveys_base$weight > 150,]
