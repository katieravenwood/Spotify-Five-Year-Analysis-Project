#data
library(dyplr)
library(ggplot2)
library(tidyverse)

##IMPORT
#Main data set
library(readr)
allchartalbumtracks2 <- read_csv("../data/allchartalbumtracks2.csv")
allchartalbumtracks2
#Genre data set
library(readr)
gdata <- read_csv("../data/genre_wrangling.csv")
gdata

#Drop unnecessary columns: main
allchart2 = subset(allchartalbumtracks2, select = -c(X1, track_id, track_artists_ids, album_id, mode,
                                                    duration_ms, time_signature))
allchart2

#Renaming columns: main
allchart3 <- rename(allchart2, 
                    Remove = "Unnamed: 0",
                    Track = track_name,
                    Popularity = track_popularity,
                    Artists = track_artists,
                    Genre = track_artists_genres,
                    Artist_Pop = track_artists_popularity,
                    Explicit = track_explicit,
                    Followers = track_artists_followers,
                    Album = album_name)
allchart3
#remove, remove
allchart4 <- subset(allchart3, select--c(Remove))
allchart4

#Remove column: gdata
gdata1 <- subset(gdata, select = -c(X1))

#Rename columns: gdata
gdata2 <- rename(gdata1, 
                 Original = Original_Genre,
                 Genre = 'New Genre')

#Merge both data sets
allchart5 <- merge(allchart4, gdata2, by.c =c('Track', 'Popularity', 'Artists','Genre', 'Artist_Pop', 'Explicit',
                                                 'Followers', 'Album', 'danceability', 'energy', 'key',
                                                 'loudness', 'acousticness', 'instrumentalness', 'liveness',
                                                 'valence', 'tempo','Original', 'Genre'), all.x=T)
allchart5
#see all columns
colnames(allchart5)

#write csv
write.csv(allchart5, "/Users/biancaabreu/Documents/GitHub/\\AllchartReMaster.csv", row.names = FALSE)










