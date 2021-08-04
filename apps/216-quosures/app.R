library(shiny)
library(DiagrammeR)
library(rlang)

my_quo <- local({
  txt <- "
    graph LR
      A-->B
      A-->C
      C-->E
      B-->D
      C-->D
      D-->F
      E-->F
  "
  quo(
    DiagrammeR(txt)
  )
})


shinyApp(
  ui = fluidPage(
    DiagrammeROutput("example")
  ),
  server = function(input, output) {
    output$example <- renderDiagrammeR(my_quo, quoted = TRUE)
  }
)
