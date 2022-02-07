# packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(gganimate)

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
atcjoined3 = subset(atcjoined2, select = -c(X1, playlist_id, album_release_date, album_id, album_artist,   track_id, track_artists_ids, track_artists_genres, duration_ms, track_artist_id, track_artists_genres_consolidate, track_artists, track_artists_followers, track_artists_popularity))
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
                     explicit = track_explicit,
                     track_pop = track_popularity,
                     artist_pop = track_artist_popularity,
                     artist_follows = track_artist_followers,
                     genre = main_genre,
                     no_genre = "No Genre Assigned")
View(atcjoined5)

# saving data set as csv for easier import when running code
#write csv
write.csv(atcjoined5, "/Users/biancaabreu/Documents/GitHub/Spotify-Five-Year-Analysis-Project/data/\\atacjoin.csv", row.names = FALSE)


# Data
library(readr)
atacjoin <- read_csv("Documents/GitHub/Spotify-Five-Year-Analysis-Project/data/atacjoin.csv")
View(atacjoin)

# BEGINNING ANALYSIS
## BOX PLOT SUMMARY
# To explore the data running some box plots to get an idea as to what is there

# valence
boxplot(atacjoin$valence, col = "purple")
# avg is between .4-.6 however the data measure fall within .2-.8

# loudness
boxplot(atacjoin$loudness, col = "red")
# data measure fall within -10 - 0, avg falls anywhere after -5 and outliers about -12 - -30

# tempo
boxplot(atacjoin$tempo, col = "blue")
# avg between 100 & 150, data measure between 50 - 150

# energy
boxplot(atacjoin$energy, col = "blue")
# popularity
boxplot(atacjoin$track_pop, col = "pink")
# artist popularity
boxplot(atacjoin$artist_pop, col = "gold")
# artist following
boxplot(atacjoin$artist_follows, col = "red")
# speechiness
boxplot(atacjoin$speechiness, col = "purple")
# boxplot summary: danceability
boxplot(atacjoin$danceability, col = "blue")

# checking for normal probability
# valence check
ggplot(atacjoin, aes(sample = valence)) + geom_qq()
# energy check
ggplot(atacjoin, aes(sample = energy)) + geom_qq()
# loudness
ggplot(atacjoin, aes(sample = loudness)) + geom_qq()
# speechiness
ggplot(atacjoin, aes(sample = speechiness)) + geom_qq()


# Cartesian coordinate system
# Valence & Genre
ggplot(data = atacjoin, mapping = aes(x = genre, y = valence)) +
  geom_boxplot()
ggplot(data = atacjoin, mapping = aes(x = genre, y = valence)) +
  geom_boxplot()+
  coord_flip()

# Valence & Energy
ggplot(data = atacjoin, mapping = aes(x = energy, y = valence)) +
  geom_boxplot()

# Energy & Genre
ggplot(data = atacjoin, mapping = aes(x = genre, y = energy)) +
  geom_boxplot()
ggplot(data = atacjoin, mapping = aes(x = genre, y = energy)) +
  geom_boxplot()+
  coord_flip()

# Energy & Loudness
ggplot(data = atacjoin, mapping = aes(x = energy, y = loudness)) +
  geom_boxplot()

# Loudness & Genre
ggplot(data = atacjoin, mapping = aes(x = genre, y = loudness)) +
  geom_boxplot()
ggplot(data = atacjoin, mapping = aes(x = genre, y = loudness)) +
  geom_boxplot()+
  coord_flip()

# Valence & Loudness
ggplot(data = atacjoin, mapping = aes(x = valence, y = loudness)) +
  geom_boxplot()


## SCATTER PLOTS

# tempos | valence
with(atacjoin, plot(tempo, valence, xlab="Tempo", ylab="Valence"))
# tempo | energy
with(atacjoin, plot(tempo, energy, xlab="Tempo", ylab="Energy"))
# tempo | danceability
with(atacjoin, plot(tempo, danceability, xlab="Tempo", ylab="Danceability"))
# tempo | instrumentalness
with(atacjoin, plot(tempo, instrumentalness, xlab="Tempo", ylab="Instrumentalness"))

