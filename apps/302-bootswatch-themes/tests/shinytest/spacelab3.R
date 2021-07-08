# Do not edit this test script by hand. This script was generated automatically by 
# ./app/shinytest-template.R & ./app/tests/shinytest.R
# --------------------------------------------------------------------------------
# Do not edit this test script by hand. This script was generated automatically by
# ./app/shinytest-template.R & ./app/tests/shinytest.R
# --------------------------------------------------------------------------------

library(shinytest)
library(bslib)
theme <- yaml::yaml.load_file('../../themes.yaml', eval.expr = TRUE)[['spacelab3']]
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

app$snapshotInit('spacelab3')
app$snapshot()