library(shinytest2)

test_that("Migrated shinytest test: mytest.R", {
  app <- AppDriver$new("../../index.Rmd", variant = shinycoreci::platform_rversion(),
    seed = 91546)

  Sys.sleep(8)
  app$expect_values()
  app$expect_screenshot()
})
