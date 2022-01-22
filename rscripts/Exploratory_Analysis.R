# Exploratory Analysis
# Packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(gganimate)

# 3rd data set; Data sets 1 & 2 below with rest of script
# importing this data set to use re-coded year column and now added speechiness
library(readr)
AllTracksAndChartsJoined <- read_csv("~/Documents/GitHub/Spotify-Five-Year-Analysis-Project/data/AllTracksAndChartsJoined.csv")
View(AllTracksAndChartsJoined)
# rename data set
atcjoined <- AllTracksAndChartsJoined
names(atcjoined)

# mutate to get minutes
atcjoined2 <- atcjoined %>% mutate(duration_mins = duration_ms/60000)
View(atcjoined2)
# remove columns unnecessary
atcjoined3 = subset(atcjoined2, select = -c(X1, playlist_id, album_release_date, album_id, album_artist, track_id, track_artists_ids, 
                                            track_artists_genres, duration_ms, track_artist_id, 
                                            track_artists_genres_consolidate, track_artists,
                                            track_artists_followers, track_artists_popularity))
View(atcjoined3)

# reorder columns, organizes data set for easier read
col_order <- c("chart_position", "playlist_name",
               "album_name","track_name","track_artist", 
               "duration_mins", "release_year", 
               "release_date_datetime", "track_explicit",
               "track_popularity", "track_artist_popularity",
               "track_artist_followers", "danceability", "energy",
               "loudness", "liveness", "speechiness", "acousticness", "instrumentalness",
               "key", "mode", "tempo", "valence", "time_signature",
               "main_genre", "Rock", "Hip-hop", "Latin", "Christian",
               "Soul", "Jazz", "Funk", "R&B", "Show_tunes", "Misc",
               "Pop", "Edm", "Indie", "Country", "Metal", "Folk", 
               "Easy_listening", "Reggae", "No Genre Assigned")
atcjoined4 <- atcjoined3[, col_order]
View(atcjoined4)
# rename long column names: 
atcjoined5 <- rename(atcjoined4, 
                    chart = chart_position,
                    playlist = playlist_name,
                    album = album_name,
                    track = track_name,
                    artist = track_artist,
                    duration = duration_mins,
                    year = release_year,
                    date = release_date_datetime,
                    expicit = track_explicit,
                    track_pop = track_popularity,
                    artist_pop = track_artist_popularity,
                    artist_follows = track_artist_followers,
                    genre = main_genre,
                    no_genre = "No Genre Assigned")
View(atcjoined5)

# saving data set as csv
#write csv
write.csv(atcjoined5, "/Users/biancaabreu/Documents/GitHub/Spotify-Five-Year-Analysis-Project/data/\\ATACrejoined.csv", row.names = FALSE)


# IMPORT NEW CREATED DATA SET
#  IF STARTING FROM THIS POINT
# packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(gganimate)

# Data
library(readr)
ATACrejoined <- read_csv("Documents/GitHub/Spotify-Five-Year-Analysis-Project/data/ATACrejoined.csv")
View(ATACrejoined)
# ANALYSIS

## BOX PLOT

#Summary
# valence
boxplot(ATACrejoined$valence, col = "purple")
# loudness
boxplot(ATACrejoined$loudness, col = "red")
# tempo
boxplot(ATACrejoined$tempo, col = "black")
# energy
boxplot(ATACrejoined$energy, col = "blue")
# popularity
boxplot(ATACrejoined$track_pop, col = "pink")
# artist popularity
boxplot(ATACrejoined$artist_pop, col = "gold")
# artist following
boxplot(ATACrejoined$artist_follows, col = "red")
# speechiness
boxplot(ATACrejoined$speechiness, col = "purple")

## SCATTER PLOTS

# tempos | valence
with(ATACrejoined, plot(tempo, valence, xlab="Tempo", ylab="Valence"))
# tempo | energy
with(ATACrejoined, plot(tempo, energy, xlab="Tempo", ylab="Energy"))
# tempo | danceability
with(ATACrejoined, plot(tempo, danceability, xlab="Tempo", ylab="Danceability"))
# tempo | instrumentalness
with(ATACrejoined, plot(tempo, instrumentalness, xlab="Tempo", ylab="Instrumentalness"))

