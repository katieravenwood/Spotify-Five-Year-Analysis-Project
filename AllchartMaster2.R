#data
library(dplyr)
library(ggplot2)
library(tidyverse)

##IMPORT
#Main data set
library(readr)
allcharttracks <- read_csv("data/AllchartReMaster.csv")
allcharttracks
#Genre data set
library(readr)
gdata <- read_csv("data/genre_wranglingcopy.csv")
gdata

#Remove column: gdata
gdata1 <- subset(gdata, select = -c(X1, X2, X3))
gdata1

#Rename columns: gdata
gdata2 <- rename(gdata1, 
                 Original = Original_Genre,
                 Genre = 'New Genre')
gdata2

#Merge both data sets
## was going to merge but no need if using string replace 
### updated csv has updated column names also

#see all columns
colnames(allcharttracks)

#write csv
write.csv(allchart5, "data/AllchartReMasterWorking.csv", row.names = FALSE)


##explode coulmn to see all values
#create tibble
tibble(allchart5['replace_Genre'])
#see list of values in row
list(allchart5['Genre'])
#see values in column
allchart5$Genre


                    
library(stringr)
str_replace_all(allcharttracks[Genre], c("a cappella" = "Misc","hollywood" = "Misc", "country rock" = "Rock",
                             "k-pop boy group" = "Pop", "deep underground hip hop" =	"Hip-hop",
                             "post-grunge" =	"Rock","progressive electro house" = "Edm", "soft rock" =	"Rock",
                             "modern hard rock" =	"Rock", "kentucky hip hop" =	"Hip-hop", "dmv rap" =	"Hip-hop",
                             "art rock" =	"Rock"))
                             
                             
                             
                            
                             
                             
                            
                             
                             
                             
                             
                             "vapor trap" =	"Hip-hop",
                             "seattle hip hop" =	"Hip-hop",
                             "merseybeat" =	"Pop",
                             "detroit hip hop" = "Hip-hop",
                             "jazz rap" =	"Hip-hop",
                             "rap conscient" =	"Hip-hop",
                             "reggaeton colombiano" =	"Latin",
                             "deep classic garage rock"	= "Rock",
                             "christian indie" =	"Indie",
                             "worship" =	"Christian",
                             "kentucky roots"	= "Country",
                             "british soul" =	"Soul",
                             "nu metal" =	"Metal",
                             "ccm" =	"Christian",
                             "texas country" =	"Country",
                             "jam band"	= "Jazz",
                             "atl hip hop" = "Hip-hop",
                             "modern rock" = "Rock",
                             "neo mellow" =	"Pop",
                             "nyc rap" =	"Hip-hop",
                             "irish singer-songwriter" =	"Folk",
                             "talent show" =	"Pop",
                             "rock-and-roll" =	"Rock",
                             "uk pop" =	"Pop",
                             "virginia hip hop" =	"Hip-hop",
                             "golden age hip hop" =	"Hip-hop",
                             "slap house" =	"Edm",
                             "detroit rock" =	"Rock",
                             "irish rock" =	"Rock",
                             "trap boricua" =	"Latin",
                             "canadian country" =	"Country",
                             "dfw rap" =	"Hip-hop",
                             "modern folk rock" =	"Rock",
                             "indietronica" =	"Indie",
                             "funk metal" =	"Metal",
                             "minneapolis sound" =	"Funk",
                             "bedroom pop" =	"Pop",
                             "modern alternative rock" =	"Rock",
                             "north carolina hip hop"	= "Hip-hop",
                             "outlaw country" =	"Country",
                             "e" =	"Misc",
                             "album rock" =	"Rock",
                             "british invasion" =	"Rock",
                             "house" =	"Edm",
                             "melodic rap" =	"Hip-hop",
                             "easy listening" =	"Easy_listening",
                             "beatlesque" =	"Pop",
                             "alternative r&b" =	"R&B",
                             "new jersey rap" =	"Hip-hop",
                             "trap latino" = "Latin",
                             "blues rock"	= "Rock",
                             "jazz pop" =	"Jazz",
                             "plugg" =	"Hip-hop",
                             "drill" =	"Hip-hop",
                             "birmingham metal" =	"Metal",
                             "hip hop" =	"Hip-hop",
                             "latin" =	"Latin",
                             "australian country" =	"Country",
                             "h"	= "Misc",
                             "detroit trap" =	"Hip-hop",
                             "groove metal" =	"Metal",
                             "new orleans rap" =	"Hip-hop",
                             "hardcore hip hop" =	"Hip-hop",
                             "chicago drill"	= "Hip-hop",
                             "baroque pop" = "Pop",
                             "movie tunes" =	"Misc",
                             "u" =	"Misc",
                             "post-teen pop" =	"Pop",
                             "sunshine pop" =	"Pop",
                             "pittsburgh rap" =	"Hip-hop",
                             "stomp and holler" =	"Pop",
                             "w" =	"Misc",
                             "canadian trap" =	"Hip-hop",
                             "metal" =	"Metal",
                             "brostep" =	"Edm",
                             "modern blues rock" =	"Rock",
                             "heartland rock" =	"Rock",
                             "scam rap" =	"Hip-hop",
                             "roots reggae" =	"Reggae",
                             "funk rock" =	"Rock",
                             "modern country rock" =	"Rock",
                             "urban contemporary" =	"R&B",
                             "classic rock" =	"Rock",
                             "europop" =	"Pop",
                             "pop soul" =	"Soul",
                             "emo" =	"Rock",
                             "philly rap" =	"Hip-hop",
                             "reggaeton" =	"Latin",
                             "barbadian pop" =	"Pop",
                             "viral rap" =	"Hip-hop",
                             "christian alternative rock" =	"Christian"
                             "uk dance" =	"Edm",
                             "chicago rap" =	"Hip-hop",
                             "grunge" =	"Rock",
                             "boy band" =	"Pop",
                             "queens hip hop" =	"Hip-hop",
                             "soul" =	"Soul",
                             "florida rap" =	"Hip-hop",
                             "neo soul" =	"Soul",
                             "gangster rap" =	"Hip-hop",
                             "synth funk" =	"Funk",
                             "singer-songwriter" =	"Folk",
                             "dirty south rap" =	"Hip-hop",
                             "west coast rap" =	"Hip-hop",
                             "progressive metal" = "Metal",
                             "pop rock" =	"Rock",
                             "toronto rap" =	"Hip-hop",
                             "indie rock" =	"Indie",
                             "etherpop" =	"Pop",
                             "folk-pop" =	"Pop",
                             "swamp rock" =	"Rock",
                             "yacht rock" =	"Rock",
                             "indie pop rap" =	"Indie",
                             "country pop" =	"Pop",
                             "minnesota hip hop" =	"Hip-hop",
                             "swedish pop" =	"Pop",
                             "lgbtq+ hip hop" =	"Hip-hop",
                             "mississippi hip hop" =	"Hip-hop",
                             "art pop" =	"Pop",
                             "australian pop" =	"Pop",
                             "southern hip hop" = "Hip-hop",
                             "emo rap" =	"Hip-hop",
                             "garage rock" =	"Rock",
                             "dance pop" =	"Pop",
                             "bedroom soul" =	"Soul",
                             "pop dance" =	"Pop",
                             "metropopolis" =	"Pop",
                             "redneck" =	"Country",
                             "roots rock" =	"Rock",
                             "australian rock" =	"Rock",
                             "christian music"	= "Christian",
                             "funk" =	"Funk",
                             "s" =	"Misc",
                             "o" =	"Misc",
                             "a cappella" =	"Misc",
                             "hawaiian hip hop"= 	"Hip-hop",
                             "indie poptimism" =	"Indie",
                             "miami hip hop" =	"Hip-hop",
                             "nz pop"	= "Pop",
                             "show tunes" =	"Show_tunes",
                             "lounge" =	"Pop",
                             "permanent wave" =	"Metal",
                             "arkansas hip hop" =	"Hip-hop",
                             "escape room" =	"Pop",
                             "country" =	"Country",
                             "glam rock" =	"Rock",
                             "brill building pop" =	"Pop",
                             "reggae" =	"Reggae",
                             "pop rap" =	"Hip-hop",
                             "rap" =	"Hip-hop",
                             "k-pop" =	"Pop",
                             "brooklyn drill" =	"Hip-hop",
                             "g funk" =	"Hip-hop",
                             "viral pop" =	"Pop",
                             "shiver pop" =	"Pop",
                             "pop r&b" =	"R&B",
                             "baton rouge rap" =	"Hip-hop",
                             "canadian hip hop" =	"Hip-hop",
                             "black americana" =	"Misc",
                             "oklahoma country" =	"Country",
                             "alternative hip hop" =	"Hip-hop",
                             "southern rock" =	"Rock",
                             "contemporary country" =	"Country",
                             "hip pop"	= "Hip-hop",
                             "trap queen" =	"Hip-hop",
                             "adult standards" =	"Easy_listening",
                             "hard rock" =	"Rock",
                             "tennessee hip hop" =	"Hip-hop",
                             "folk rock" =	"Rock",
                             "old school thrash" =	"Metal",
                             "alternative rock" =	"Rock",
                             "t" =	"Misc",
                             "gauze pop" =	"Pop",
                             "progressive rock" =	"Rock",
                             "reggaeton flow" =	"Latin",
                             "tropical house" =	"Edm",
                             "thrash metal" =	"Metal",
                             "r&b" =	"R&B",
                             "rap metal" = "Metal",
                             "pop" =	"Pop",
                             "atl trap" =	"Hip-hop",
                             "east coast hip hop" =	"Hip-hop",
                             "new wave pop" =	"Pop",
                             "rock" =	"Rock",
                             "progressive house" =	"Edm",
                             "electro house" =	"Edm",
                             "electropop" = "Pop",
                             "mellow gold" = "Indie",
                             "glam metal" =	"Metal",
                             "australian dance" =	"Edm",
                             "ohio hip hop"	= "Hip-hop",
                             "sheffield indie" =	"Indie",
                             "memphis hip hop" = "Hip-hop",
                             "puerto rican pop" =	"Latin",
                             "uk americana" =	"Country",
                             "country dawn" =	"Country",
                             "oakland hip hop" =	"Hip-hop",
                             "trap" =	"Hip-hop",
                             "piano rock" =	"Rock",
                             "comic" =	"Misc",
                             "canadian pop" =	"Pop",
                             "k-pop girl group" =	"Pop",
                             "kentucky indie" =	"Indie",
                             "country road" =	"Country",
                             "alt z" =	"Pop",
                             "jazz trio" =	"Jazz",
                             "conscious hip hop" =	"Hip-hop",
                             "underground hip hop" =	"Hip-hop",
                             "canadian rock" =	"Rock",
                             " " = "Misc",
                             "cali rap" =	"Hip-hop",
                             "indie pop" =	"Indie",
                             "uk contemporary r&b" =	"R&B",
                             "alternative metal" =	"Metal",
                             "electronic trap"	= "Edm",
                             "edm" =	"Edm",
                             "rockabilly" =	"Rock",
                             "australian hip hop" =	"Hip-hop",
                             "houston rap" =	"Hip-hop",
                             "psychedelic rock" =	"Rock",
                             "n" =	"Misc",
                             "canadian contemporary r&b" =	"R&B"))



