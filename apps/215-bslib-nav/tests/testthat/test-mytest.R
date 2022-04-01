library(shinytest2)

test_that("Migrated shinytest test: mytest.R", {
  app <- AppDriver$new(variant = shinycoreci::platform_rversion())

  app$run_js(script = "$(\".nav [data-value=b]\").tab(\"show\")")
  app$wait_for_js("{let b = $(\".tab-pane[data-value=b]\"); let bv = b.find(\":visible\"); b.length == bv.length > 0}")
  app$expect_values()
  app$expect_screenshot()

  app$run_js(script = "$(\".nav [data-value=c]\").tab(\"show\")")
  app$wait_for_js("var c = $(\".tab-pane[data-value=c]\"); var cv = c.find(\":visible\"); c.length == cv.length > 0")
  app$expect_values()
  app$expect_screenshot()
})
