library(shiny)
library(shinyvalidate)
library(bslib)


my_theme <- bs_theme(bootswatch = "darkly")
ui <- fluidPage(
  theme = my_theme,
  radioButtons("current_theme", "Choose a theme for bslib", choices = c("darkly", "flatly", "minty")),
  p("This app was taken from",  a("this PR", href = "https://github.com/rstudio/shinyvalidate/pull/4"), "on the shinyvalidate repo."),
  p("The shinytest starts by fulfilling all requirements and then rebreaking them."),
  textInput("text", ""),
  selectInput("select", "", multiple = TRUE, state.name),
  dateInput("date", "", value = "2020-12-09"),
  dateRangeInput("dateRange", "", start = "2020-12-09", end = "2020-12-11"),
  sliderInput("slider", "", min = 0, max = 100, value = 50, step = 1),
  checkboxInput("checkbox", "", value = FALSE),
  checkboxGroupInput("checkboxGroup", "", choices = c("A", "B")),
  radioButtons("radio", "", choices = c("A", "B"))
)

server <- function(input, output, session) {
  iv <- InputValidator$new()
  iv$add_rule("text", sv_required("Enter some text"))
  iv$add_rule("select", sv_required("Choose a state"))
  iv$add_rule("date", ~if (. <= as.Date("2020-12-10")) "Choose a date after Dec 10th, 2020!")
  iv$add_rule("dateRange", ~if (min(.) <= as.Date("2020-12-10")) "Choose range after Dec 10th, 2020!")
  iv$add_rule("slider", ~if (. %% 2 == 0) "Choose an odd number!")
  iv$add_rule("checkbox", ~if (!.) "Please check true!")
  iv$add_rule("checkboxGroup", ~if (!identical(., "B")) "Please check (just) B!")
  iv$add_rule("radio", ~if (!identical(., "B")) "Please check B!")
  iv$enable()

  # Taken from
  # https://github.com/rstudio/bslib/blob/master/R/bs-theme-preview.R#L300-L302
  # To setup the proper sass variables to inject for theme changing related to
  # bootswatch change
  # We reimplement this here so we can expose the input to shinytest for testing
  themer_opts <- bslib:::opts_metadata()
  themer_vars <- unlist(unname(lapply(themer_opts, names)))
  sass_vars <- setdiff(themer_vars, "bootswatch")

  observe({
    # Watch for the change request here
    my_theme <<- bslib:::set_current_theme(
      my_theme, list(bootswatch = input$current_theme), session
    )
    vals <- as.list(bs_get_variables(my_theme, sass_vars))
    session$sendCustomMessage("bs-themer-bootswatch", list(values = vals))
  })
}

shinyApp(ui, server)