# STATIC PLOT
# Duration vs. Popularity, dimensions of tempo
static_dp <- ggplot(ATACrejoined) +  
  geom_point(mapping = aes(x = duration, y = track_pop, size=tempo), col=I("purple"), alpha=.4) + 
  labs(x = "Duration (mins)", y = "Popularity")
static_dp

# Popularity vs. Danceability, dimensions of valence
static_pd <- ggplot(ATACrejoined) +  
  geom_point(mapping = aes(x = track_pop, y = danceability, size=valence), col=I("purple"), alpha=.4) + 
  geom_smooth(mapping = aes(x = track_pop, y = danceability)) + 
  labs(x = "Track Popularity", y = "Danceability")
static_pd

# thinking if popularity is common among track and artist
# Track Popularity vs. Artist Popularity
static_pap <- ggplot(ATACrejoined) +  
  geom_point(mapping = aes(x = artist_pop, y = track_pop, col=I("pink"), alpha=.4)) + 
  geom_smooth(mapping = aes(x = artist_pop, y = track_pop)) + 
  labs(x = "Artist Popularity", y = "Track Popularity")
static_pap
#  adding valence as dimension
static_pap2 <- ggplot(ATACrejoined) +  
  geom_point(mapping = aes(x = artist_pop, y = track_pop, size=valence), col=I("pink"), alpha=.4) + 
  geom_smooth(mapping = aes(x = artist_pop, y = track_pop)) + 
  labs(x = "Artist Popularity", y = "Track Popularity")
static_pap2

# Valence vs. Loudness, dimensions of danceability
static_vl <- ggplot(ATACrejoined) +  
  geom_point(mapping = aes(x = valence, y = loudness, size=danceability), col=I("orange"), alpha=.4) + 
  geom_smooth(mapping = aes(x = valence, y = loudness)) + 
  labs(x = "Valence", y = "Loudness")
static_vl

# Speechiness vs. Liveness
static_sl <- ggplot(ATACrejoined) +  
  geom_point(mapping = aes(x = speechiness, y = liveness), col=I("orange"), alpha=.4) + 
  geom_smooth(mapping = aes(x = speechiness, y = liveness)) + 
  labs(x = "Speechiness", y = "Liveness")
static_sl

# acknowledging the concentration of danceability in the static_vl plot
# decided to explore that further

# boxplot summary: danceability
boxplot(ATACrejoined$danceability, col = "blue")

# to expand danceability join with genre
ggplot(data = ATACrejoined) +
  geom_point(mapping = aes(x = genre, y = danceability), col=I("brown"), alpha=.4) +
  labs(title = "Danceability vs. Genre", 
       x = "Genre", y = "Danceability")

# danceability with loudness to cross reference with genre
ggplot(data = ATACrejoined) +
  geom_point(mapping = aes(x = loudness, y = danceability), col=I("black"), alpha=.4) +
  geom_smooth(mapping = aes(x = loudness, y = danceability)) +
  labs(title = "Loudness vs. Danceabiliy", 
       x = "Loudness", y = "Danceability")

# scatter plot expanded on track popularity on valence
ggplot(data = ATACrejoined) +
  geom_point(mapping = aes(x = track_pop, y = valence), col=I("red"), alpha=.4) +
  labs(title = "Track Popularity vs. Valence", 
       x = "Popularity", y = "Valence")

# adding dimension with tempo
ggplot(data = ATACrejoined) +
  geom_point(mapping = aes(x = track_pop, y = valence, size=tempo), col=I("pink"), alpha=.4) +
  labs(title = "Popularity vs. Valence", 
       x = "Popularity", y = "Valence")

# Artist Popularity & Instrumentalness
ggplot(data = ATACrejoined) +
  geom_point(mapping = aes(x = artist_pop, y = instrumentalness), col=I("blue"), alpha=.4) +
  geom_smooth(mapping = aes(x = artist_pop, y = instrumentalness)) +
  labs(title = "Artist Popularity & Instrumentalness", 
       x = "Artist Popularity", y = "Intrumentalness")

