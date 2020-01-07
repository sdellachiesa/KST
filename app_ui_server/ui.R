
ui <- fluidPage(
  sliderInput(inputId = "slider", 
              label = "Filter Station by Elevation",
              min = min(df$Elevation),
              max = max(df$Elevation),
              value = 92,
              step = 10),
  leafletOutput("my_leaf")
)
