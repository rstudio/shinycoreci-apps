library(shiny)
library(shinyvalidate)
library(bslib)

ui <- fluidPage(
  theme = bs_theme(danger = "orange"),
  p("This app was taken from",  a("this PR", href = "https://github.com/rstudio/shinyvalidate/pull/4"), "on the shinyvalidate repo."),
  p("The shinytest starts by fulfilling all requirements and then rebreaking them."),
  textInput("text", ""),
  selectInput("select", "", multiple = TRUE, state.name),
  dateInput("date", ""),
  dateRangeInput("dateRange", ""),
  sliderInput("slider", "", min = 0, max = 100, value = 50, step = 1),
  checkboxInput("checkbox", "", value = FALSE),
  checkboxGroupInput("checkboxGroup", "", choices = c("A", "B")),
  radioButtons("radio", "", choices = c("A", "B"))
)

server <- function(input, output, session) {
  iv <- InputValidator$new()
  iv$add_rule("text", sv_required("Enter some text"))
  iv$add_rule("select", sv_required("Choose a state"))
  iv$add_rule("date", ~if (. <= Sys.Date()) "Choose a future date!")
  iv$add_rule("dateRange", ~if (min(.) <= Sys.Date()) "Choose future dates!")
  iv$add_rule("slider", ~if (. %% 2 == 0) "Choose an odd number!")
  iv$add_rule("checkbox", ~if (!.) "Please check true!")
  iv$add_rule("checkboxGroup", ~if (!identical(., "B")) "Please check (just) B!")
  iv$add_rule("radio", ~if (!identical(., "B")) "Please check B!")
  iv$enable()
}

shinyApp(ui, server)
