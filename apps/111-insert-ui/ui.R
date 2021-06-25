library(shiny)

fluidPage(theme = bslib::bs_theme(version=5), 
  actionButton('insertBtn', 'Insert'), 
  actionButton('removeBtn', 'Remove'), 
  tags$div(id = 'placeholder') 
)
