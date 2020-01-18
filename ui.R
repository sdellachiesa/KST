
header <- dashboardHeader(
  title = ("Königlich-Sächsische Triangulierung"),
           titleWidth = 400)





# a("Wikipedia",
#   href = "https://de.wikipedia.org/wiki/K%C3%B6niglich-S%C3%A4chsische_Triangulirung")
# )

body <- dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "./www/bootstrap.css")
  ),
  fluidRow(
    column(width = 6,
           box(width = NULL, status = "warning",
               sliderInput(inputId = "slider",
                           label = "Wählen Sie den Höhenbereich [m]",
                           min = min(df$Hoehe),
                           max = max(df$Hoehe),
                           value = c(min,max),
                           step = 10)
           )
    )
  ),
  fluidRow(
    column(width = 12,
           box(width = NULL,
               tabsetPanel(type = "tabs",
                           tabPanel("Karte", leafletOutput("my_leaf")),
                           tabPanel("Datentabelle", DT::dataTableOutput("my_table")
                           )
               )
           )
    )
  ),
  
  #   )
  # ),
  
  
  # fluidRow(
  #   column(width = 8,
  #          box(width = NULL, solidHeader = TRUE,
  #              leafletOutput("my_leaf", height = 500)
  #          )
  #   ),
  #   column(width = 4,
  #          box(width = NULL,
  #              DT::dataTableOutput("my_table")
  #          )
  #   ),
  #   
  # )
)



dashboardSidebar<- dashboardSidebar(disable = TRUE,
                                    width = NULL,
                                    sidebarMenu(
                                      menuItem("Info:To Be Defined")
                                    ))

dashboardPage(skin = "red",
              header,
              dashboardSidebar,
              body
)
