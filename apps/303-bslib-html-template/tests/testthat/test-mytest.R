library(shinytest2)

test_that("Migrated shinytest test: mytest.R", {
  library(shinytest)
  app <- AppDriver$new(variant = shinycoreci::platform_rversion())

  # date picker snapshots
  # TODO: do we need to wait until the calendar renders?
  app$get_js(script = "$('#date input').bsDatepicker('show')",
    timeout = 10000)
  app$expect_values()
  app$expect_screenshot()
  app$get_js(script = "$('#date input').bsDatepicker('hide')",
    timeout = 10000)

  app$get_js(script = "$('#date_range input:first').bsDatepicker('show')",
    timeout = 10000)
  app$expect_values()
  app$expect_screenshot()
  app$get_js(script = "$('#date_range input:first').bsDatepicker('hide')",
    timeout = 10000)

  try_find_element <- function(css) {
    app$wait_for_js(paste0("$(\"", css, "\").length() > 0"),
        timeout = 3000)
  }

  find_selectize_content <- function(css = ".selectize-dropdown-content *") {
    dropdown_content <- try_find_element(css)
    while(is.null(dropdown_content)) {
      dropdown_content <- try_find_element(css)
    }
    dropdown_content
  }

  # Take snapshot of dropdown once it has content
  app$get_js(script = "$('#select')[0].selectize.open()", timeout = 10000)
  content <- find_selectize_content()
  Sys.sleep(1)
  app$expect_values()
  app$expect_screenshot()

  # Do the same for the selectInput(multiple=T)
  app$get_js(script = "$('#select')[0].selectize.close()", timeout = 10000)
  app$get_js(script = "$('#select_multiple')[0].selectize.open()",
    timeout = 10000)
  content <- find_selectize_content()
  Sys.sleep(1)
  app$expect_values()
  app$expect_screenshot()

  # Make sure the item styling is sensible
  app$get_js(script = "$('#select_multiple')[0].selectize.setValue(['MN', 'CA'])",
    timeout = 10000)
  app$expect_values()
  app$expect_screenshot()
  app$get_js(script = "$('#select_multiple')[0].selectize.close()",
    timeout = 10000)
})
