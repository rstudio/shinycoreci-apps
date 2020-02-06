app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

# Spin until input$state gives us a useful value, or timeout.
for (i in 1:100) {
  rawdata_rows_current <- try(app$getAllValues(input = TRUE, output = FALSE)$input$rawdata_rows_current, silent = FALSE)
  if (inherits(rawdata_rows_current, "try-error")) {
    Sys.sleep(0.4)
  } else if (any(vapply(list(NULL, "", c()), identical, logical(1), x = rawdata_rows_current))) {
    Sys.sleep(0.4)
  } else {
    break
  }
}
app$snapshot()
app$setInputs(state = "California")
Sys.sleep(1)
app$snapshot()
