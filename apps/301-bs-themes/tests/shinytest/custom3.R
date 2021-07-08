# Do not edit this test script by hand. This script was generated automatically by 
# ./app/shinytest-template.R & ./app/tests/shinytest.R
library(shinytest)
library(bslib)
theme <- yaml::yaml.load_file('../../themes.yaml', eval.expr = TRUE)[['custom3']]
if (!is_bs_theme(theme)) {
  theme <- do.call(bs_theme, theme)
}

# This `shinytest::` below is a hack to avoid shiny::runTests() thinking this
# template is itself a testing app https://github.com/rstudio/shiny/blob/24a1ef/R/test.R#L36
app <- shinytest::ShinyDriver$new(
  '../../', seed = 101,
  # The bslib themer-demo app listens to this option through
  # bslib::bs_global_get()
  options = list(bslib_theme = theme)
)

app$snapshotInit('custom3')

app$snapshot()
app$setInputs(slider = c(30, 83))
app$setInputs(slider = c(14, 83))
app$setInputs(selectize = "AK")
app$setInputs(selectizeMulti = "AK")
app$setInputs(selectizeMulti = c("AK", "AR"))
app$setInputs(selectizeMulti = c("AK", "AR", "CO"))
app$setInputs(date = "2020-12-21")
app$setInputs(dateRange = c("2020-12-24", "2020-12-14"))
app$setInputs(dateRange = c("2020-12-24", "2020-12-26"))
app$setInputs(secondary = "click")
app$snapshot()
app$setInputs(inputs = "wellPanel()")
app$setInputs(select = "AZ")
app$setInputs(password = "secretdfdsf")
app$setInputs(textArea = "dsfsdf")
app$setInputs(text = "asfdsf")
app$setInputs(checkGroup = "A")
app$setInputs(check = FALSE)
app$setInputs(radioButtons = "B")
app$setInputs(numeric = 1)
app$setInputs(numeric = 2)
app$setInputs(numeric = 3)
app$setInputs(numeric = 4)
app$snapshot()
app$setInputs(navbar = "Plots")
app$snapshot()
app$setInputs(navbar = "Tables")
app$snapshot()
app$setInputs(navbar = "Fonts")
app$snapshot()
app$setInputs(navbar = "Notifications")
app$setInputs(otherNav = "Uploads & Downloads")
app$uploadFile(file = "upload-file.txt")
app$snapshot()
app$executeScript(
  "window.modalShown = false;
  $(document).on('shown.bs.modal', function(e) { window.modalShown = true; });"
)
app$setInputs(showModal = "click")
app$waitFor("window.modalShown")
app$snapshot()

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