app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

# Verify a diagram appears. Ref: https://github.com/rstudio/shiny/pull/3472.
# For more details, check README of this app
app$snapshot()

