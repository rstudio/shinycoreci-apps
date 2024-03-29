library(shinytest2)

test_that("Migrated shinytest test: mytest.R", {
  app <- AppDriver$new(variant = shinycoreci::platform_rversion())

  app$wait_for_value(output = "status")

  Sys.sleep(2) # wait for map
  app$expect_values()
  app$expect_screenshot()
})
