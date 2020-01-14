library(shiny)
library(leaflet)
library(leaflet.providers)
library(magrittr)
library(leaflet.extras)
library(dplyr)
library(rgdal)
library(utf8)
library(sf)

# --- Load Data
df<-read.csv('./data/KST_MERGED_1_2ord_CSV.csv')
df$lat = as.numeric(format(df$lat, digits = 9))
df$lon = as.numeric(format(df$lon, digits = 9))
# --- Data table to be showed in ui
df_table<-df[c(3,7,8)]

# --- shape file boundary
my_shp1<-st_read('./data/FederalStateBoundary.shp')
my_shp2<-st_read('./data/KST_1st_ord.shp')
my_shp2$Length<-my_shp2$Length/1000
my_shp2$Length = as.numeric(format(my_shp2$Length, digits = 2))
# Create icons
Green = makeAwesomeIcon(icon = "ios-close", iconColor = "white",
                        library = "ion", markerColor = "green")
Red = makeAwesomeIcon(icon = "ios-close", iconColor = "white",
                      library = "ion", markerColor = "red")


#assign proper url to depending on Order column
df$IconsCol = ifelse(df$Ordnung  ==1,
                     "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png",
                     "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png")

