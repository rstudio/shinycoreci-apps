library(shiny)
library(shinyjster)

my_ui <- function(id) {
  ns <- NS(id)
  verbatimTextOutput(ns("txt"), placeholder = TRUE)
}

my_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    shinyOptions("my_option" = "This is my_option")

    output$txt <- renderText(getShinyOption("my_option"))
  })
}

shinyApp(
  fluidPage(
    my_ui("foo"),
    shinyjster_js("
      var jst = jster();
      // Wait for renderUIs to complete
      jst.add(Jster.shiny.waitUntilIdleFor(1000));

      jst.add(function() { Jster.assert.isEqual($('#foo-txt').text(), 'This is my_option') });

      jst.test();
    ")

  ),
  function(input, output, session) {
    shinyjster::shinyjster_server(input, output, session)
    my_server("foo")
  }
)