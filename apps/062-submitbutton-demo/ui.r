fluidPage(theme = bslib::bs_theme(version=5),
  titlePanel("submitButton example"),
  fluidRow(
    column(3, wellPanel(
      sliderInput("n", "N:", min = 10, max = 1000, value = 200,
                  step = 10),
      textInput("text", "Text:", "text here"),
      submitButton("Submit")
    )),
    column(6,
      plotOutput("plot1", width = 400, height = 300),
      verbatimTextOutput("textout")
    )
  )
)
