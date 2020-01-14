ui <- fluidPage(
  h1("Königlich-Sächsische Triangulirung"),
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