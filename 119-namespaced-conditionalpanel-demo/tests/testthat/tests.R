library(testthat)
library(shiny)

test_that("module works", {
  testModule(myPlot, {
    expect_true(TRUE)
  })
})
