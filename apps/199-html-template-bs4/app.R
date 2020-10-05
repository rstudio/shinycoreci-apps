library(shiny)
library(bootstraplib)

ui <- htmlTemplate(
  "template.html",
  theme = bs_theme(bg = "black", fg = "white"),
  date = dateInput("date", "Date", value = Sys.Date() - 1),
  date_range = dateRangeInput(
    "date_range", "Date", start = Sys.Date(), end = Sys.Date() + 7
  ),
  select = selectInput("select", "Single", choices = state.abb),
  select_multiple = selectInput("select_multiple", "Multiple", choices = c("Choose a state" = "", state.abb), multiple = TRUE),
  slider = sliderInput("slider", "Slider", min = 0, value = 70, max = 100),
  slider_multiple = sliderInput("slider_multiple", "Multiple", min = 0, value = c(50, 70), max = 100)
)

shinyApp(ui, function(input, output) {})
