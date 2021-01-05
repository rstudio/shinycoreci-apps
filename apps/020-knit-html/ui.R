fluidPage(theme = bslib::bs_theme(),
  title = 'Embed an HTML report from R Markdown/knitr',
  sidebarLayout(
    sidebarPanel(
      withMathJax(),  # include the MathJax library
      selectInput('x', 'Build a regression model of mpg against:',
                  choices = names(mtcars)[-1])
    ),
    mainPanel(
      uiOutput('report')
    )
  )
)
