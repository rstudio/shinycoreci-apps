library(shinytest2)

test_that("Migrated shinytest test: custom4.R", {
  # Do not edit this test script by hand. This script was generated automatically by 
  # ./app/shinytest-template.R & ./app/tests/shinytest.R
  library(shinytest)
  library(bslib)
  theme <- yaml::yaml.load_file('../../themes.yaml', eval.expr = TRUE)[['custom4']]
  if (!is_bs_theme(theme)) {
    theme <- do.call(bs_theme, theme)
  }

  # This `shinytest::` below is a hack to avoid shiny::runTests() thinking this
  # template is itself a testing app https://github.com/rstudio/shiny/blob/24a1ef/R/test.R#L36
  app <- AppDriver$new(variant = shinycoreci::platform_rversion(),
    seed = 101, options = list(bslib_theme = theme))


  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(slider = c(30, 83))
  app$set_inputs(slider = c(14, 83))
  app$set_inputs(selectize = "AK")
  app$set_inputs(selectizeMulti = "AK")
  app$set_inputs(selectizeMulti = c("AK", "AR"))
  app$set_inputs(selectizeMulti = c("AK", "AR", "CO"))
  app$set_inputs(date = "2020-12-21")
  app$set_inputs(dateRange = c("2020-12-24", "2020-12-14"))
  app$set_inputs(dateRange = c("2020-12-24", "2020-12-26"))
  app$set_inputs(secondary = "click")
  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(inputs = "wellPanel()")
  app$set_inputs(select = "AZ")
  app$set_inputs(password = "secretdfdsf")
  app$set_inputs(textArea = "dsfsdf")
  app$set_inputs(text = "asfdsf")
  app$set_inputs(checkGroup = "A")
  app$set_inputs(check = FALSE)
  app$set_inputs(radioButtons = "B")
  app$set_inputs(numeric = 1)
  app$set_inputs(numeric = 2)
  app$set_inputs(numeric = 3)
  app$set_inputs(numeric = 4)
  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(navbar = "Plots")
  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(navbar = "Tables")
  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(navbar = "Fonts")
  app$expect_values()
  app$expect_screenshot()
  app$set_inputs(navbar = "Notifications")
  app$set_inputs(otherNav = "Uploads & Downloads")
  app$upload_file(file = "upload-file.txt")
  app$expect_values()
  app$expect_screenshot()
  app$get_js(script = "window.modalShown = false;\n  $(document).on('shown.bs.modal', function(e) { window.modalShown = true; });",
    timeout = 10000)
  app$set_inputs(showModal = "click")
  app$wait_for_js("window.modalShown", timeout = 3000)
  app$expect_values()
  app$expect_screenshot()

  # It'd be nice to have snapshots of notifications and progress bars,
  # but I'm not sure if the timing issues they present are worth the maintainence cost
  #
  #app$setInputs(showDefault = "click")
  #app$setInputs(showMessage = "click")
  #app$setInputs(showWarning = "click")
  #app$setInputs(showError = "click")
  #app$setInputs(navbar = "Options")
  #app$setInputs(showProgress2 = "click", wait_ = FALSE, values_ = FALSE)
  #app$snapshot()
})
