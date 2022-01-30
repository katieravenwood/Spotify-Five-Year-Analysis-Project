# Repeated Measures ANOVA for Genre Change Over Time

## Load libraries
library("rcompanion")
library("fastR2")
library("car")

## Data Import
#### *Set working directory to source file location

library(readr)

# Import recoded table with all track information
AllChartAlbumTracksRecoded <- read_csv("../data/AllChartAlbumTracksRecoded.csv")
View(AllChartAlbumTracksRecoded)

# Import master chart album table with chart year column
MasterChartAlbumWithChartYear <- read_csv("../data/MasterChartAlbumWithChartYear.csv")
View(MasterChartAlbumWithChartYear)

# Join columns for necessary variables
library(dplyr)
actcy <- merge(x=MasterChartAlbumWithChartYear[ , c("album_id", "chart_year")], y = AllChartAlbumTracksRecoded[ , c("album_id", "Soundtrack", "Rock", "Pop", "Hip-hop", "Edm", "Latin", "Indie", "Christian", "Country", "Soul", "Metal", "Jazz", "Folk", "Funk", "Misc", "Easy_listening", "R&B", "Reggae", "Show_tunes")])
actcy2 <- actcy %>% distinct()
View(actcy2)

# Remove album_id column
actcy3 <- subset(actcy2, select = -c(album_id))
View(actcy3)

# Recode 
names(actcy3)[names(actcy3) == "Hip-hop"] <- "HipHop"
names(actcy3)[names(actcy3) == "R&B"] <- "RnB"
View(actcy3)

# Group and summarise to create a table of album genre values by year
actcy4 <- actcy3 %>% group_by(chart_year)
actcy5 <- actcy4 %>% summarise(
  Soundtrack = sum(Soundtrack),
  Rock = sum(Rock),
  Pop = sum(Pop),
  HipHop = sum(HipHop),
  Edm = sum(Edm),
  Latin = sum(Latin),
  Indie = sum(Indie),
  Christian = sum(Christian),
  Country = sum(Country), 
  Soul = sum(Soul),
  Metal = sum(Metal),
  Jazz = sum(Jazz),
  Folk = sum(Folk),
  Funk = sum(Funk),
  Misc = sum(Misc),
  Easy_listening = sum(Easy_listening), 
  RnB = sum(RnB), 
  Reggae = sum(Reggae), 
  Show_tunes = sum(Show_tunes)
  )
View(actcy5)

# Transpose data table
actcy6 <- t(actcy5)
colnames(actcy6) <- c("2017", "2018", "2019", "2020", "2021")
View(actcy6)

#Baseline data table
actcy7$repdat <-actcy7$`2017`
actcy7$contrasts <- "T1"
View(actcy7)

#Follow-up data table
actcy8 <- actcy6
actcy8$repdat <-actcy7$`2021`
actcy8$contrasts <- "T2"
View(actcy8)

#Combine baseline and follow-up tables
genre_rm_anova <- rbind(actcy7, actcy8)
View(genre_rm_anova)

# Test assumptions

# Normality
plotNormalHistogram(actcy7$"2017")
plotNormalHistogram(actcy8$"2021")


# Homogeneity of Variance
leveneTest(repdat ~ Treatment.Group*contrasts, data=breakfast5)