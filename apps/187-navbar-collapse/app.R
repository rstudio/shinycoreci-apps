library(shiny)

msg <- tags$h6(
  "If it isn't already, make your window narrow enough so that a menu appears above (and to the right). ",
  "Clicking that menu should show (and hide) a nav dropdown. ",
  "Confirm that the nav dropdown can be shown/hidden, and that you can click",
  "'Summary' to view a data summary (and 'Plot' to see a plot)."
)

jster <- shinyjster::shinyjster_js(
  "
    var jst = jster(0);
    jst.add(Jster.shiny.waitUntilStable);
    var toggle;
    var nav;
    jst.add(function() {
       toggle = $('.navbar-toggle:visible');
       nav    = $('.navbar-collapse:visible');
       
       Jster.assert.isEqual(toggle.length, 1, 'Failed to find collapsible menu, does the window need to be resized?');
       Jster.assert.isEqual(nav.length, 0, 'The collapsible navbar should not be visible by default');
    });

    jst.add(function(done) {
       toggle.click(done);
    });

    jst.add(function() {
      Jster.assert.isEqual(nav.length, 1, 'Clicking the navbar toggle should make the navbar appear.');
    });

    jst.test();
    "
)

ui <- navbarPage(
  "", collapsible = TRUE,
  tabPanel("Plot", msg, plotOutput("plot")),
  tabPanel("Summary", msg, verbatimTextOutput("summary"), jster)
)

server <- function(input, output, session) {
  shinyjster::shinyjster_server(input, output, session)

  output$plot <- renderPlot(plot(cars))
  output$summary <- renderPrint(summary(cars))
}

shinyApp(ui, server)
