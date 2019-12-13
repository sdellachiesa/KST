if (!require("shiny")) install.packages("shiny")
if (!require("leaflet")) install.packages("leaflet")
if (!require("leaflet.providers")) install.packages("leaflet.providers")
if (!require("magrittr")) install.packages("magrittr")
if (!require("RColorBrewer")) install.packages("RColorBrewer")
if (!require("dplyr")) install.packages("dplyr")
if (!require("rsconnect")) install.packages("connect")
if (!require("devtools")) install.packages("devtools")
if (!require("htmltools")) install.packages("htmltools")
if (!require("leaflet.extras")) install.packages("leaflet.extras")


# --- Load Data
a<-getwd()
setwd(a)
df<-read.csv("KSTS_MERGED_1_2ord_CSV.csv")
#df<-read.csv("KSTS_MERGED_1_2ord_CSV_v2.csv",fileEncoding = "UTF-8")
df$ord1<-df$Ord == "1"
df$ord2<-df$Ord == "2"

ui <- fluidPage(
    sliderInput(inputId = "slider", 
                label = "Filter Station by Elevation",
                min = min(df$Elevation),
                max = max(df$Elevation),
                value = 92,
                step = 10),
    leafletOutput("my_leaf")
)

server <- function(input, output, session){
    #df <- mydata
    ## create static element
    output$my_leaf <- renderLeaflet({
        leaflet() %>%
            addProviderTiles(providers$OpenTopoMap, group='Topo') %>%
            addProviderTiles(providers$Esri.WorldImagery, group='Satellite') %>%
            addLayersControl(baseGroups = c('Topo', 'Satellite'))%>%
            setView(13.169629, 50.860422, zoom = 7.5)%>%
            addFullscreenControl()%>%
            addEasyButton(
                easyButton(
                    position = "topleft",
                    icon = "fa-crosshairs",
                    title = "Locate Me",
                    onClick = JS(
                        c(
                            "function(btn,  map){map.locate({setView:true,enableHighAccuracy: true })}"
                        )
                    )
                )
            )
            
       
        
    })
    
    ## filter data
    df_filtered <- reactive({
        df[df$Elevation >= input$slider, ]
    })
    ## icons
    #https://github.com/pointhi/leaflet-color-markers
    Icons <- icons(
        iconUrl = ifelse(df$Order  ==1,
                         "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png",
                         "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png"
        ))
    ## respond to the filtered data
    observe({
        
        leafletProxy(mapId = "my_leaf", data = df_filtered()) %>%
            clearMarkers() %>%   ## clear previous markers
            #addMarkers(popup = paste(sep = "<br/>","<b><a href='",df$Descriptio,"'>",df$Name,"</a></b>"))
            addMarkers(icon =Icons, popup = paste("<b><a href='",df$wiki_url,"'>",df$Name,"</a></b>","<br>","<img src = '",df$img_url, "'>"))
        
  
        #addMarkers(popup = paste("<b><a href='",df$wiki_url,"'>",df$Name,"</a></b>","<br>"))%>%
        #addMarkers(popup = popupImage(paste("<img src = '",df$img_url, "'>"), embed= TRUE, width = 300))
    })
    
}


runApp(shinyApp(ui, server), launch.browser = TRUE)


