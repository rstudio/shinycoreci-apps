library(shiny)
library(rlang)
library(DiagrammeR)


inlineCodeOutput <- function(id) {
  tags$code(textOutput(id, inline = TRUE), .noWS = "inside")
}

shinyApp(
  ui = fluidPage(
    tags$h3(tags$code("shiny::installExprFunction(rlang::quo(x), quoted = TRUE)")),
    tags$p(
      "Init PR allowing quosures to", tags$code("exprToFunction()"), "and",
      tags$code("installExprFunction()"), "with increased usage of",
      tags$code("installExprFunction()"), "within Shiny: ",
      tags$a("https://github.com/rstudio/shiny/pull/3472", href = "https://github.com/rstudio/shiny/pull/3472")
    ),
    actionButton("n", "Click Me!"),
    tags$br(),
    fluidRow(
      column(8,
        fluidRow(
          column(3,
            tags$code("reactive()"), "- Three values of ", inlineCodeOutput("reactive__expected"), ":", tags$br(),
            verbatimTextOutput("reactive__manual", placeholder = TRUE),
            verbatimTextOutput("reactive__quoted", placeholder = TRUE),
            verbatimTextOutput("reactive__injected", placeholder = TRUE)
          ),
          column(3,
            tags$code("renderText()"), "- Three values of ", inlineCodeOutput("text__expected"), ":", tags$br(),
            verbatimTextOutput("text__manual", placeholder = TRUE),
            verbatimTextOutput("text__quoted", placeholder = TRUE),
            verbatimTextOutput("text__injected", placeholder = TRUE)
          ),
          column(3,
            tags$code("renderPrint()"), "- Three values of ", inlineCodeOutput("print__expected"), ":", tags$br(),
            verbatimTextOutput("print__manual", placeholder = TRUE),
            verbatimTextOutput("print__quoted", placeholder = TRUE),
            verbatimTextOutput("print__injected", placeholder = TRUE)
          ),
          column(3,
            tags$code("observe()"), "-", inlineCodeOutput("observe__expected"), ":", tags$br(),
            verbatimTextOutput("observe__rv", placeholder = TRUE),
            tags$code("observeEvent()"), "-", inlineCodeOutput("observe_event__expected"), ":", tags$br(),
            verbatimTextOutput("observe_event__rv", placeholder = TRUE),
            tags$code("eventReactive()"), "-", inlineCodeOutput("event__expected"), ":", tags$br(),
            verbatimTextOutput("event__value", placeholder = TRUE)
          )
        ),
        fluidRow(
          column(5,
            "External", tags$code("htmlwidgets"), "- Three diagrammer models that point to letter: ", inlineCodeOutput("render__expected"), tags$br(),
            DiagrammeROutput("render__manual"),
            DiagrammeROutput("render__quoted"),
            DiagrammeROutput("render__injected")
          ),
          column(3,
            tags$code("renderTable()"), "- Three tables of first ", inlineCodeOutput("table__expected"), "rows", tags$br(),
            tableOutput("table__manual"),
            tableOutput("table__quoted"),
            tableOutput("table__injected")
          ),
          column(4,
            tags$code("renderImage()"), "- Three", inlineCodeOutput("image__expected"), " images:", tags$br(),
            imageOutput("image__manual", height = 150),
            imageOutput("image__quoted", height = 150),
            imageOutput("image__injected", height = 150)
          )
        )
      ),
      column(4,
        tags$code("renderPlot()"), "- Three plots of", inlineCodeOutput("plot__expected"), ":", tags$br(),
        plotOutput("plot__manual", height = 250),
        plotOutput("plot__quoted", height = 250),
        plotOutput("plot__injected", height = 250)
      )
    )
  ),
  server = function(input, output) {

    dia_quo <- local({
      txt <- function(x) {
        paste0("
        graph LR
          A-->B
          A-->C
          C-->E
          B-->D
          C-->D
          D-->F[", letters[x %% length(letters)], "]
          E-->F
      ")
      }
      quo({
        DiagrammeR(txt(input$n + 6))
      })
    })

    r_quo <- local({
      a <- 10
      quo(as.numeric(a + input$n))
    })

    event_quo <- local({
      a <- 1
      quo({
        input$n + a
      })
    })
    observe_rv <- reactiveVal(NULL)
    observe_quo <- local({
      txt <- "Clicks: "
      quo({
        observe_rv(
          paste0(txt, input$n)
        )
      })
    })
    handler_rv <- reactiveVal(NULL)
    handler_quo <- local({
      txt <- "Clicks: "
      quo({
        handler_rv(
          paste0(txt, input$n)
        )
      })
    })
    value_quo <- local({
      txt <- "Clicks: "
      quo({
        paste0(txt, input$n)
      })
    })

    plot_quo <- local({
      k <- 5
      quo({
        n <- input$n + k
        x <- 1:n
        y <- 1:n
        plot(x, y)
      })
    })

    table_quo <- local({
      k <- 3
      quo({
        head(cars, input$n %% 3 + k)
      })
    })

    image_quo <- local({
      face <- "images/face.png"
      bear <- "images/bear.png"
      quo({
        if (input$n %% 2 == 0) {
          list(
            src = bear,
            height = "150px",
            width = "150px",
            contentType = "image/png",
            alt = "Deadlift"
          )
        } else {
          list(
            src = face,
            height = "150px",
            width = "150px",
            contentType = "image/png",
            alt = "Face"
          )
        }
      })
    })

    r_manual <- reactive(quo_get_expr(r_quo), env = quo_get_env(r_quo), quoted = TRUE)
    r_quoted <- reactive(r_quo, quoted = TRUE)
    r_injected <- inject(reactive(!!r_quo))
    output$reactive__expected <- renderText({input$n + 10})
    output$reactive__manual <- renderText({ r_manual() })
    output$reactive__quoted <- renderText({ r_quoted() })
    output$reactive__injected <- renderText({ r_injected() })

    output$text__expected <- renderText({input$n + 10})
    output$text__manual <- renderText(quo_get_expr(r_quo), env = quo_get_env(r_quo), quoted = TRUE)
    output$text__quoted <- renderText(r_quo, quoted = TRUE)
    output$text__injected <- inject(renderText(!!r_quo))

    output$print__expected <- renderPrint({as.numeric(input$n + 10)})
    output$print__manual <- renderPrint(quo_get_expr(r_quo), env = quo_get_env(r_quo), quoted = TRUE)
    output$print__quoted <- renderPrint(r_quo, quoted = TRUE)
    output$print__injected <- inject(renderPrint(!!r_quo))

    output$render__expected <- renderText(letters[(input$n + 6) %% length(letters)])
    output$render__manual <- renderDiagrammeR(quo_get_expr(dia_quo), env = quo_get_env(dia_quo), quoted = TRUE)
    output$render__quoted <- renderDiagrammeR(dia_quo, quoted = TRUE)
    output$render__injected <- inject(renderDiagrammeR(!!dia_quo))

    output$plot__expected <- renderText(paste0("1:", input$n + 5))
    output$plot__manual <- renderPlot(quo_get_expr(plot_quo), env = quo_get_env(plot_quo), quoted = TRUE)
    output$plot__quoted <- renderPlot(plot_quo, quoted = TRUE)
    output$plot__injected <- inject(renderPlot(!!plot_quo))

    output$table__expected <- renderText(input$n %% 3 + 3)
    output$table__manual <- renderTable(quo_get_expr(table_quo), env = quo_get_env(table_quo), quoted = TRUE)
    output$table__quoted <- renderTable(table_quo, quoted = TRUE)
    output$table__injected <- inject(renderTable(!!table_quo))

    ex_quo <- quo({
      paste0("Clicks: ", input$n)
    })
    output$observe__expected <- renderText(ex_quo, quoted = TRUE)
    output$observe_event__expected <- renderText(ex_quo, quoted = TRUE)
    output$event__expected <- renderText(ex_quo, quoted = TRUE)

    # Manual only. Injected is easier to detect/handle in code
    observe(
      observe_quo,
      quoted = TRUE
    )
    output$observe__rv <- renderText(observe_rv())
    # Manual only. Injected is easier to detect/handle in code
    observeEvent(
      eventExpr = event_quo,
      handlerExpr = handler_quo,
      event.quoted = TRUE,
      handler.quoted = TRUE
    )
    output$observe_event__rv <- renderText(handler_rv())
    # Manual only. Injected is easier to detect/handle in code
    event_ret <- eventReactive(
      eventExpr = event_quo,
      valueExpr = value_quo,
      event.quoted = TRUE,
      value.quoted = TRUE
    )
    output$event__value <- renderText(event_ret())

    output$image__expected <- renderText({
      if (input$n %% 2 == 0) {
        "bear lifting"
      } else {
        "shocked face"
      }
    })
    output$image__manual <- renderImage(quo_get_expr(image_quo), env = quo_get_env(image_quo), quoted = TRUE, deleteFile = FALSE)
    output$image__quoted <- renderImage(image_quo, quoted = TRUE, deleteFile = FALSE)
    output$image__injected <- inject(renderImage(!!image_quo, deleteFile = FALSE))


  }
)
