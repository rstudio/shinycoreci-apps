### Keep this line to manually test this shiny application. Do not edit this line; shinycoreci::::is_manual_app
library(shiny)

msg <- tags$h6(
  "If it isn't already, make your window narrow enough so that a menu appears above (and to the right). ",
  "Clicking that menu should show (and hide) a nav dropdown. ",
  "Confirm that the nav dropdown can be shown/hidden, and that you can click",
  "'Summary' to view a data summary (and 'Plot' to see a plot)."
)

ui <- navbarPage(
  "", collapsible = TRUE,
  tabPanel("Plot", msg, plotOutput("plot")),
  tabPanel("Summary", msg, verbatimTextOutput("summary"))
)

server <- function(input, output, session) {
  output$plot <- renderPlot(plot(cars))
  output$summary <- renderPrint(summary(cars))
}

shinyApp(ui, server)
