library(testthat)
library(shiny)

test_that("counter works", {
  testServer(counterServer, {
    inc <- function(x) if (is.null(x)) 0 else x+1
    expect_equal(count(), 0)
    session$setInputs(button = inc(input$button))
    expect_equal(count(), 1)
    expect_equal(output$out, "1")
    expect_equal(session$returned(), 1)
  })
})
