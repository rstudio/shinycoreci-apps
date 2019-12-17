library(shiny)
library(shinyjster)

ui <- fluidPage(
  h3("Pressing \"Clear\" should clear the plot."),
  plotOutput("plot"),
  actionButton("clear", "Clear"),

  shinyjster_js("
    var jst = jster();
    jst.add(function() { $('#clear').click(); });
    jst.add(Jster.shiny.waitUntilIdle);
    jst.add(function() {
      if ($('#plot').children().length > 0) {
        throw 'Plot is not empty.';
      }
    });
    jst.test();
    "
  )
)

server <- function(input, output, session) {
  shinyjster_server(input, output, session)

  output$plot <- renderPlot({ plot(cars) })

  observeEvent(input$clear, {
    output$plot <- NULL
  })
}

shinyApp(ui, server)