# Loudness * Instrumentalness
ggplot(data = ATACrejoined) +
  geom_point(mapping = aes(x = instrumentalness, y = loudness), col=I("blue"), alpha=.4) +
  geom_smooth(mapping = aes(x = instrumentalness, y = loudness)) +
  labs(title = "Loudness & Instrumentalness", 
       x = "Instrumentalness", y = "Loudness")

# Danceability & Instrumentalness
ggplot(data = ATACrejoined) +
  geom_point(mapping = aes(x = danceability, y = loudness), col=I("red"), alpha=.4) +
  geom_smooth(mapping = aes(x = danceability, y = loudness)) +
  labs(title = "Danceability & Instrumentalness", 
       x = "Danceability", y = "Loudness")

# Danceability & Acousticness
ggplot(data = ATACrejoined) +
  geom_point(mapping = aes(x = danceability, y = acousticness), col=I("green"), alpha=.4) +
  geom_smooth(mapping = aes(x = danceability, y = acousticness)) +
  labs(title = "Danceability & Acousticness", 
       x = "Danceability", y = "Acousticness")



## FACETS

# Valence vs. Track popularity, dimensions of tempo, wrapped by Genre
ggplot(data = ATACrejoined) + 
  geom_point(mapping = aes(x = valence, y = track_pop, size=tempo), col=I("orange"), alpha=.4) + 
  geom_smooth(mapping = aes(x = valence, y = track_pop)) +
  facet_wrap(~ genre, ncol = 10)

# Valence vs. Energy, dimensions of Track Popularity, wrapped by Genre
ggplot(data = ATACrejoined) + 
  geom_point(mapping = aes(x = valence, y = energy, size=track_pop), col=I("purple"), alpha=.4) + 
  geom_smooth(mapping = aes(x = valence, y = energy)) +
  facet_wrap(~ genre, ncol = 10)

#interested how this looks with track pop & artist pop on valence
# Artist Pop vs. Track Pop, dimensions of Valence, wrapped by Genre
ggplot(data = ATACrejoined) + 
  geom_point(mapping = aes(x = artist_pop, y = track_pop, size=valence), col=I("blue"), alpha=.4) + 
  facet_wrap(~ genre, ncol = 10)

# Track Pop vs. Explicit Lyrics, dimensions in Track popularity, wrapped by Genre
ggplot(data = ATACrejoined) + 
  geom_point(mapping = aes(x = explicit, y = track_pop, size=track_pop), col=I("green"), alpha=.4) + 
  geom_smooth(mapping = aes(x = explicit, y = track_pop)) +
  facet_wrap(~ genre, ncol = 10)

# Track Popularity vs. Speechiness, dimensions in Track pop, wrapped in Genre
ggplot(data = ATACrejoined) +
  geom_point(mapping = aes(x = track_pop, y = speechiness, size = track_pop), col=I("red"), alpha=.3) +
  geom_smooth(mapping = aes(x = track_pop, y = speechiness)) +
  facet_wrap(~ genre, ncol = 10 )


## LINEAR REGRESSIONS

# Loudness ~ Energy, 
lmLE = lm(energy~loudness, data = ATACrejoined) 
summary(lmLE) 
# plot
ggplot(ATACrejoined, aes(x = loudness, y = energy)) +
  geom_point() + geom_smooth(method=lm, se=FALSE)
# Plot Flip, is loudness a good predictor of energy?
ggplot(ATACrejoined, aes(x = energy, y = loudness)) +
  geom_point() + geom_smooth(method=lm, se=FALSE)

# Valence ~ Energy
lmVE = lm(energy~valence, data = ATACrejoined) 
summary(lmVE) 
# plot
ggplot(ATACrejoined, aes(x = valence, y = energy)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "goldenrod2")
# Plot Flip, is valence a good predictor of energy?
ggplot(ATACrejoined, aes(x = energy, y = valence)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "goldenrod2")

