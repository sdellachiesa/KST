if (!require("shiny")) install.packages("shiny")
if (!require("leaflet")) install.packages("leaflet")
if (!require("leaflet.providers")) install.packages("leaflet.providers")
if (!require("magrittr")) install.packages("magrittr")
if (!require("RColorBrewer")) install.packages("RColorBrewer")
if (!require("dplyr")) install.packages("dplyr")
if (!require("rsconnect")) install.packages("connect")
if (!require("devtools")) install.packages("devtools")
# --- Load Data
a<-getwd()
setwd(a)
df<-read.csv("KSTS_1_2ord_CSV.csv")
df$ord1<-df$Ord == "First"
df$ord2<-df$Ord == "Second"

ui <- fluidPage(
    sliderInput(inputId = "slider", 
                label = "values",
                min = min(df$Elevation),
                max = max(df$Elevation),
                value = 500,
                step = 100),
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
            setView(13.169629, 50.860422, zoom = 7)
       
        
    })
    
    ## filter data
    df_filtered <- reactive({
        df[df$Elevation >= input$slider, ]
    })
    
    ## respond to the filtered data
    observe({
        
        leafletProxy(mapId = "my_leaf", data = df_filtered()) %>%
            clearMarkers() %>%   ## clear previous markers
            addMarkers(popup = df$url)
    })
    
}

shinyApp(ui, server)


