library(shiny)
library(pryr)

# It's possible for this test to fail when reactlog is enabled
op <- options(shiny.reactlog = FALSE)
onStop(function() {
  options(op)
})

ui <- fluidPage(
  p("This application tests if", code("invalidateLater"),
    "causes significant memory leakage. (",
    a("#2555", href = "https://github.com/rstudio/shiny/pull/2555", .noWS = "outside"),
    ")"
  ),
  p("After five iterations it will print out whether it passed or failed."),
  plotOutput("hist1"),

  tags$table(
    tags$tr(tags$td("Iteration:"), tags$td(verbatimTextOutput("iteration"))),
    tags$tr(tags$td("Memory usage:"), tags$td(verbatimTextOutput("memory"))),
    tags$tr(tags$td("Increase:"), tags$td(verbatimTextOutput("increase"))),
    tags$tr(tags$td("Status:"), tags$td(uiOutput("status")))
  ),
  shinyjster::shinyjster_js("
    var jst = jster(500);
    jst.add(function(done) {
      var wait = function() {
        var txt = $('#status').text().trim();
        if (txt === '') {
          setTimeout(wait, 50);
        } else {
          done();
        }
      }
      wait();
    });

    var bad_counter = 0;
    var n = 20;
    var tolerance = Math.floor(n / 10);
    for (var i = 0; i < n; i++) {
      (function(ii) {
        jst.add(function() {
          var txt = $('#status').text().trim();
          if (txt !== 'Pass') {
            bad_counter++;
          }
        })
      })()
    }
    jst.add(function() {
      Jster.assert.isTrue(bad_counter <= tolerance, {bad_counter: bad_counter, tolerance: tolerance, n: n})
    })

    jst.test();
  ")
)

server <- function(input, output, session) {
  shinyjster::shinyjster_server(input, output)

  i <- 0
  last_mem <- mem_used()

  output$hist1 <- renderPlot({
    invalidateLater(500)
    plot(c(1:100))
  })

  info <- reactive({
    invalidateLater(500)
    cur_mem <- mem_used()
    on.exit({
      i <<- i + 1
      last_mem <<- cur_mem
    })
    increase <- cur_mem - last_mem

    list(
      i = i,
      cur_mem = cur_mem,
      increase = increase
    )
  })

  output$iteration <- renderText({
    info()$i
  })
  output$memory <- renderText({
    info()$cur_mem
  })
  output$increase <- renderText({
    info()$increase
  })
  output$status <- renderUI({
    if (info()$i < 5) {
      return("");
    }
    if (info()$increase <= 512) {
      p(style = "color:green;", "Pass")
    } else {
      p(style = "color:red;", "Fail: Leaking too much memory!")
    }
  })

}

shinyApp(ui,server)
