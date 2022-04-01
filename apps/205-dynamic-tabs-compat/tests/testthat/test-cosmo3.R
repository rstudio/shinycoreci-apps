library(shinytest2)

test_that("Migrated shinytest test: cosmo3.R", {
  # Do not edit this test script by hand. This script was generated automatically by 
  # ./app/shinytest-template.R & ./app/tests/shinytest.R
  library(shinytest)
  library(bslib)
  theme <- yaml::yaml.load_file('../../themes.yaml', eval.expr = TRUE)[['cosmo3']]
  if (!is_bs_theme(theme)) {
    theme <- do.call(bs_theme, theme)
  }

  # The bslib themer-demo app listens to this option through
  # bslib::bs_global_get()
  app <- AppDriver$new(variant = shinycoreci::platform_rversion(),
    options = list(bslib_theme = theme))

  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(`navbar-insert` = "click")
  app$set_inputs(`navbar-insert` = "click")
  app$set_inputs(`tabset-insert` = "click")
  app$set_inputs(`tabset-insert` = "click")
  app$set_inputs(`navlist-insert` = "click")
  app$set_inputs(`navlist-insert` = "click")
  app$set_inputs(`tabset-tabset` = "A")
  app$set_inputs(`navlist-navlist` = "B")
  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(`navlist-remove` = "click")
  app$set_inputs(`tabset-remove` = "click")
  app$set_inputs(`tabset-hide` = "click")
  app$set_inputs(`navbar-remove` = "click")
  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(`navbar-navbar` = "A")
  app$expect_values()
  app$expect_screenshot()
})
