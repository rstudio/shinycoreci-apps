library(shiny)

ui <- fluidPage(
  shinyjster::shinyjster_js("
    var jst = jster(1);
    jst.add(Jster.shiny.waitUntilStable);

    jst.add(function() { Jster.assert.isEqual(window.insert_ui_script, true); });
    "
  )
)

server <- function(input, output) {
  shinyjster::shinyjster_server(input, output)

  observe({
    insertUI(
      selector = "head",
      ui = tags$script("window.insert_ui_script = true")
    )
  })
}

shinyApp(ui, server)
