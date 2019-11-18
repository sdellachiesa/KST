if (!require("leaflet")) install.packages("leaflet")
if (!require("leaflet.providers")) install.packages("leaflet.providers")
if (!require("magrittr")) install.packages("magrittr")

# ---- %>% pipe operator means that the previos instruction represent
#the first  default argument  i.e. "x" of the next function.

# --- Load data
KSTS_1_2ord<-read.csv("KSTS_1_2ord_CSV.csv", stringsAsFactors=F)

m <- leaflet(KSTS_1_2ord) %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  setView(13.169629, 50.860422, zoom = 7)%>%
  addProviderTiles(providers$OpenTopoMap, group='Topo') %>%
  addProviderTiles(providers$Esri.WorldImagery, group='Satellite') %>%
  #addProviderTiles(providers$OpenStreetMap.DE, group='Openstreet') %>%
  addLayersControl(baseGroups = c('Topo', 'Satellite')) %>%
  addMarkers(~lon,~lat, popup=KSTS_1_2ord$Name)
m


