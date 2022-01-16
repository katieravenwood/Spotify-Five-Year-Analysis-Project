# Katie R Sandbox

## This file is not intended to be run top to bottom!


#### ======================================================
# Script to explode artist & genre columns out to separate rows

# Import primary data table
library(readr)
allchartalbumtracks <- read_csv("../data/AllChartAlbumTracksRecoded.csv")
View(allchartalbumtracks)

# Rename  unnamed first index column
names(allchartalbumtracks)[1] <- 'first_index'

# Clean last manually added row which needs square brackets to match the other rows (from old)
# allchartalbumtracks$track_artists[8996] <- "['Mena Massoud']"
# allchartalbumtracks$track_artists_ids[8996] <- "['0C8kbAJOGo7CHx8jDTyTfR']"
# allchartalbumtracks$track_artists_genres[8996] <- "[['show tunes']]"
# allchartalbumtracks$track_artists_popularity[8996] <- "['53']"
# allchartalbumtracks$track_artists_followers[8996] <- "['16506']"
# 
# Load tidyverse
library(tidyverse)

# Columns that need to be exploded and have their values stay related:
# 'track_artists', 'track_artists_ids', 'track_arists_genres', 'track_artists_popularity', 'track_artists_followers'

# Check column types
str(allchartalbumtracks)

# This example pipe will explode out the various columns, but just creates duplicate
# rows for every explosion, associating the wrong info with the artists as well
# as the right info.
allchartalbumtrackspipe = allchartalbumtracks %>% separate_rows(track_artists, sep = "', '") %>% separate_rows(track_artists_ids, sep = "', '")
View(allchartalbumtrackspipe)

# I also tried unnest_longer, but couldn't quite figure out how to work that for the
# associated columns. In the process, I found:

# separate_rows to make new rows from nested columns
cols <- c("track_artists", "track_artists_ids", "track_artists_genres", "track_artists_popularity", "track_artists_followers")

for (col in cols) {
  allchartalbumtracksexploded <- separate_rows_(allchartalbumtracks, col, sep = "', '")
}

# separate rows is the closest I've come but I still need to work on the
# separator syntax so it doesn't automatically separate at first and last names
# xD

# Testing for possibilities on how to return the contents of a cell so it's
# recognized as a list
allchartalbumtracks$track_artists[8]
# Is length the best way to check for number of items in a list for a for loop?
print(lengths(allchartalbumtracks$track_artists[8]))

