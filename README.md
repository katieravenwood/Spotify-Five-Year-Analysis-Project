# Spotify x Billboard Five Year Analysis Project

<img src="https://github.com/katieravenwood/Spotify-Five-Year-Analysis-Project/blob/e16eff25504ca7e63c8d86aaecfc865c4bf5e127/viz/pyplots/ChartAppearanceWordCloudBlack.jpg">

Analysis of Spotify music statistics and characteristics for the most popular tracks, artists, and albums from 2017-2021, as determined by Billboard year-end Top Album charts. 

For completion of the Final Project requirement of the Entity Academy / Woz-U Data Science curriculum.

A collaborative project of Bianca Serrano and Katie Ravenwood.

## Phase 1: Dataset Creation 
### (Completed 27 December 2021)

The dataset was created via Python using Spotify's public API and playlists created based on the Billboard Top 200 Albums charts for 2017-2021. 

#### Spotify Playlists:
[Billboard 200 Top Albums 2017](https://open.spotify.com/playlist/1N9WQ0C6m7n1TVeLXdUoNb)<br />
[Billboard 200 Top Albums 2018](https://open.spotify.com/playlist/34KSLHLGSNqeK6UfxKnLuM)<br />
[Billboard 200 Top Albums 2019](https://open.spotify.com/playlist/0n3V7u9sMRV7sCDMhWxDtL)<br />
[Billboard 200 Top Albums 2020](https://open.spotify.com/playlist/1EEazdcjH0keT4sttGvH8c)<br />
[Billboard 200 Top Albums 2021](https://open.spotify.com/playlist/3avCwQPH6DkhMTRsizon7N)

#### Included variables:
- Billboard Album Chart Name & Year
- Album ID, Name, Release Year
- Album artists' names, IDs, popularity, and associated genres
- Track artists' names, IDs, popularity, and associated genres
- Explicit designation
- Audio features

#### Dataset creation notebooks:
[Master Chart Table Creation](https://github.com/katieravenwood/Spotify-Five-Year-Analysis-Project/blob/main/notebooks/Master_Chart_Table_Creation.ipynb)<br />
[All Album Track Table Creation](https://github.com/katieravenwood/Spotify-Five-Year-Analysis-Project/blob/main/notebooks/All_Album_Track_Table_Creation.ipynb)

## Phase 2: Data Wrangling, Cleaning and Recoding
### (Completed 11 January 2022)

Data was cleaned and recoded for analysis and machine learning predictions. 

#### Data Wrangling and Cleaning Notebook: 
[Wrangling Cleaning and Recoding](https://github.com/katieravenwood/Spotify-Five-Year-Analysis-Project/blob/98de175eefebacf049b39f2e9fc0c55db6dda8a7/notebooks/WranglingCleaningAndRecoding.ipynb)

## Phase 3: Exploratory Analysis
### Completed Completed 17 January 2022

Exploratory analyses included visualization and standardization of audio feature variables, as well as correlation analysis and plotting.<br />
<br />

#### Exploratory Analysis Notebook and RScript:
[Exploratory Analysis Notebook](https://github.com/katieravenwood/Spotify-Five-Year-Analysis-Project/blob/65a2542ac09d7c534856f8994fbce64e0ed52d98/notebooks/ExploratoryAnalysis.ipynb)<br />
[Exploratory Analysis RScript](https://github.com/katieravenwood/Spotify-Five-Year-Analysis-Project/blob/65a2542ac09d7c534856f8994fbce64e0ed52d98/rscripts/Exploratory_Analysis.R)

## Phase 4: Data Analysis and Machine Learning
### Completed 23 January 2022

Linear regression and dependent t-tests were used to analyze the correlation between several audio features, and the data was grouped using the K Means method. Classification of track genres was tested via K Nearest Neighbors and Random Forest algorithms. <br />
<br />
#### Data Analysis and Machine Learning Notebook and RScript:
[Data Analysis and Machine Learning Notebook](https://github.com/katieravenwood/Spotify-Five-Year-Analysis-Project/blob/65a2542ac09d7c534856f8994fbce64e0ed52d98/notebooks/DataAnalysis.ipynb)<br />
[Data Analysis RScript]

## Tableau Visualization and Project Presentation (In Progress)

Tableau visualizations will be created for selected functions and correlations. 

Project will be presented via Zoom on 2 February 2022. 


