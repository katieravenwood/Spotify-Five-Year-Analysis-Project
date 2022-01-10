#Install packages


#Import data
library(readr)
allchartalbumtracks2 <- read_csv("../data/allchartalbumtracks2.csv")
allchartalbumtracks2

#import genre changes
library(readr)
gdata <- read_csv("../data/genre_wrangling.csv")
gdata

#Drop unnecessary columns
allchart = subset(allchartalbumtracks2, select = -c(X1, track_id, track_artists_ids, album_id, mode,
                                                    duration_ms, time_signature))
allchart

#rename columns
allchart1 <- rename(allchart, 
       Track = track_name,
       Popularity = track_popularity,
       Artists = track_artists,
       Genre = track_artists_genres,
       Artist_Pop = track_artists_popularity,
       Explicit = track_explicit,
       Followers = track_artists_followers,
       Album = album_name)

#rename column in genre data
allchart2 <- rename(gdata, Genre = 'New Genre')

#merge data
allchart3 <- merge(allchart1, allchart2, by.c =c('Track', 'Popularity', 'Artists','Genre', 'Artist_Pop', 'Explicit',
                                              'Followers', 'Album', 'danceability', 'energy', 'key',
                                              'loudness', 'acousticness', 'instrumentalness', 'liveness',
                                              'valence', 'tempo','Original', 'Genre'), all.x=T)
allchart3

allchart4 <- subset(allchart3, select = -c(Original_Genre))
allchart4


#write csv:
write.csv(allchart4, "/Users/biancaabreu/Documents/GitHub\\Allchart.csv", row.names = FALSE)

###These plots were not able to produce because genre is still not consolidated
#Plot valence and genre
ac1 <- ggplot(allchart1, aes(x=Genre, y=valence)) + geom_point() + geom_smooth(method = lm, se = FALSE)
#this plot has genre and valence scattered everywhere 
#PLOT TWO
ac2 <- ggplot(allchart1) + geom_bar(mapping = aes(x = valence))
#PLOT THREE
ac3 <- ggplot(allchart1, aes(x = tempo, y = valence)) + geom_point() + geom_smooth(method = lm, se = FALSE)
