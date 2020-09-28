# IF YOU CHANGE THIS APP, YOU LIKELY WANT TO COPY THOSE CHANGES OVER TO APPS 195-198
library(shiny)
library(bootstraplib)
shinyApp(
  navbarPage(
    theme = bs_theme(base_font = "Grandstander"),
    title = "Bootstrap 4 Light Mode", id = "navbar",
    tabPanel(
      "Inputs",
      tabsetPanel(
        type = "pills",
        id = "inputsNav",
        tabPanel(
          "Special",
          br(),
          h4("Here are some 'special' inputs within an inputPanel():"),
          inputPanel(
            sliderInput("slider", "sliderInput()", min = 0, max = 100, value = c(30, 70)),
            selectInput("selectize", "selectizeInput()", choices = state.abb),
            selectInput("selectizeMulti", "selectizeInput(multiple=T)", choices = state.abb, multiple = TRUE),
            dateInput("date", "dateInput()", value = Sys.Date()),
            dateRangeInput("dateRange", "dateRangeInput()", start = Sys.Date(), end = Sys.Date() + 7)
          ),
          br(),
          textOutput("specialInputHeader"),
          br(),
          verbatimTextOutput("specialInputs")
        ),
        tabPanel(
          "Basic",
          br(),
          h4("Basic HTML inputs within a wellPanel():"),
          wellPanel(
            fluidRow(
              column(
                6,
                selectInput("select", "selectInput()", choices = state.abb, selectize = FALSE),
                selectInput("selectMulti", "selectInput(multiple=T)", choices = state.abb, multiple = TRUE, selectize = FALSE),
                textInput("text", "textInput()", placeholder = "Enter some text"),
                numericInput("numeric", "numericInput()", value = 0)
              ),
              column(
                6,
                passwordInput("password", "passwordInput()", "secret"),
                textAreaInput("textArea", "textAreaInput()", placeholder = "A text area"),
                checkboxInput("check", "checkboxInput()", value = TRUE),
                checkboxGroupInput("checkGroup", "checkboxGroupInput()", choices = c("A", "B")),
                radioButtons("radioButtons", "radioButtons()", choices = c("A", "B"))
              )
            )
          ),
          br(),
          textOutput("basicInputHeader"),
          br(),
          verbatimTextOutput("basicInputs")
        )
      )
    ),
    tabPanel(
      "Tables",
      DT::dataTableOutput("DT")
    ),
    tabPanel(
      "Other",
      tabsetPanel(
        id = "otherNav",
        tabPanel(
          "Messages",
          br(),
          actionButton("showProgress", "Progress", style = "margin: 1rem"),
          actionButton("showModal", "Modals", style = "margin: 1rem"),
          lapply(c("default", "message", "warning", "error"), function(x) {
            X <- tools::toTitleCase(x)
            class <- switch(x, message = "btn-info", warning = "btn-warning", error = "btn-danger")
            actionButton(
              paste0("show", X), paste(X, "notification"),
              class = class, style = "margin: 1rem"
            )
          })
        ),
        tabPanel(
          "Uploads & Downloads",
          br(),
          fileInput("file", "fileInput()"),
          downloadButton("downloadButton", "downloadButton()", style = "margin: 1rem"),
          downloadLink("downloadLink", "downloadLink()", style = "margin: 1rem")
        )
      )
    ),
    tags$head(
      tags$link(rel="stylesheet", href="https://fonts.googleapis.com/css?family=Grandstander")
    )
  ),
  function(input, output, session) {
    output$DT <- DT::renderDataTable(DT::datatable(mtcars))

    # Display hello modal only if we're not running inside shinytest
    showHelloModal <- reactiveVal(!getOption("shiny.testmode", FALSE))
    observe({
      if (!showHelloModal()) {
        return()
      }
      showModal(helloModal("light"))
      showHelloModal(FALSE)
    })

    output$specialInputHeader <- renderText({
      "Here are the values bound to each input widget above"
    })

    output$specialInputs <- renderPrint({
      str(list(
        sliderInput = input$slider,
        selectizeInput = input$selectize,
        selectizeMultiInput = input$selectizeMulti,
        dateInput = input$date,
        dateRangeInput = input$dateRange
      ))
    })

    output$basicInputHeader <- renderText({
      "Here are the values bound to each input widget above"
    })

    output$basicInputs <- renderPrint({
      str(list(
        selectInput = input$select,
        selectMultiInput = input$selectMulti,
        textInput = input$text,
        numericInput = input$numeric,
        passwordInput = input$password,
        textAreaInput = input$textArea,
        checkInput = input$check,
        checkGroupInput = input$checkGroup,
        radioButtonsInput = input$radioButtons
      ))
    })

    observeEvent(input$showModal, {
      showModal(modalDialog(
        title = "Somewhat important message",
        "This is a somewhat important message.",
        easyClose = TRUE,
        footer = modalButton("Close")
      ))
    })

    fake_progress <- function(style = "notification") {
      progress <- Progress$new(session, min=1, max=3, style=style)
      progress$set(message = 'Calculation in progress',
                   detail = 'This may take a while...')
      for (i in 1:3) {
        progress$set(value = i)
        Sys.sleep(2)
      }
      progress$close()
    }

    observeEvent(input$showProgress, {
      fake_progress("old")
      #fake_progress()
    })

    lapply(c("default", "message", "warning", "error"), function(x) {
      X <- tools::toTitleCase(x)
      observeEvent(input[[paste0("show", X)]], {
        showNotification(paste(X, "notification styling"), type = x)
      })
    })

  }
)
