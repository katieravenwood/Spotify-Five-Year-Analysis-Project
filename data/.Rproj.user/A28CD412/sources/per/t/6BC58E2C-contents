# Exploratory Analysis
# Packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(gganimate)

# import first data data:1
# set working path
setwd("~/Documents/GitHub/Spotify-Five-Year-Analysis-Project/data")

library(readr)
MasterChartTableRecoded <- read_csv("MasterChartTableRecoded.csv")
View(MasterChartTableRecoded)
# This data set is suitable for any analysis that does not require genre specifications or values
# This data set will be used to analyze release dates, artists, valence, and etc.

# see all column names: 1
names(MasterChartTableRecoded)
# rename long column names:1
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

# remove columns unnecessary: 2
MasterC2 = subset(MasterChart, select = -c(X1, playlist_id, album_id, album_artists_ids, track_id,
                                           track_artists_ids))
MasterC2
View(MasterC2)
# Observe the structure of data: name of columns, data type in them etc.: 1
str(MasterC2)
# checking characteristics: 1
class(MasterC2)
#can be done all at one with dimension
dim(MasterC2)

# Converting duration to minutes: 1
MasterC3 <- MasterC2 %>% mutate(duration_mins = duration_ms/60)
View(MasterC3)
# attempting to simplify minutes
MasterC4 <- MasterC3 %>% mutate(duration.m = duration_mins/60)
# View updated data set
View(MasterC4)

# Checking Head/Tail of data / setting second argument to 15 to observe first and last 15 rows of data
# head 
View(head(MasterC4, 15))
# tail
View(tail(MasterC4, 15))



# import second data set: 2
library(readr)
AllChartAlbumTracksRecoded <- read_csv("AllChartAlbumTracksRecoded.csv")
View(AllChartAlbumTracksRecoded)
# This data set does have genre information necessary and is recoded 

# see all column names: 2
names(AllChartAlbumTracksRecoded)
# rename long column names: 2
AllTracks <- rename(AllChartAlbumTracksRecoded, 
                     track = track_name,
                     track_pop = track_popularity,
                     artists = track_artists,
                     artists_ids = track_artists_ids,
                     artists_pop = track_artists_popularity,
                     explicit = track_explicit,
                     artists_follows = track_artists_followers,
                     album = album_name,
                     artist = track_artist,
                     artist_id = track_artist_id,
                     artist_pop = track_artist_popularity,
                     artist_follows = track_artist_followers,
                     genres = main_genre)
AllTracks

# remove columns unnecessary: 2
AllTracks2 = subset(AllTracks, select = -c(X1, mode, track_artists_genres_consolidate))
View(AllTracks2)

# Observe the structure of data: name of columns, data type in them etc.: 2
str(AllTracks2)
# checking characteristics: 2
class(AllTracks2)
#can be done all at one with dimension
dim(AllTracks2)

# Converting duration to minutes: 2
AllTracks3 <- AllTracks2 %>% mutate(duration_mins = duration_ms/60)
View(AllTracks3)
# re-converting: 2
AllTracks4 <- AllTracks3 %>% mutate(duration.m = duration_mins/60)
# View updated data set
View(AllTracks4)

# Checking Head/Tail of data / setting second argument to 15 to observe first and last 15 rows of data
# head 
View(head(AllTracks3, 15))
# tail
View(tail(AllTracks3, 15))

# data set: 1
# how many artists are in this data set ?
select(MasterC4, album_artists) %>% unique %>% nrow 
## [1] 308
# how many different dates represented in data set ?
select(MasterC4, date) %>% unique %>% nrow 
## [1] 356
# all dates
unique(MasterC4$date)

ranking <- arrange(MasterC4, desc(position))
head(ranking, 10)


#creating and printing histograms
hist_ <- AllTracks4 %>% ggplot(aes(valence)) +
  geom_histogram(binwidth=0.01, fill=I("blue"), col=I("pink"), alpha=.6) +
  labs(x = "Valence", y = "Number of Tracks")
hist_

hist_p <- MasterC4 %>% ggplot(aes(position)) +
  geom_histogram(binwidth=0.01, fill=I("blue"), col=I("pink"), alpha=.6) +
  labs(x = "Position", y = "Number")
