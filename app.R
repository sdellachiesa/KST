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
if (!require("shinydashboard")) install.packages("shinydashboard")
library(dplyr)

#matthias
# --- Load Data
#a<-getwd()
#setwd(a)
#options(digits = 8)  
df<-read.csv('./data/KST_MERGED_1_2ord_CSV.csv')

df$lat = as.numeric(format(df$lat, digits = 9))
df$lon = as.numeric(format(df$lon, digits = 9))

df_table<-df[c(3,7,8)]

Green = makeAwesomeIcon(icon = "ios-close", iconColor = "white",
                        library = "ion", markerColor = "green")
Red = makeAwesomeIcon(icon = "ios-close", iconColor = "white",
                      library = "ion", markerColor = "red")


#class(df$lon)
#df<-read.csv("KST_MERGED_1_2ord_CSV_v2.csv",fileEncoding = "UTF-8")

#assign proper url to depending on Order column
df$IconsCol = ifelse(df$Ordnung  ==1,
                     "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png",
                     "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png")


#df$ord1<-df$Ord == "1"
#df$ord2<-df$Ord == "2"


ui <- fluidPage(
  h1("Königlich-Sächsische Triangulirung"),
  #h2("Royal Saxon Triangulation Network"),
  p(style = "font-family:Impact",
    " ",
    a("Wikipedia",
      href = "https://de.wikipedia.org/wiki/K%C3%B6niglich-S%C3%A4chsische_Triangulirung")
  ),
  sidebarLayout(sidebarPanel(
    leafletOutput("my_leaf"),width = 8),
    mainPanel(sliderInput(inputId = "slider", 
                          label = "Wählen Sie den Höhenbereich [m]",
                          min = min(df$Hoehe),
                          max = max(df$Hoehe),
                          value = c(min,max),
                          step = 10),
              DT::dataTableOutput("my_table"),width = 4)
  )
)




server <- function(input, output){
  #df <- mydata
  ## create static element
  
  
  output$my_leaf <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$OpenTopoMap, group='Topo') %>%
      addProviderTiles(providers$Esri.WorldImagery, group='Satellite')%>%
      addLayersControl(baseGroups = c('Topo', 'Satellite'))%>%
      #setView(11.643167,50.278278, zoom = 7)%>%
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
  
  
  ## debug filter data
  #df_filtered <- reactive({df[df$Hoehe >= 850, ]    })
  
  # return the reactive valure (filtered records df$Hoehe >= 1000)
  #pippo<-reactiveValues(df_filtered())
  #pippo<-get(isolate(df_filtered)) 
  #expr_q<-quote({df_filtered()})
  ##  filter data
  #values <- reactiveValues()
  df_filtered <- reactive({
    df[df$Hoehe >= input$slider[1] & df$Hoehe <= input$slider[2] , ]
  }
  )
  df_table_filtered <- reactive({
    df_table[df_table$Hoehe >= input$slider[1] & df_table$Hoehe <= input$slider[2] , ]
  }
  )
  
  
  #values <- reactiveValues(df_filtered())
  ## icons
  #https://github.com/pointhi/leaflet-color-markers
  
  #pippo<- isolate(df_filtered())
  ## respond to the filtered data
  observe({
    
    red_df = dplyr::filter(df_filtered(),Ordnung == 1)
    green_df = dplyr::filter(df_filtered(),Ordnung == 2)
    
    proxy<-leafletProxy(mapId = "my_leaf", data = df_filtered()) %>%
      flyToBounds(lng1 = max(df_filtered()$lon),lat1 = max(df_filtered()$lat),
                  lng2 = min(df_filtered()$lon),lat2 = min(df_filtered()$lat),
                  options = list(maxZoom = 12))%>%
      clearMarkers() %>%
      addAwesomeMarkers(lng = red_df$lon,
                        lat = red_df$lat,
                        #group =c(df_filtered()$Order),
                        #icon = icons(iconUrl ="https://github.com/twbs/icons/blob/master/icons/arrow-right.svg"),
                        icon =  Red,
                        # #iconAnchorX = 0,
                        # #iconAnchorY = 0,
                        # #iconHeight = 40,
                        # #iconWidth = 25,
                        popup = paste("<b><a href='",red_df$wiki_url,"'>",
                                      red_df$Name,"</a></b>","<br>","<img src = '",
                                      red_df$img_url, "'>")
                        # 
                        ## clear previous markers
                        #proxy<-proxy%>%
                        
      ) %>% 
      addAwesomeMarkers(lng = green_df$lon,
                        lat = green_df$lat,
                        #group =c(df_filtered()$Order),
                        #icon = icons(iconUrl ="https://github.com/twbs/icons/blob/master/icons/arrow-right.svg"),
                        icon =  Green,
                        # #iconAnchorX = 0,
                        # #iconAnchorY = 0,
                        # #iconHeight = 40,
                        # #iconWidth = 25,
                        popup = paste("<b><a href='",green_df$wiki_url,"'>",
                                      green_df$Name,"</a></b>","<br>","<img src = '",
                                      green_df$img_url, "'>")
                        # 
                        ## clear previous markers
                        #proxy<-proxy%>%
                        
      ) 
    #  addMarkers(icon =icons(iconUrl = df_filtered()$IconsCol, iconAnchorX = 0,iconAnchorY = 0,iconHeight = 40,iconWidth = 25),
    #           popup = paste("<b><a href='",df_filtered()$wiki_url,"'>",
    #                         df_filtered()$Name,"</a></b>","<br>","<img src = '",
    #                         df_filtered()$img_url, "'>"),
    #            )## clear previous markers
    # proxy<-proxy%>%
    #     flyToBounds(lng1 = max(df_filtered()$lon),lat1 = max(df_filtered()$lat),
    #                 lng2 = min(df_filtered()$lon),lat2 = min(df_filtered()$lat),
    #                 options = list(maxZoom = 12))           
    
    #output$my_table<- renderTable(c(as.character(df_filtered()$Name),
    # as.character(df_filtered()$Hoehe)))
    output$my_table<- DT::renderDataTable(DT::datatable(
      df_table_filtered(),
      options = list(pageLength = 10),
      rownames = FALSE))
  })
}

shinyApp(ui, server)


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

