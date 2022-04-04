skip_if_not_installed("htmlwidgets", "1.4")

library(shinytest2)

test_that("Migrated shinytest test: mytest.R", {
  app <- AppDriver$new(variant = shinycoreci::platform_rversion())

  app$wait_for_value(output = "p3")
  Sys.sleep(2)
  app$expect_values()
  app$expect_screenshot()
})
