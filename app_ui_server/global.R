library(shiny)
library(leaflet)
library(leaflet.providers)
library(magrittr)
library(leaflet.extras)

# --- Load Data
df<-read.csv("data/KST_MERGED_1_2ord_CSV.csv")

#assign proper url to depending on Order column
df$IconsCol = ifelse(df$Order  ==1,
                     "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png",
                     "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png")