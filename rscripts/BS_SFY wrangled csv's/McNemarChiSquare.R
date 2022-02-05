library("gmodels")
library("tidyr")

library(readr)
MasterChartAlbumWithChartYear_copy <- read_csv("Desktop/MasterChartAlbumWithChartYear copy.csv")
View(MasterChartAlbumWithChartYear_copy)

MCY <- MasterChartAlbumWithChartYear_copy
View(MCY)

# Did genre change in popularity from the first chart year (2017) and last chart year (2021)?

# Structure of data
str(MCY)

# Hip-hop
# Recoding
MCY$h_year <- NA
MCY$h_year[MCY$chart_year == "2017"] <- 0
MCY$h_year[MCY$chart_year == "2021"] <- 1

# Recoding genre
MCY$h_genre <- NA
MCY$h_genre[MCY$main_genre == "Hip-hop"] <- 1
MCY$h_genre[MCY$main_genre != "Hip-hop"] <- 0


# Testing Assumptions & Run Analysis
CrossTable(MCY$h_year, MCY$h_genre, fisher=TRUE, chisq = TRUE, mcnemar = TRUE, expected = TRUE, sresid=TRUE, format="SPSS")


# Country
# Recoding
MCY$c_year <- NA
MCY$c_year[MCY$chart_year == "2017"] <- 0
MCY$c_year[MCY$chart_year == "2021"] <- 1

# Recoding genre
MCY$c_genre <- NA
MCY$c_genre[MCY$main_genre == "Country"] <- 1
MCY$c_genre[MCY$main_genre != "Country"] <- 0


# Testing Assumptions & Run Analysis
CrossTable(MCY$c_year, MCY$c_genre, fisher=TRUE, chisq = TRUE, mcnemar = TRUE, expected = TRUE, sresid=TRUE, format="SPSS")

# EDM
# Recoding
MCY$e_year <- NA
MCY$e_year[MCY$chart_year == "2017"] <- 0
MCY$e_year[MCY$chart_year == "2021"] <- 1

# Recoding genre
MCY$e_genre <- NA
MCY$e_genre[MCY$main_genre == "Country"] <- 1
MCY$e_genre[MCY$main_genre != "Country"] <- 0


# Testing Assumptions & Run Analysis
CrossTable(MCY$e_year, MCY$e_genre, fisher=TRUE, chisq = TRUE, mcnemar = TRUE, expected = TRUE, sresid=TRUE, format="SPSS")


# Testing Assumptions & Run Analysis (all chart years)
CrossTable(MCY$chart_year, MCY$h_genre, fisher=TRUE, chisq = TRUE, mcnemar = TRUE, expected = TRUE, sresid=TRUE, format="SPSS")




