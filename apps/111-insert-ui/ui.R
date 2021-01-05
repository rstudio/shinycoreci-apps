library(shiny)

fluidPage(theme = bslib::bs_theme(), 
  actionButton('insertBtn', 'Insert'), 
  actionButton('removeBtn', 'Remove'), 
  tags$div(id = 'placeholder') 
)
