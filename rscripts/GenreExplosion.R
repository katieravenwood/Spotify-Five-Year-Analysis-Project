# Script to explode genre columns out to separate rows

# Import primary data table
library(readr)
allchartalbumtracks <- read_csv("Documents/GitHub/Spotify-Five-Year-Analysis-Project/data/allchartalbumtracks.csv")
View(allchartalbumtracks)

# Rename  unnamed first index column
names(allchartalbumtracks)[1] <- 'first_index'

# Clean last manually added row
allchartalbumtracks$track_artists[8996] <- "['Mena Massoud']"
allchartalbumtracks$track_artists_ids[8996] <- "['0C8kbAJOGo7CHx8jDTyTfR']"
allchartalbumtracks$track_artists_genres[8996] <- "[['show tunes']]"
allchartalbumtracks$track_artists_popularity[8996] <- "['53']"
allchartalbumtracks$track_artists_followers[8996] <- "['16506']"

# Load tidyverse
install.packages("tidyverse")
library(tidyverse)

# 'track_artists', 'track_artists_ids', 'track_arists_genres', 'track_artists_popularity', 'track_artists_followers'

# Check column types
sapply(allchartalbumtracks, class)

# Convert to vector type.convert
avector <- as.vector(allchartalbumtracks['track_artists'])
class(avector) 

avector <- allchartalbumtracks[['track_artists']]
class(avector)

avector <- allchartalbumtracks[,5]
class(avector)
View(avector)

# Unnest 
tracks3 <- allchartalbumtracks %>% bind_rows(allchartalbumtracks) %>%    # make larger sample data
  mutate_if(is.list, simplify_all) %>%    # flatten each list element internally 
  unnest_longer(track_artists_genres)    # expand
