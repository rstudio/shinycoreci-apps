library(shinytest2)

test_that("Migrated shinytest test: mytest.R", {
  app <- AppDriver$new(variant = shinycoreci::platform_rversion(),
    seed = 100, shiny_args = list(display.mode = "normal"))

  Sys.sleep(3)
  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(x = "hp")
  Sys.sleep(2)
  app$expect_values()
  app$expect_screenshot()
})
