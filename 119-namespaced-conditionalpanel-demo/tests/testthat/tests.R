library(testthat)
library(shiny)
library(withr)

# TODO Determine the ideal way for module-reliant test code to load an app
with_dir(shiny:::findApp(), {
  local({
    source("app.R")
    test_that("module works", {
      testModule(myPlot, {
        expect_true(TRUE)
      })
    })
  })
})
