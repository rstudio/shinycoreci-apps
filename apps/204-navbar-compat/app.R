library(shiny)

ui <- fluidPage(
  theme = bootstraplib::bs_theme(bootswatch = "cosmo"),
  tags$style(
    "h4 { margin-top: 100px; text-align: center; }"
  ),

  h4("bs3 navbarPage"),
  navbarPage("Test", collapsible = TRUE, inverse = TRUE,
    tabPanel("One",
      "One"
    ),
    tabPanel("Two",
      icon = icon("download"),
      "Two"
    ),
    navbarMenu("A submenu",
      tabPanel("Five", "Five"),
      "---",
      tabPanel("Six", "Six"),
      tabPanel("Seven", "Seven")
    )
  ),

  h4("bs4 navbar"),
  includeHTML("bs4.html"),

  h4("bs3 rmarkdown site navbar"),
  includeHTML("rmdsite.html"),

  h4("bs3 tabsetPanel"),
  tabsetPanel(
    tabPanel("Three",
      "Three"
    ),
    tabPanel("Four",
      "Four",
      icon = icon("cloud")
    ),
    navbarMenu("Dropdown",
      tabPanel("Five",
        "Five"
      )
    )
  ),

  h4("bs4 tabs"),
  includeHTML("bs4tabs.html"),

  h4("bs3 tabsetPanel(type=\"pills\")"),
  tabsetPanel(type = "pills",
    tabPanel("Three",
      "Three"
    ),
    tabPanel("Four",
      "Four",
      icon = icon("cloud")
    ),
    navbarMenu("Dropdown",
      tabPanel("Five",
        "Five"
      )
    )
  ),

  h4("bs4 pills"),
  includeHTML("bs4pills.html"),

  tags$br(),
  tags$br(),
  tags$br(),
  tags$br()
)

# .navbar-expand .navbar-nav .nav-link
# .navbar-expand ul.nav.navbar-nav > li > a

server <- function(input, output, session) {

}

shinyApp(ui, server)
