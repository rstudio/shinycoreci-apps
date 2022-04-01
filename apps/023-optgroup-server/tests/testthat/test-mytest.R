library(shinytest2)

test_that("Migrated shinytest test: mytest.R", {
  app <- AppDriver$new(variant = shinycoreci::platform_rversion(),
    seed = 100, shiny_args = list(display.mode = "normal"))

  row_init_value <- app$wait_for_value(output = "row")

  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(group = "17")
  row1 <- app$wait_for_value(output = "row", ignore = list(row_init_value))
  app$expect_values()
  app$expect_screenshot()

  app$set_inputs(group = c("17", "30"))
  app$set_inputs(group = c("17", "30", "22"))
  app$set_inputs(group = c("17", "30", "22", "14"))
  app$set_inputs(group = c("17", "30", "22", "14", "20"))
  app$set_inputs(group = c("17", "30", "22", "14", "20", "8"))
  app$set_inputs(group = c("17", "30", "22", "14", "20", "8", "12"))
  Sys.sleep(1)
  app$expect_values()
  app$expect_screenshot()
})
