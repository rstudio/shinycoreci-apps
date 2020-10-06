library(shiny)

ui <- fluidPage(
  theme = bootstraplib::bs_theme(bootswatch = "cosmo"),
  actionButton('insertBtn', 'Insert'),
  actionButton('removeBtn', 'Remove'),
  HTML("&nbsp;"),
  actionButton('showBtn', 'Show'),
  actionButton('hideBtn', 'Hide'),
  tabsetPanel(id = "tabs",
    tabPanel(value = "base", "Base tab", "This is a non-removable base tab")
  ),
  tags$div(id = 'placeholder'),
  "Hi",
  #tags$div(class = "card bg-light p-3", "Hello")
  wellPanel("Hello"),
  fileInput("file", "File"),
  tags$input(class = "form-control form-control-sm"),
  helpText("This is help text"),
  titlePanel("Application Title"),
  selectInput("select", "Select", choices = LETTERS, selected = LETTERS[1:3], multiple = TRUE),
  dateRangeInput("dates", "Dates"),
  navlistPanel(
    tabPanel("First", "1st"),
    tabPanel("Second", "2nd"),
    tabPanel("Third", "3rd")
  ),
  checkboxInput("check", "Checked?", TRUE),
  fluidRow(
    column(6,
      checkboxGroupInput("check", "Normal check group", choices = replicate(3, praise::praise())),
      verbatimTextOutput("check_out")
    ),
    column(6,
      checkboxGroupInput("check_inline", "Inline check group", inline = TRUE, choices = replicate(3, praise::praise())),
      verbatimTextOutput("check_inline_out")
    )
  ),
  fluidRow(
    column(6,
      radioButtons("radio", "Radio!", choices = replicate(3, praise::praise())),
      verbatimTextOutput("radio_out")
    ),
    column(6,
      radioButtons("radio_inline", "Radio!", inline = TRUE, choices = replicate(3, praise::praise())),
      verbatimTextOutput("radio_inline_out")
    )
  )
)

server <- function(input, output, session) {

  observe(print(input$tabs))

  val <- 0L
  ## keep track of elements inserted and not yet removed
  inserted <- c()

  observeEvent(input$insertBtn, {
    value <- as.character(val)
    inserted <<- c(inserted, value)
    val <<- val + 1L
    insertTab(
      "tabs",
      navbarMenu(
        value,
        tabPanel("A", "A+ content"),
        "-----",
        tabPanel("B", "B- content")
      ),
      #tabPanel(
      #  value = value,
      #  format(Sys.time()),
      #  format(Sys.time())
      #),
      target = NULL,
      select = FALSE
    )
  })

  observeEvent(input$removeBtn, {
    if (!length(inserted)) {
      return()
    }
    removeTab("tabs", tail(inserted, 1))
    inserted <<- head(inserted, -1)
  })

  observeEvent(input$showBtn, {
    showTab("tabs", "base")
  })

  observeEvent(input$hideBtn, {
    hideTab("tabs", "base")
  })

  output$check_out <- renderPrint({
    input$check
  })

  output$radio_out <- renderPrint({
    input$radio
  })

  output$check_inline_out <- renderPrint({
    input$check_inline
  })

  output$radio_inline_out <- renderPrint({
    input$radio_inline
  })

  fake_progress <- function(style = "notification") {
    progress <- Progress$new(session, min=1, max=3, style=style)
    progress$set(message = 'Calculation in progress',
                 detail = 'This may take a while...')
    for (i in 1:3) {
      progress$set(value = i)
      Sys.sleep(1)
    }
    progress$close()
  }

  observe({
    fake_progress("old")
    fake_progress()
  })

}

shinyApp(ui, server)
