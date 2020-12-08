library(shinytest)
library(bslib)

themes <- yaml::yaml.load_file("../themes.yaml", eval.expr = TRUE)
lapply(names(themes), function(x) {
  testname <- gsub("\\s+", "-", x)
  testcode <- c(
    "library(shinytest)",
    "library(bslib)",
    sprintf("theme <- yaml::yaml.load_file('../../themes.yaml', eval.expr = TRUE)[['%s']]", x),
    "if (!is_bs_theme(theme)) theme <- do.call(bs_theme, theme)",
    "old_theme <- bs_global_set(theme)",
    "shiny::onStop(function() { bs_global_set(old_theme) })",
    # This namespacing is a hack to trick shiny::runTests() into (incorrectly) thinking this
    # file itself is a testing app https://github.com/rstudio/shiny/blob/24a1ef/R/test.R#L36
    "app <- shinytest::ShinyDriver$new('../../', seed = 101)",
    sprintf("app$snapshotInit('%s')", testname),
    readLines("../shinytest-template.R")
  )
  writeLines(testcode, file.path("shinytest", paste0(testname, ".R")))
})

shinytest::testApp("../")
