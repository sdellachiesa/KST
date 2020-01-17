ui <- fluidPage( 
  #img(src="./www/KST_Logo.png", align = "right",height='50px',width='100px'),
  #titlePanel(title=div(img(src="./www/KST_Logo.jpg",align = "right",height = 50, width = 100))),
  #<a href="https://github.com/sdellachiesa"><img width="149" height="149" src="https://github.blog/wp-content/uploads/2008/12/forkme_right_green_007200.png?resize=149%2C149" class="attachment-full size-full" alt="Fork me on GitHub" data-recalc-dims="1"></a>
  h1("Königlich-Sächsische Triangulierung"),
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
