
header <- dashboardHeader(
  title = ("Königlich-Sächsische Triangulierung"),
  titleWidth = 400)





# a("Wikipedia",
#   href = "https://de.wikipedia.org/wiki/K%C3%B6niglich-S%C3%A4chsische_Triangulirung")
# )

body <- dashboardBody(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  tags$a(
    href="https://github.com/stefanodellachiesa/KST",
    tags$img(
      style="position: absolute; top: 0; right: 0; border: 0;z-index: 5;z-index: 5000;",
      src="https://github.blog/wp-content/uploads/2008/12/forkme_right_white_ffffff.png?resize=149%2C149",
      #src="https://github.blog/wp-content/uploads/2008/12/forkme_right_orange_ff7600.png?resize=149%2C149",
      #src="https://github.blog/wp-content/uploads/2008/12/forkme_right_gray_6d6d6d.png?resize=149%2C149",
      #src="https://github.blog/wp-content/uploads/2008/12/forkme_right_red_aa0000.png?resize=149%2C149",
      alt="Fork me on GitHub",
      width="110",
      height="110",
      #class="github-fork-ribbon"
      class="attachment-full size-full",
      #data-recalc-dims="1"
    )
    
  ),
  
  
  # tags$a(
  #   href="https://github.com/stefanodellachiesa/KST",
  #   tags$img(style="position: absolute; top: 0; right: 0; border: 0;z-index: 5;z-index: 5000;",
  #            src="https://github.blog/wp-content/uploads/2008/12/forkme_right_green_007200.png?resize=135%2C135",
  #            alt="Fork me on GitHub",
  #            width="135",
  #            height="135",
  #            class="github-fork-ribbon"
  #            
  #   )
  #   
  # ),
  tabItems(
    tabItem(tabName = "data",
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
            
    ),
    tabItem(# the about page
      tabName = "about",
      tabPanel("About", box(width = NULL,
                            #about$value
                            htmlOutput("about_out")
      )
      )
    )
  )
)

dashboardSidebar<- dashboardSidebar(disable = FALSE,
                                    width = NULL,
                                    sidebarMenuOutput(outputId = 'data'),
                                    sidebarMenuOutput(outputId = 'about')
                                    #sidebarMenu(
                                    # menuItem("Info:To Be Defined")
)

dashboardPage(skin = "red",
              header,
              dashboardSidebar,
              body
)
