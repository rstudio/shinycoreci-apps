skip_if_not_installed("htmltools", "0.5.0")

library(shinytest2)

test_that("Migrated shinytest test: mytest.R", {
  app <- AppDriver$new(variant = shinycoreci::platform_rversion())

  app$expect_values()
  app$expect_screenshot()
})
