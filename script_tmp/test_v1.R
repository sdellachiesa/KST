library(shinydashboard)
library(leaflet)

ui <- dashboardPage(
  dashboardHeader(title = "Trigometric Network"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(
        "Layers", 
        tabName = "maps", 
        icon = icon("globe"),
        menuSubItem("Point 1st Order", tabName = "m_water", icon = icon("map")),
        menuSubItem("Point 2nd Order", tabName = "m_pop", icon = icon("map"))
        
              ),
      menuItem(
        "Charts", 
        tabName = "charts", 
        icon = icon("bar-chart"),
        menuSubItem("Watersheds", tabName = "c_water", icon = icon("area-chart")),
        menuSubItem("Population", tabName = "c_pop", icon = icon("area-chart"))
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "m_water",
        box(
          title = "Baltic catchment areas",
          collapsible = TRUE,
          width = "100%",
          height = "100%",
          leafletOutput("l_watershed")
        )
      ),
      tabItem(
        tabName = "m_pop",
        # Map in Dashboard
        leafletOutput("l_population")
      ),
      tabItem(
        tabName = "charts",
        h2("Second tab content")
      )
    )
  )
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$l_watershed <- renderLeaflet({
    leaflet(height = "100%") %>% addTiles() %>% setView(19.08, 60.25, zoom = 4) %>%addWMSTiles(
      "http://62.236.121.188/arcgis/services/DataAndMaps/Background/MapServer/WMSServer?",
      layers = "11",
      options = WMSTileOptions(
        format = "image/png",
        transparent = TRUE
      ),
      attribution = "Catchment area provided by HELCOM"
    )
  })
  
  output$l_population <- renderLeaflet({
    leaflet(height = "100%") %>% addTiles() %>% setView(19.08, 60.25, zoom = 4) %>%addWMSTiles(
      "http://62.236.121.188/arcgis/services/DataAndMaps/Background/MapServer/WMSServer?",
      layers = "17",
      options = WMSTileOptions(
        format = "image/png",
        transparent = TRUE
      ),
      attribution = "Population data provided by HELCOM"
    )
  })
}

shinyApp(ui, server)
