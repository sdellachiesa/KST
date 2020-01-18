server <- function(input, output){
  
  output$about_out  <- renderUI({
    includeHTML("./data/about.html")
    })
  
  #my_info<-renderMarkdown(file = "./data/include.md", encoding = "UTF-8")
  output$my_leaf <- renderLeaflet({
    leaflet()%>%
      addPolylines(data = my_Sachsen,color = "black", 
                  weight  = 3, opacity = 1,
                  fillOpacity = 0,smoothFactor = 1, group ="Sachsen", stroke = TRUE, noClip = TRUE)%>%
      addPolylines(data = my_Network,color = "red", 
                   weight  = 3, opacity = 0.5, 
                   smoothFactor = 1, dashArray ="4", group ="Netzwerk 1 Ord",
                   popup = paste(my_shp2$Length,"</a></b>",as.character("km"),"</a></b>")
                   
      )%>%   
      #leaflet() %>%
      addProviderTiles(providers$OpenTopoMap, group='Topo') %>%
      addProviderTiles(providers$Esri.WorldImagery, group='Satellite')%>%
      addLayersControl(
        baseGroups = c('Topo', 'Satellite'),
        overlayGroups = c("Sachsen", "Netzwerk 1 Ord","Säule 1 Ord","Säule 2 Ord"),
            options = layersControlOptions(collapsed = TRUE))%>%
      hideGroup("Säule 2 Ord")%>%
      setView(13.3, 50.3,zoom = 10)%>% #13.169629, 50.860422,
      #setMaxBounds(lng1 = max(df$lon),lat1 = max(df$lat),
      #lng2 = min(df$lon),lat2 = min(df$lat))%>%
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
    
    # 
    red_df = dplyr::filter(df_filtered(),Ordnung == 1)
    green_df = dplyr::filter(df_filtered(),Ordnung == 2)
    # 
    proxy<-leafletProxy(mapId = "my_leaf", data = df_filtered()) %>%
      flyToBounds(lng1 = max(df_filtered()$lon),lat1 = max(df_filtered()$lat),
                  lng2 = min(df_filtered()$lon),lat2 = min(df_filtered()$lat),
                  options = list(minZoom = 14))%>%
      clearMarkers() %>%
      addAwesomeMarkers(lng = red_df$lon,
                        lat = red_df$lat,
                        icon =  Red,
                        group = "Säule 1 Ord",
                        popup = paste("<b><a href='",red_df$wiki_url,"'>",
                                      paste("Säule N°",red_df$Name),"</a></b>",
                                      "<br>",
                                      paste("Höhe ",red_df$Hoehe," m"),
                                      "<br>",
                                      "<img src = '", red_df$img_url, "'>")
                        
                        
      ) %>%
      addAwesomeMarkers(lng = green_df$lon,
                        lat = green_df$lat,
                        icon =  Green,
                        group = "Säule 2 Ord",
                        popup = paste("<b><a href='",green_df$wiki_url,"'>",
                                      paste("Säule N°",green_df$Name),"</a></b>",
                                      "<br>",
                                      paste("Höhe ",green_df$Hoehe," m"),
                                      "<br>",
                                      "<img src = '", green_df$img_url, "'>")
      )
    #
    #
    # ) %>%
    # addCircleMarkers(lng = green_df$lon,
    #                  lat = green_df$lat,
    #                  radius = 7.5,color = "black",weight = 2,opacity = 0.5,
    #                  stroke = TRUE,fillColor = "green",fillOpacity = 0.4,
    #                  popup = paste("<b><a href='",green_df$wiki_url,"'>",
    #                                green_df$Name,"</a></b>","<br>","<img src = '",
    #                                green_df$img_url, "'>"))%>%
    
    # addCircleMarkers(lng = red_df$lon,
    #                  lat = red_df$lat,
    #                  radius = 7.5,color = "black",weight = 2,opacity = 0.5,
    #                  stroke = TRUE,fillColor = "red",fillOpacity = 0.4,
    #                  popup = paste("<b><a href='",red_df$wiki_url,"'>",
    #                                red_df$Name,"</a></b>","<br>","<img src = '",
    #                                red_df$img_url, "'>"))
    
    output$my_table<- DT::renderDataTable(DT::datatable(
      df_table_filtered(),
      options = list(pageLength = 10),
      rownames = FALSE))
  })
}

#shinyApp(ui, server)