# Valence ~ Danceability
lmVD = lm(danceability~valence, data = ATACrejoined) 
summary(lmVD) 
# plot
ggplot(ATACrejoined, aes(x = valence, y = danceability)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "pink")
# Plot Flip, is valence a good predictor of danceability?
ggplot(ATACrejoined, aes(x = danceability, y = valence)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "pink")

# Track Popularity & Explicit Tracks
lmTPE = lm(explicit~track_pop, data = ATACrejoined) 
summary(lmTPE) 
# plot
ggplot(ATACrejoined, aes(x = track_pop, y = explicit)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "green")

# Artist Popularity ~ Track Popularity
lmAPTP = lm(track_pop~artist_pop, data = ATACrejoined) 
summary(lmAPTP) 
# plot
ggplot(ATACrejoined, aes(x = artist_pop, y = track_pop)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "orange")
# Plot Flip, is artist pop a good predictor of track pop?
ggplot(ATACrejoined, aes(x = track_pop, y = artist_pop)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "orange")

# Track Popularity ~ Speechiness
lmSTP = lm(speechiness~track_pop, data = ATACrejoined) 
summary(lmSTP)
# plot
ggplot(ATACrejoined, aes(x = track_pop, y = speechiness)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "pink")

## CORRELATION
library(corrplot)
library(PerformanceAnalytics)
# Loudness & Energy
cor.test(ATACrejoined$loudness, ATACrejoined$energy, method="pearson", use = "complete.obs")

# Loudness & Danceability
cor.test(ATACrejoined$loudness, ATACrejoined$danceability, method="pearson", use = "complete.obs")

# Loudness & Valence
cor.test(ATACrejoined$loudness, ATACrejoined$valence, method="pearson", use = "complete.obs")

# Energy & Liveness
cor.test(ATACrejoined$energy, ATACrejoined$liveness, method="pearson", use = "complete.obs")

# Artist Popularity & Track Popularity
cor.test(ATACrejoined$artist_pop, ATACrejoined$track_pop, method="pearson", use = "complete.obs")

# Track Popularity & Duration
cor.test(ATACrejoined$track_pop, ATACrejoined$duration, method="pearson", use = "complete.obs")

# Track Popularity & Speechiness
cor.test(ATACrejoined$track_pop, ATACrejoined$speechiness, method="pearson", use = "complete.obs")

# Correlation Matrices
acatmatrice <- ATACrejoined[, c(10, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23 )]
acatmatrice
# chart matrice
chart.Correlation(acatmatrice, histogram=FALSE, method="pearson")
# correlation matrix
corr_matrix <- cor(acatmatrice)
corr_matrix
# Corrplot
corrplot(corr_matrix, type="lower", order="hclust", p.mat = corr_matrix,
         sig.level = 0.05, insig="blank")
# used .05 to get more findings






                           ##### NOT FOR USE #####

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

# mutate to get minutes
MasterC3 <- MasterC2 %>% mutate(duration_mins = duration_ms/60000)
View(MasterC3)
# to get album minutes sum up by album id

# Checking Head/Tail of data / setting second argument to 15 to observe first and last 15 rows of data
# head 
View(head(MasterC3, 15))
# tail
View(tail(MasterC3, 15))

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
AllTracks3 <- AllTracks2 %>% mutate(duration_mins = duration_ms/60000)
View(AllTracks3)

# Checking Head/Tail of data / setting second argument to 15 to observe first and last 15 rows of data
# head 
View(head(AllTracks3, 15))
# tail
View(tail(AllTracks3, 15))

# data set: 1
# how many artists are in this data set ?
select(MasterC3, album_artists) %>% unique %>% nrow 
## [1] 308
# how many different dates represented in data set ?
select(MasterC3, date) %>% unique %>% nrow 
## [1] 356
# all dates
unique(MasterC3$date)

ranking <- arrange(MasterC3, desc(position))
head(ranking, 10)


#creating and printing histograms
hist_ <- AllTracks3 %>% ggplot(aes(valence)) +
  geom_histogram(binwidth=0.01, fill=I("blue"), col=I("pink"), alpha=.6) +
  labs(x = "Valence", y = "Number of Tracks")
hist_


