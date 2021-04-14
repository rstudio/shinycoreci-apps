#App to test insert tab and insert tab in dropdown Menu.
#Related to https://github.com/rstudio/shiny/pull/3315

library(shiny)
library(bslib)

ui <- fluidPage(
  theme = bs_theme(),
  sidebarLayout(
    sidebarPanel(
      actionButton("add", "Add 'Dynamic' tab"),
      actionButton("remove", "Remove 'Foo' tab"),
      actionButton("addFoo", "Add New 'Foo' tab")
    ),
    mainPanel(
      tabsetPanel(
        id = "tabs",
        tabPanel("Hello", "This is the hello tab"),
        tabPanel("Foo", "This is the foo tab"),
        navbarMenu(menuName = "Menu",
          "Static",
          tabPanel("Static 1", "Static 1", value = "s1"),
          tabPanel("Static 2", "Static 2", value = "s2")
        ),
        tabPanel("Footest", "This is the footest tab",value = "f")
      )
    )
  )
)
server <- function(input, output, session) {
  observeEvent(input$add, {
    insertTab(
      inputId = "tabs",
      tabPanel("Dynamic", "Dynamic"),
      target = "s2"
    )
  })
  observeEvent(input$remove, {
    removeTab(inputId = "tabs", target = "Foo")
  })
  observeEvent(input$addFoo, {
    insertTab(
      inputId = "tabs",
      tabPanel("Foo", "This is the new foo tab"),
      target = "Menu",
      position = "before",
      select = TRUE)
  })

}

shinyApp(ui, server)
