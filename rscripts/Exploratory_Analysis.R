# Exploratory Analysis
# Packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(gganimate)

# import data
# set working path
setwd("~/Documents/GitHub/Spotify-Five-Year-Analysis-Project/data")

library(readr)
MasterChartTableRecoded <- read_csv("MasterChartTableRecoded.csv")
View(MasterChartTableRecoded)
# This data set is suitable for any analysis that does not require genre specifications or values
# This data set will be used to analyze release dates, artists, valence, and etc.

# see all column names
names(MasterChartTableRecoded)
# rename long column names
MasterChart <- rename(MasterChartTableRecoded, 
                      playlist = playlist_name,
                      album = album_name,
                      date = album_release_date,
                      album_artists_pop = album_artists_popularity,
                      track = track_name,
                      popularity = track_popularity,
                      track_artists_pop = track_artists_popularity,
                      explicit = track_explicit)
MasterChart

# remove columns unnecessary
MasterChart2 = subset(MasterChart, select = -c(X1, playlist_id, album_id, album_artists_ids,
                                               track_id, track_artists_ids))
MasterChart2
                      
# checking characteristics
class(MasterChart2)
#checking number of rows / columns
nrow(MasterChart2)
ncol(MasterChart2)                      
        #can be done all at one with dimension
dim(MasterChart2)

# Observe the structure of data: name of columns, data type in them etc.
str(MasterChart2)
                      
# Checking Head/Tail of data / setting second argument to 15 to observe first and last 15 rows of data
# head 
head(MasterChart2, 15)
# tail
tail(MasterChart2, 15)
                      
# Converting duration to minutes
MasterC3 <- MasterChart2 %>% mutate(duration_mins = duration_ms/60)
head(MasterC3)
# attemtping tp simplify minutes
MasterC4 <- MasterC3 %>% mutate(duration.m = duration_mins/60)
head(MasterC4)

# view update to data set
View(MasterC4)

# how many artists are in this data set ?
select(MasterC4, album_artists) %>% unique %>% nrow 
## [1] 308
# how many different dates represented in data set ?
select(MasterC4, date) %>% unique %>% nrow 
## [1] 356
# all dates
unique(MasterC4$date)

# import second data set, clean just like previous data set
library(readr)
AllChartAlbumTracksRecoded <- read_csv("AllChartAlbumTracksRecoded.csv")
View(AllChartAlbumTracksRecoded)






