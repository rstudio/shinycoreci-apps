library(shinytest2)

test_that("Migrated shinytest test: mytest.R", {
  app <- AppDriver$new(variant = shinycoreci::platform_rversion())

  Sys.sleep(2)
  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(boom = "click")
  app$expect_values()
  app$expect_screenshot()
})
