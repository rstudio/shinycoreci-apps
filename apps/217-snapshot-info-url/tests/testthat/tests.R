test_that("text passes", {
  app <- shinytest::ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))

  app$waitForValue("status", iotype = "output", ignore = list(NULL, ""))

  testthat::expect_equal(
    app$findElement("#status")$getText(),
    "PASS"
  )
})
