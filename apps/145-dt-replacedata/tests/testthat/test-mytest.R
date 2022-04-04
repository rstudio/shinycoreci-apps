library(shinytest2)

test_that("Migrated shinytest test: mytest.R", {
  app <- AppDriver$new(variant = shinycoreci::platform_rversion())

  app$wait_for_value(input = "table_cell_clicked")
  app$wait_for_value(input = "table_rows_all")
  app$wait_for_value(input = "table_rows_current")
  app$wait_for_value(input = "one-table_cell_clicked")
  app$wait_for_value(input = "one-table_rows_all")
  app$wait_for_value(input = "one-table_rows_current")
  app$expect_values()
  app$expect_screenshot()

  app$set_inputs(inc = "click")
  app$set_inputs(inc = "click")
  app$set_inputs(inc = "click")
  app$set_inputs(`one-inc` = "click")
  app$expect_values()
  app$expect_screenshot()
})
