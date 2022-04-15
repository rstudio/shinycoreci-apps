library(shinytest2)

test_that("Migrated shinytest test: mytest.R", {
  app <- AppDriver$new(variant = shinycoreci::platform_rversion(),
    seed = 100, shiny_args = list(display.mode = "normal"))

  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(dataset = "pressure")
  app$set_inputs(obs = 1000)
  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(dataset = "rock")
  app$set_inputs(obs = 1)
  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(obs = 1000)
  app$set_inputs(dataset = "pressure")
  app$expect_values()
  app$expect_screenshot()
})
