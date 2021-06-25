fluidPage(theme = bslib::bs_theme(version=5),
  titlePanel('File download'),
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:", 
                  choices = c("Rock", "Pressure", "Cars")),
      radioButtons("filetype", "File type:",
                   choices = c("csv", "tsv")),
      downloadButton('downloadData', 'Download')
    ),
    mainPanel(
      tableOutput('table')
    )
  )
)
