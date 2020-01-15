library(testthat)
library(shiny)
library(withr)

inc <- function(x) if (is.null(x)) 0 else x+1

# TODO Determine the ideal way for module-reliant test code to load an app
with_dir(shiny:::findApp(), {
  local({
    source("R/counter.R")
    test_that("counter works", {
      testModule(counter, {
        expect_equal(count(), 0)
        # Simulate button press. Action buttons are counters, but their initial
        # value is NULL so that they don't cause reactivity without being
        # pressed at least once.
        # TODO Consider adding session$click() or similar to mock session
        session$setInputs(button = inc(input$button))
        expect_equal(count(), 1)
        expect_equal(output$out, "1")
        expect_equal(session$returned(), 1)
      })
    })
  })
})
