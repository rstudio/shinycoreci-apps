function(input, output) {
  output$plot1 <- renderPlot({
    hist(rnorm(input$n))
  })

  output$textout <- renderText({
    paste("Input text is:", input$text)
  })
}
