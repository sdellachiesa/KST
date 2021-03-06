library(shiny)
library(shinydashboard)
library(shinyjs)
library(leaflet)
library(leaflet.providers)
library(magrittr)
library(leaflet.extras)
library(dplyr)
library(rgdal)
library(utf8)
library(sf)
#library(markdown)
library(htmltools)

# --- Load Data
df<-read.csv('./data/KST_MERGED_1_2ord_CSV.csv')
df$lat = as.numeric(format(df$lat, digits = 9))
df$lon = as.numeric(format(df$lon, digits = 9))
# --- Data table to be showed in ui
df_table<-df[c(3,7,8)]

# --- shape file boundary 
my_Sachsen<-st_read('./data/FederalStateBoundary.shp')
my_Network<-st_read('./data/KST_1st_ord.shp')
my_Network$Length<-my_Network$Length/1000
my_Network$Length = as.numeric(format(my_Network$Length, digits = 2))
my_Network2<-st_read('./data/KST_2nd_ord_line_epsg4326.shp')
my_Network2$Length<-my_Network2$Length/1000
my_Network2$Length = as.numeric(format(my_Network2$Length, digits = 2))

# Create icons
Green = makeAwesomeIcon(icon = "ios-close", iconColor = "white",
                        extraClasses = list(width = '1000px'),
                        library = "ion", markerColor = "green")
Red = makeAwesomeIcon(icon = "ios-close", iconColor = "white",
                      library = "ion", markerColor = "red")


#assign proper url to depending on Order column
df$IconsCol = ifelse(df$Ordnung  ==1,
                     "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png",
                     "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png")

