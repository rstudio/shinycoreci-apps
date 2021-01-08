# Do not edit this test script by hand. This script was generated automatically by 
# ./app/shinytest-template.R & ./app/tests/shinytest.R
library(shinytest)
library(bslib)
theme <- yaml::yaml.load_file('../../themes.yaml', eval.expr = TRUE)[['cosmo4']]
if (!is_bs_theme(theme)) {
  theme <- do.call(bs_theme, theme)
}

# The bslib themer-demo app listens to this option through
# bslib::bs_global_get()
app <- ShinyDriver$new("../../", options = list(bslib_theme = theme))
app$snapshotInit("cosmo4")

app$snapshot()
app$setInputs(`navbar-insert` = "click")
app$setInputs(`navbar-insert` = "click")
app$setInputs(`tabset-insert` = "click")
app$setInputs(`tabset-insert` = "click")
app$setInputs(`navlist-insert` = "click")
app$setInputs(`navlist-insert` = "click")
app$setInputs(`tabset-tabset` = "A")
app$setInputs(`navlist-navlist` = "B")
app$snapshot()
app$setInputs(`navlist-remove` = "click")
app$setInputs(`tabset-remove` = "click")
app$setInputs(`tabset-hide` = "click")
app$setInputs(`navbar-remove` = "click")
app$snapshot()
app$setInputs(`navbar-navbar` = "A")
app$snapshot()