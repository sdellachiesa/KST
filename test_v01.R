if (!require("shiny")) install.packages("shiny")
if (!require("leaflet")) install.packages("leaflet")
if (!require("leaflet.providers")) install.packages("leaflet.providers")
if (!require("magrittr")) install.packages("magrittr")
if (!require("RColorBrewer")) install.packages("RColorBrewer")
if (!require("dplyr")) install.packages("dplyr")
if (!require("rsconnect")) install.packages("connect")
if (!require("devtools")) install.packages("devtools")
if (!require("htmltools")) install.packages("htmltools")
if (!require("shinydashboard")) install.packages("shinydashboard")

# --- Load Data
a<-getwd()
setwd(a)
df<-read.csv("KSTS_MERGED_1_2ord_CSV_v2.csv")
df<-read.csv("KSTS_MERGED_1_2ord_CSV_v2.csv",fileEncoding = "UTF-8")
df$ord1<-df$Ord == "1"
df$ord2<-df$Ord == "2"



ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    tags$style(type = "text/css", "#map {height: calc(100vh - 80px) !important;}"),
    leafletOutput("map")
  )
)

server <- function(input, output) {
  output$map <- renderLeaflet({
    leaflet() %>% addTiles() %>% setView(42, 16, 4)
  })
}

runApp(shinyApp(ui, server), launch.browser = TRUE)

