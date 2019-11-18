if (!require("shiny")) install.packages("shiny")
if (!require("leaflet")) install.packages("leaflet")
if (!require("leaflet.providers")) install.packages("leaflet.providers")
if (!require("magrittr")) install.packages("magrittr")
if (!require("RColorBrewer")) install.packages("RColorBrewer")
if (!require("dplyr")) install.packages("dplyr")

# --- Load Data

mydata<-read.csv("KSTS_1_2ord_CSV.csv", stringsAsFactors=F)
mydata$ord1<-mydata$Ord == "First"
mydata$ord2<-mydata$Ord == "Second"



ui <- bootstrapPage(
    tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
    leafletOutput("map", width = "100%", height = "100%"),
    absolutePanel(top = 10, right = 10,
                  sliderInput("range", "Elevation", min(mydata$Elevation), max(mydata$Elevation), value = 500
                  )
    )
)

server <- function(input, output, session) {
    
    sliderData1 <- reactive({
        mydata[mydata$Elevation >= input$range[1] & mydata$Elevation <= input$range[2]& mydata$ord1 == TRUE,]
    })
    sliderData2 <- reactive({
        mydata[mydata$Elevation >= input$range[1] & mydata$Elevation <= input$range[2]& mydata$ord2 == TRUE,]
    })
    
    output$map <- renderLeaflet({
        leaflet(mydata) %>% 
            setView(13.169629, 50.860422, zoom = 7)%>%
            addProviderTiles(providers$OpenTopoMap, group='Topo') %>%
            addProviderTiles(providers$Esri.WorldImagery, group='Satellite') %>%
            addLayersControl(baseGroups = c('Topo', 'Satellite'))
    }) 

    
    observe({
        leafletProxy("map", data = sliderData1()) %>%
            clearMarkers() %>%
            addCircleMarkers(data = sliderData1(), group = "ord1", popup = ~as.character(Name), color = 'black', fillOpacity = 1) %>%
            addCircleMarkers(data = sliderData2(), group = "ord2", popup = ~as.character(Name), color = 'red', fillOpacity = 1) %>%
            addLayersControl(
                overlayGroups = c("ord1", "ord2"),
                options = layersControlOptions(collapsed = FALSE),
                position = "bottomright"
            )
    }) 
}

shinyApp(ui, server)
