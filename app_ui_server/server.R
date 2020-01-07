
server <- function(input, output, session){
  
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
  
  df_filtered <- reactive({
    df[df$Elevation >= input$slider, ]
  }
  )
  
  ## respond to the filtered data
  observe({
    
    Icons = icons(
      iconUrl = ifelse(df_filtered()$Order  ==1,
                       "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png",
                       "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png"
      ))
    
    leafletProxy(mapId = "my_leaf", data = df_filtered()) %>%
      clearMarkers() %>%   ## clear previous markers
      addMarkers(icon = Icons, 
                 popup = paste("<b><a href='",
                               df_filtered()$wiki_url,"'>",
                               df_filtered()$Name,"</a></b>","<br>","<img src = '",
                               df_filtered()$img_url, "'>"))
  })
}