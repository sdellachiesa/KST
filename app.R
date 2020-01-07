if (!require("shiny")) install.packages("shiny")
if (!require("leaflet")) install.packages("leaflet")
if (!require("leaflet.providers")) install.packages("leaflet.providers")
if (!require("magrittr")) install.packages("magrittr")
#if (!require("RColorBrewer")) install.packages("RColorBrewer")
#if (!require("dplyr")) install.packages("dplyr")
#if (!require("rsconnect")) install.packages("connect")
if (!require("devtools")) install.packages("devtools")
#if (!require("htmltools")) install.packages("htmltools")
if (!require("leaflet.extras")) install.packages("leaflet.extras")


# --- Load Data
#a<-getwd()
#setwd(a)

df<-read.csv('./data/KST_MERGED_1_2ord_CSV.csv')
#df<-read.csv("KST_MERGED_1_2ord_CSV_v2.csv",fileEncoding = "UTF-8")

#assign proper url to depending on Order column
    df$IconsCol = ifelse(df$Order  ==1,
                     "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png",
                     "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png")

#df$ord1<-df$Ord == "1"
#df$ord2<-df$Ord == "2"


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
    
    ## debug filter data
    #df_filtered <- reactive({df[df$Elevation >= 850, ]    })
    
     # return the reactive valure (filtered records df$Elevation >= 1000)
    #pippo<-reactiveValues(df_filtered())
    #pippo<-get(isolate(df_filtered)) 
    #expr_q<-quote({df_filtered()})
    ##  filter data
    #values <- reactiveValues()
    df_filtered <- reactive({
        df[df$Elevation >= input$slider, ]
                }
        )
    #values <- reactiveValues(df_filtered())
    ## icons
    #https://github.com/pointhi/leaflet-color-markers
   
    #pippo<- isolate(df_filtered())
    Icons <- icons(
        iconUrl = ifelse(isolate(df_filtered())$Order  ==1,
                         "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png",
                         "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png"
        ))
    ## respond to the filtered data
    observe({
            leafletProxy(mapId = "my_leaf", data = df_filtered()) %>%
            clearMarkers() %>%   ## clear previous markers
            addMarkers(icon =icons(isolate(df_filtered())$IconsCol), popup = paste("<b><a href='",isolate(df_filtered())$wiki_url,"'>",isolate(df_filtered())$Name,"</a></b>","<br>","<img src = '",isolate(df_filtered())$img_url, "'>"))
          })
    }
#runApp(shinyApp(ui, server), launch.browser = TRUE)


# ---- to publish on shinyapps.io
#library(git2r)
#library(rsconnect)
#deployApp()
#deployApp(appName ="TriangulationNetwork")
#rsconnect::deployApp(appName ="TriangulationNetwork")
#rsconnect::deployApp('C:\Users\SDellaChiesa\OneDrive - Scientific Network South Tyrol\00_R\06_KST\KST\app.R', appFiles = c('C:\Users\SDellaChiesa\OneDrive - Scientific Network South Tyrol\00_R\06_KST\KST\KST_MERGED_1_2ord_CSV.csv'),
 #                     account = 'stefano.dellachiesa@gmail.com', server = 'shinyapps.io')

#rsconnect::deployApp("C:\Users\SDellaChiesa\OneDrive - Scientific Network South Tyrol\00_R\06_KST\KST\app.R", appFiles = c("C:\Users\SDellaChiesa\OneDrive - Scientific Network South Tyrol\00_R\06_KST\KST\KST_MERGED_1_2ord_CSV.csv"), account = 'stefanodellachiesa', server = 'shinyapps.io')
#rsconnect::deployApp(appName ="TriangulationNetwork")