## PLOTS

# Duration vs. Track Popularity, dimensions of tempo
ggplot(atacjoin) +  
  geom_point(mapping = aes(x = duration, y = track_pop, size=tempo), col=I("purple"), alpha=.4) + 
  labs(x = "Duration (mins)", y = "Popularity")


# Track Popularity vs. Danceability, dimensions of valence
ggplot(atacjoin) +  
  geom_point(mapping = aes(x = track_pop, y = danceability, size=valence), col=I("purple"), alpha=.4) + 
  geom_smooth(mapping = aes(x = track_pop, y = danceability)) + 
  labs(x = "Track Popularity", y = "Danceability")


# thinking if popularity is common among track pop and artist pop
# Track Popularity vs. Artist Popularity
ggplot(atacjoin) +  
  geom_point(mapping = aes(x = artist_pop, y = track_pop, col=I("pink"), alpha=.4)) + 
  geom_smooth(mapping = aes(x = artist_pop, y = track_pop)) + 
  labs(x = "Artist Popularity", y = "Track Popularity")

#  adding valence as dimension
ggplot(atacjoin) +  
  geom_point(mapping = aes(x = artist_pop, y = track_pop, size=valence), col=I("pink"), alpha=.4) + 
  geom_smooth(mapping = aes(x = artist_pop, y = track_pop)) + 
  labs(x = "Artist Popularity", y = "Track Popularity")

# Valence vs. Loudness, dimensions of danceability
ggplot(atacjoin) +  
  geom_point(mapping = aes(x = valence, y = loudness, size=danceability), col=I("orange"), alpha=.4) + 
  geom_smooth(mapping = aes(x = valence, y = loudness)) + 
  labs(x = "Valence", y = "Loudness")


# Speechiness vs. Liveness
ggplot(atacjoin) +  
  geom_point(mapping = aes(x = speechiness, y = liveness), col=I("orange"), alpha=.4) + 
  geom_smooth(mapping = aes(x = speechiness, y = liveness)) + 
  labs(x = "Speechiness", y = "Liveness")


# acknowledging the concentration of danceability in the static_vl plot
# decided to explore that further

# to expand danceability join with genre
ggplot(data = atacjoin) +
  geom_point(mapping = aes(x = genre, y = danceability), col=I("brown"), alpha=.4) +
  labs(title = "Danceability vs. Genre", 
       x = "Genre", y = "Danceability")

# danceability with loudness to cross reference with genre
ggplot(data = atacjoin) +
  geom_point(mapping = aes(x = loudness, y = danceability), col=I("pink"), alpha=.4) +
  geom_smooth(mapping = aes(x = loudness, y = danceability)) +
  labs(title = "Loudness vs. Danceabiliy", 
       x = "Loudness", y = "Danceability")

# Valence & loudness
ggplot(data = atacjoin) +
  geom_point(mapping = aes(x = valence, y = loudness), col=I("orange"), alpha=.4) +
  geom_smooth(mapping = aes(x = valence, y = loudness)) +
  labs(title = "Valence & Loudness", 
       x = "Valence", y = "Loudness")

# scatter plot expanded on track popularity on valence
ggplot(data = atacjoin) +
  geom_point(mapping = aes(x = track_pop, y = valence), col=I("red"), alpha=.4) +
  labs(title = "Track Popularity vs. Valence", 
       x = "Popularity", y = "Valence")

# adding dimension with tempo
ggplot(data = atacjoin) +
  geom_point(mapping = aes(x = track_pop, y = valence, size=tempo), col=I("pink"), alpha=.4) +
  labs(title = "Popularity vs. Valence", 
       x = "Popularity", y = "Valence")

# danceability w/ energy sized tempo
ggplot(data = atacjoin) +
  geom_point(mapping = aes(x = danceability, y = energy, size=tempo), col=I("orange"), alpha=.4) +
  geom_smooth(mapping = aes(x = danceability, y = energy)) +
  labs(title = "Danceability & Energy", 
       x = "Danceability", y = "Energy")

