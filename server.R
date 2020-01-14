server <- function(input, output){
  
  
  
  output$my_leaf <- renderLeaflet({
    leaflet(my_shp1)%>%
      addPolygons(color = "black", 
                  weight  = 3, opacity = 1,
                  fillOpacity = 0,smoothFactor = 1)%>%
      leaflet(my_shp2)%>%
      addPolygons(color = "red", 
                  weight  = 3, opacity = 1,
                  fillOpacity = 0,smoothFactor = 1)%>%
      #leaflet() %>%
      addProviderTiles(providers$OpenTopoMap, group='Topo') %>%
      addProviderTiles(providers$Esri.WorldImagery, group='Satellite')%>%
      addLayersControl(baseGroups = c('Topo', 'Satellite'))%>%
      #setView(11.643167,50.278278, zoom = 12)%>%
      flyToBounds(lng1 = max(df$lon),lat1 = max(df$lat),
                  lng2 = min(df$lon),lat2 = min(df$lat))%>%
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
  
  ##  filter data
  
  df_filtered <- reactive({
    df[df$Hoehe >= input$slider[1] & df$Hoehe <= input$slider[2] , ]
  }
  )
  df_table_filtered <- reactive({
    df_table[df_table$Hoehe >= input$slider[1] & df_table$Hoehe <= input$slider[2] , ]
  }
  )
  
  
  ## respond to the filtered data
  observe({
    
    red_df = dplyr::filter(df_filtered(),Ordnung == 1)
    green_df = dplyr::filter(df_filtered(),Ordnung == 2)
    
    proxy<-leafletProxy(mapId = "my_leaf", data = df_filtered()) %>%
      flyToBounds(lng1 = max(df_filtered()$lon),lat1 = max(df_filtered()$lat),
                  lng2 = min(df_filtered()$lon),lat2 = min(df_filtered()$lat),
                  options = list(maxZoom = 14))%>%
      clearMarkers() %>%
      addAwesomeMarkers(lng = red_df$lon,
                        lat = red_df$lat,
                        icon =  Red,
                        
                        popup = paste("<b><a href='",red_df$wiki_url,"'>",
                                      red_df$Name,"</a></b>","<br>","<img src = '",
                                      red_df$img_url, "'>")
                        
                        
      ) %>% 
      addAwesomeMarkers(lng = green_df$lon,
                        lat = green_df$lat,
                        icon =  Green,
                        
                        popup = paste("<b><a href='",green_df$wiki_url,"'>",
                                      green_df$Name,"</a></b>","<br>","<img src = '",
                                      green_df$img_url, "'>")
                        
                        
      ) 
    
    output$my_table<- DT::renderDataTable(DT::datatable(
      df_table_filtered(),
      options = list(pageLength = 10),
      rownames = FALSE))
  })
}

shinyApp(ui, server)