hist_p
#unusable


hist_d <- MasterC4 %>% ggplot(aes(date)) +
  geom_histogram(binwidth=0.01, fill=I("blue"), col=I("pink"), alpha=.6) +
  labs(x = "date", y = "")
hist_d

# summary info: creating and printing the boxplot for song valence
boxplot(AllTracks4$valence, col = "blue")

# scatter plot: tempos affect on valence
with(AllTracks4, plot(tempo, valence, xlab="Tempo", ylab="Valence"))

# to expand tempo on valence
ggplot(data = AllTracks4) +
  geom_point(mapping = aes(x = tempo, y = valence), col=I("red"), alpha=.4) +
  labs(title = "Tempo vs. Valence", 
       x = "Tempo", y = "Valence")

# scatterplot expanded on track popularity on valence
ggplot(data = AllTracks4) +
  geom_point(mapping = aes(x = track_pop, y = valence), col=I("brown"), alpha=.4) +
  labs(title = "Track Popularity vs. Valence", 
       x = "Popularity", y = "Valence")

# adding dimension with tempo
ggplot(data = AllTracks4) +
  geom_point(mapping = aes(x = track_pop, y = valence, size=tempo), col=I("pink"), alpha=.4) +
  labs(title = "Popularity vs. Valence", 
       x = "Popularity", y = "Valence")


# over time
ggplot(data = MasterC4) +
  geom_point(mapping = aes(x = date, y = duration.m), col=I("blue"), alpha=.4) +
  geom_smooth(mapping = aes(x = date, y = duration.m)) + 
  labs(title = "Date vs Minutes", 
       x = "Dates", y = "Minutes")

# splitting into facets, seeing individual affects of valence on popularity, categorizing by genre
ggplot(data = AllTracks4) + 
  geom_point(mapping = aes(x = valence, y = track_pop, size=tempo), col=I("orange"), alpha=.4) + 
  facet_wrap(~ genres, ncol = 10)
# splitting into facets, seeing individual affects of valence on tempo, categorizing by genre
ggplot(data = AllTracks4) + 
  geom_point(mapping = aes(x = valence, y = tempo, size=tempo), col=I("purple"), alpha=.4) + 
  facet_wrap(~ genres, ncol = 10)
# splitting into facets, seeing individual affects of energy on valence, categorizing by genre
ggplot(data = AllTracks4) + 
  geom_point(mapping = aes(x = energy, y = valence, size=tempo), col=I("red"), alpha=.4) + 
  facet_wrap(~ genres, ncol = 10)


#static plot
b <- ggplot(MasterC4) +  
  geom_point(mapping = aes(x = duration.m, y = popularity, size=tempo), col=I("blue"), alpha=.4) + 
  labs(x = "Duration (mins)", y = "Popularity")
b

#trying a transition plot
b + transition_time(date) +
  labs(title = "Release Dates: {frame_time}")



### NOT FOR USE 

# merge data
ChartMaster <- merge(MasterC4, AllTracks3, by.c =c('playlis', 'position', 'album', 'date', 'album_artists',
                                                   'album_artists_pop', 'album_artists_followers', 'track',
                                                   'popularity', 'track_artists', 'explicit', 'danceability', 
                                                   'energy', 'key', 'loudness', 'acousticness', 'instrumentalness',
                                                   'liveness', 'valence', 'tempo', 'album_artst',
                                                   'track_id', 'track_pop', 'artists', 'artists_ids',
                                                   'artists_pop', 'explicit', 'artists_follows', 'album_id',
                                                   'danceability', 'energy', 'key', 'loudness', 'acousticness',
                                                   'instrumentalness', 'liveness', 'valence', 'tempo',
                                                   'artist', 'artist_id', 'artist_pop', 'artist_follows',
                                                   'genres', 'Misc', 'Rock', 'Pop', 'Hip-hop', 'Edm',
                                                   'Latin', 'Indie', 'Christian', 'Country', 'Soul', 'Metal',
                                                   'Jazz', 'Folk', 'Funk', 'Easy_listening', 'R&B', 'Reggae',
                                                   'Show_tunes', 'duration.m'), all.x=T)
ChartMaster
View(ChartMaster)




