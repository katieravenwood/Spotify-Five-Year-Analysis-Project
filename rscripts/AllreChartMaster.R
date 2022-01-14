#packges
library(dplyr)
library(ggplot2)
library(tidyverse)

#import data
#importing recoded data with genres wrangled on 1/11
library(readr)
AllreChart <- read_csv("Documents/GitHub/Spotify-Five-Year-Analysis-Project/data/allchartalbumtracks_RECODED_1-11.csv")
AllreChart

#rename columns and subset columns not needed
AllreChart2 <- rename(AllreChart, 
                    Remove = "Unnamed: 0",
                    Track = track_name,
                    Popularity = track_popularity,
                    Artists = track_artists,
                    Genre = track_artists_genres,
                    Artist_Pop = track_artists_popularity,
                    Explicit = track_explicit,
                    Artists_Followers = track_artists_followers,
                    Album = album_name,
                    Genre2 = track_artists_genres_consolidate,
                    Main_ArtistPop = track_artists_popularity_first,
                    Main_ArtistFollowers = track_artists_followers_first,
                    Followers_combined = track_artists_combined_followers)
AllreChart2

AllreChart3 = subset(AllreChart2, select = -c(X1, Remove, track_id, track_artists_ids, album_id, mode))
AllreChart3

#Write into csv for data to save for future analysis
write.csv(AllreChart3, "/Users/biancaabreu/Documents/GitHub/Spotify-Five-Year-Analysis-Project/data/\\AllreChartMaster.csv", row.names = FALSE)


#re-coding True and false into numeric values
AllreChart3$Explicit[AllreChart3$Explicit=='TRUE'] <- 1
AllreChart3$Explicit[AllreChart3$Explicit=='FALSE'] <- 2


##testing analysis plotting with ggplot just to see how data shows up
#testing on valence & genre (consolidated genre)
ggplot(data = AllreChart3) +
  geom_point(mapping = aes(x = valence, y = Genre2, color = "blue"))
#testing on valence & tempo
ggplot(data = AllreChart3) +
  geom_point(mapping = aes(x = valence, y = tempo, color = "red"))
#testing on instrumentalness and valence
ggplot(data = AllreChart3) +
  geom_point(mapping = aes(x = valence, y = instrumentalness, color = ""))
#testing with 'smooth'
ggplot(data = AllreChart3, mapping = aes(x = tempo, y = "Genre2" )) +
  geom_point(mapping = aes(color = "blue")) +
  geom_smooth()

### testing linear regression 
install.packages("car")
install.packages("caret")
install.packages("gvlma")
install.packages("predictmeans")
install.packages("e1071")
install.packages("lmtest")

library("car")
library("caret")
library("gvlma")
library("predictmeans")
library("e1071")
library("lmtest")

scatter.smooth(x=AllreChart3$valence, y=AllreChart3$Explicit, 
               main="Valence vs. Explicit")

lmMod <- lm(valence~Explicit, data=AllreChart3)

#testing for homoscedasticity
par(mfrow=c(2,2))
plot(lmMod)

lmtest::bptest(lmMod)
#Answer: studentized Breusch-Pagan test
#        data:  lmMod
#        BP = 105.4, df = 1, p-value < 2.2e-16
car::ncvTest(lmMod)
#Answer: Non-constant Variance Score Test 
#        Variance formula: ~ fitted.values 
#        Chisquare = 65.51627, Df = 1, p = 5.7636e-16
#outliers
CookD(lmMod, group=NULL, plot=TRUE, idn=3, newwd=TRUE)

# Analysis Questions:

# Q1: HAS VALENCE IN MUSIC CHANGED OVER THE PAST 5 YEARS? HOW? 
#                           IV Valence DV change in yrs, Analysis: Simple Linear Regression
#Tableau will do better at analyzing this data for each year
#Below is a test ggplot anyway for genre and valence to see what plots
ggplot(AllreChart3, aes(x = valence, y = Genre2)) +
  geom_point() +
  stat_smooth()

# Q3: HOW DOES TEMPO AFFECT VALENCE? 
#                           IV tempo - DV valence, Analysis: Simple Linear Regression
#simple linear
#ggupbr creates a publication ready-plot
install.packages("ggpubr")
library(ggpubr) 
ggplot(AllreChart3, aes(x = tempo, y = valence)) +
  geom_point() +
  stat_smooth()

#linear regression,  
lm(tempo~valence, AllreChart3)
#   Call:
#   lm(formula = tempo ~ valence, data = AllreChart3)
#   Coefficients:
#   (Intercept)      valence  
#   117.715        9.089


#Q2: IS THERE CHANGE IN THE AMOUNT OF TRACKS THAT HAVE EXPLICIT LYRICS? 
#Q2 Adjusted: HOW MANY TRACKS ARE EXPLICIT VS THE TOTAL NUMBER OF TRACKS? 
#                             IV Explicit - DV # of explicit tracks, Analysis: Dependent t-Test
#independent test, 2 dependent samples explicit and tracks
t_ind <- t.test(AllreChart3$Explicit, AllreChart3$Track, alternative = "two.sided",
                var.equal = FALSE)








#creating df; using group by or filter
AllreChart4 <- group_by(AlreChart3, group) %>% summarise(count = n(),
                                                      mean = mean(Explicit, na.rm = TRUE),
                                                      sd = sd(Explicit, na.rm = TRUE))
                                            