# Artist Popularity & Instrumentalness
ggplot(data = atacjoin) +
  geom_point(mapping = aes(x = artist_pop, y = instrumentalness), col=I("blue"), alpha=.4) +
  geom_smooth(mapping = aes(x = artist_pop, y = instrumentalness)) +
  labs(title = "Artist Popularity & Instrumentalness", 
       x = "Artist Popularity", y = "Intrumentalness")

# Loudness & Instrumentalness
ggplot(data = atacjoin) +
  geom_point(mapping = aes(x = instrumentalness, y = loudness), col=I("blue"), alpha=.4) +
  geom_smooth(mapping = aes(x = instrumentalness, y = loudness)) +
  labs(title = "Loudness & Instrumentalness", 
       x = "Instrumentalness", y = "Loudness")

# Danceability & Instrumentalness
ggplot(data = atacjoin) +
  geom_point(mapping = aes(x = danceability, y = loudness), col=I("red"), alpha=.4) +
  geom_smooth(mapping = aes(x = danceability, y = loudness)) +
  labs(title = "Danceability & Instrumentalness", 
       x = "Danceability", y = "Loudness")

# Danceability & Acousticness
ggplot(data = atacjoin) +
  geom_point(mapping = aes(x = danceability, y = acousticness), col=I("green"), alpha=.4) +
  geom_smooth(mapping = aes(x = danceability, y = acousticness)) +
  labs(title = "Danceability & Acousticness", 
       x = "Danceability", y = "Acousticness")

# Acousticness & Energy
ggplot(atacjoin, aes(x = acousticness, y = energy)) +
  + geom_point() + geom_smooth(method=lm, se=FALSE, color = "orange")


# Still working this plot out
ggplot(data = atacjoin, mapping = aes(x = energy, y = loudness)) +
  geom_point(mapping = aes(color = genre)) +
  geom_smooth(
    data = filter(atacjoin, class == genre),
    se = FALSE
  )


## FACETS

# Valence vs. Track popularity, dimensions of tempo, wrapped by Genre
ggplot(data = atacjoin) + 
  geom_point(mapping = aes(x = valence, y = track_pop, size=tempo), col=I("orange"), alpha=.4) + 
  geom_smooth(mapping = aes(x = valence, y = track_pop)) +
  facet_wrap(~ genre, ncol = 10)

# Valence vs. Energy, dimensions of Track Popularity, wrapped by Genre
ggplot(data = atacjoin) + 
  geom_point(mapping = aes(x = valence, y = energy, size=track_pop),col=I("orange"), alpha=.4) + 
  geom_smooth(mapping = aes(x = valence, y = energy)) +
  facet_wrap(~ genre, ncol = 10)

# Loudness vs. Energy, dimensions of Track Popularity, wrapped by Genre
ggplot(data = atacjoin) + 
  geom_point(mapping = aes(x = loudness, y = energy, size=track_pop),col=I("red"), alpha=.4) + 
  geom_smooth(mapping = aes(x = loudness, y = energy)) +
  facet_wrap(~ genre, ncol = 10)


#interested how this looks with track pop & artist pop on valence
# Artist Pop vs. Track Pop, dimensions of Valence, wrapped by Genre
ggplot(data = atacjoin) + 
  geom_point(mapping = aes(x = artist_pop, y = track_pop, size=valence), col=I("blue"), alpha=.4) + 
  facet_wrap(~ genre, ncol = 10)

# Track Pop vs. Explicit Lyrics, dimensions in Track popularity, wrapped by Genre
ggplot(data = atacjoin) + 
  geom_point(mapping = aes(x = explicit, y = track_pop, size=track_pop), col=I("green"), alpha=.4) + 
  geom_smooth(mapping = aes(x = explicit, y = track_pop)) +
  facet_wrap(~ genre, ncol = 10)

# Track Popularity vs. Speechiness, dimensions in Track pop, wrapped in Genre
ggplot(data = atacjoin) +
  geom_point(mapping = aes(x = track_pop, y = speechiness, size = track_pop), col=I("red"), alpha=.3) +
  geom_smooth(mapping = aes(x = track_pop, y = speechiness)) +
  facet_wrap(~ genre, ncol = 10 )


