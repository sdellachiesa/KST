if (!require("shiny")) install.packages("shiny")
if (!require("leaflet")) install.packages("leaflet")
if (!require("leaflet.providers")) install.packages("leaflet.providers")
if (!require("magrittr")) install.packages("magrittr")
if (!require("RColorBrewer")) install.packages("RColorBrewer")
if (!require("dplyr")) install.packages("dplyr")

# --- Load Data

mymap<-read.csv("KSTS_1_2ord_CSV.csv", stringsAsFactors=F)


# Define UI for application that shows a map
ui <- fluidPage(
     # Main panel for Output
  mainPanel(
    # Output: map
    leafletOutput("mymap"),
    p()
  )
)

server <- function(input, output) {
  
  points <- eventReactive(input$recalc, {
    cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
  }, ignoreNULL = FALSE)
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Stamen.TonerLite,
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      addMarkers(~lat,~lon,)
  })
}

shinyApp(ui, server)