hist_p <- MasterC3 %>% ggplot(aes(position)) +
  geom_histogram(binwidth=0.01, fill=I("blue"), col=I("pink"), alpha=.6) +
  labs(x = "Position", y = "Number")
hist_p
#unusable
hist_d <- MasterC3 %>% ggplot(aes(date)) +
  geom_histogram(binwidth=0.01, fill=I("blue"), col=I("pink"), alpha=.6) +
  labs(x = "date", y = "")
hist_d

# summary info: creating and printing the boxplot for song valence
boxplot(AllTracks3$valence, col = "blue")
# summary info: creating and printing the boxplot for song loudness
boxplot(AllTracks3$loudness, col = "red")

# scatter plot: tempos affect on valence
with(AllTracks3, plot(tempo, valence, xlab="Tempo", ylab="Valence"))

# to expand tempo on valence
ggplot(data = AllTracks3) +
  geom_point(mapping = aes(x = tempo, y = valence), col=I("red"), alpha=.4) +
  labs(title = "Tempo vs. Valence", 
       x = "Tempo", y = "Valence")

# scatterplot expanded on track popularity on valence
ggplot(data = AllTracks3) +
  geom_point(mapping = aes(x = track_pop, y = valence), col=I("brown"), alpha=.4) +
  labs(title = "Track Popularity vs. Valence", 
       x = "Popularity", y = "Valence")

# adding dimension with tempo
ggplot(data = AllTracks3) +
  geom_point(mapping = aes(x = track_pop, y = valence, size=tempo), col=I("pink"), alpha=.4) +
  labs(title = "Popularity vs. Valence", 
       x = "Popularity", y = "Valence")


# over time
ggplot(data = MasterC3) +
  geom_point(mapping = aes(x = date, y = duration_mins), col=I("blue"), alpha=.4) +
  geom_smooth(mapping = aes(x = date, y = duration_mins)) + 
  labs(title = "Date vs Minutes", 
       x = "Dates", y = "Minutes")

# splitting into facets, seeing individual affects of valence on popularity, categorizing by genre
ggplot(data = AllTracks3) + 
  geom_point(mapping = aes(x = valence, y = track_pop, size=tempo), col=I("orange"), alpha=.4) + 
  facet_wrap(~ genres, ncol = 10)
# splitting into facets, seeing individual affects of valence on tempo, categorizing by genre
ggplot(data = AllTracks3) + 
  geom_point(mapping = aes(x = valence, y = tempo, size=tempo), col=I("purple"), alpha=.4) + 
  facet_wrap(~ genres, ncol = 10)
# splitting into facets, seeing individual affects of energy on valence, categorizing by genre
ggplot(data = AllTracks3) + 
  geom_point(mapping = aes(x = energy, y = valence, size=tempo), col=I("red"), alpha=.4) + 
  facet_wrap(~ genres, ncol = 10)


#static plot
b <- ggplot(MasterC3) +  
  geom_point(mapping = aes(x = duration.m, y = popularity, size=tempo), col=I("blue"), alpha=.4) + 
  labs(x = "Duration (mins)", y = "Popularity")
b

#trying a transition plot
b + transition_time(date) +
  labs(title = "Release Dates: {frame_time}")




   ########

# merge data
ChartMaster <- merge(MasterC3, AllTracks3, by.c =c('playlis', 'position', 'album', 'date', 'album_artists',
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

# creating date/times
library(tidyverse)
library(lubridate)
# convert date info in format 'mm/dd/yyyy'
strDates <- c("01/05/1965", "08/16/1975")
dates <- as.Date(strDates, "%m/%d/%Y")

atcjoined5$date <- as_date(atcjoined5$date)

atcjoined5$date <- mdy(atcjoined5$date)

atcjoined5 <- atcjoined5 %>%
  mutate(date = recode(date, as.Date(x, format = %d,%m,%Y))) 


# HEAT MAP
# Track Popularity by Genre
ggplot(ACATjoined, aes(x = genre, y = track_pop, fill = valence)) +
  geom_tile(color = "Blue") +
  scale_fill_gradient(low = "white", high = "purple") +
  coord_fixed()
#unusable heat map coding