## LINEAR REGRESSIONS

# Loudness ~ Energy, 
lmLE = lm(energy~loudness, data = atacjoin) 
summary(lmLE) 
# plot
ggplot(atacjoin, aes(x = loudness, y = energy)) +
  geom_point() + geom_smooth(method=lm, se=FALSE)
# Plot Flip, is loudness a good predictor of energy?
ggplot(atacjoin, aes(x = energy, y = loudness)) +
  geom_point() + geom_smooth(method=lm, se=FALSE)

# Valence ~ Energy
lmVE = lm(energy~valence, data = atacjoin) 
summary(lmVE) 
# plot
ggplot(atacjoin, aes(x = valence, y = energy)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "goldenrod2")
# Plot Flip, is valence a good predictor of energy?
ggplot(atacjoin, aes(x = energy, y = valence)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "goldenrod2")

# Valence ~ Danceability
lmVD = lm(danceability~valence, data = atacjoin) 
summary(lmVD) 
# plot
ggplot(atacjoin, aes(x = valence, y = danceability)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "pink")
# Plot Flip, is valence a good predictor of danceability?
ggplot(atacjoin, aes(x = danceability, y = valence)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "pink")

# Track Popularity & Explicit Tracks
lmTPE = lm(explicit~track_pop, data = atacjoin) 
summary(lmTPE) 
# plot
ggplot(atacjoin, aes(x = track_pop, y = explicit)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "green")

# Artist Popularity ~ Track Popularity
lmAPTP = lm(track_pop~artist_pop, data = atacjoin) 
summary(lmAPTP) 
# plot
ggplot(atacjoin, aes(x = artist_pop, y = track_pop)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "orange")
# Plot Flip, is artist pop a good predictor of track pop?
ggplot(atacjoin, aes(x = track_pop, y = artist_pop)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "orange")

# Track Popularity ~ Speechiness
lmSTP = lm(speechiness~track_pop, data = atacjoin) 
summary(lmSTP)
# plot
ggplot(atacjoin, aes(x = track_pop, y = speechiness)) +
  geom_point() + geom_smooth(method=lm, se=FALSE, color = "pink")

# Speechiness ~ Danceability
lmDS = lm(danceability~speechiness, data = atacjoin) 
summary(lmDS)
# plot
ggplot(atacjoin, aes(x = speechiness, y = danceability)) +
  +   geom_point() + geom_smooth(method=lm, se=FALSE, color = "orange")

## CORRELATION
#packages
library(corrplot)
library(PerformanceAnalytics)

# Loudness & Energy
cor.test(atacjoin$loudness, atacjoin$energy, method="pearson", use = "complete.obs")

# Loudness & Danceability
cor.test(atacjoin$loudness, atacjoin$danceability, method="pearson", use = "complete.obs")

# Loudness & Valence
cor.test(atacjoin$loudness, atacjoin$valence, method="pearson", use = "complete.obs")

# Energy & Liveness
cor.test(atacjoin$energy, atacjoin$liveness, method="pearson", use = "complete.obs")

# Artist Popularity & Track Popularity
cor.test(atacjoin$artist_pop, atacjoin$track_pop, method="pearson", use = "complete.obs")

# Track Popularity & Duration
cor.test(atacjoin$track_pop, atacjoin$duration, method="pearson", use = "complete.obs")

# Track Popularity & Speechiness
cor.test(atacjoin$track_pop, atacjoin$speechiness, method="pearson", use = "complete.obs")

# Energy & Acousticnes

# CORRELATION MATRICE
acatmatrice <- atacjoin[, c(10, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23 )]
acatmatrice
# CHART.MATRICE
chart.Correlation(acatmatrice, histogram=FALSE, method="pearson")
# CORRELATION MATRIX
corr_matrix <- cor(acatmatrice)
corr_matrix
# CORRPLOT
corrplot(corr_matrix, type="lower", order="hclust", p.mat = corr_matrix,
         sig.level = 0.05, insig="blank")
# used .05 to get more findings


