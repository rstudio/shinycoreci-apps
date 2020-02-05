app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

# Spin until input$state gives us a useful value, or timeout.
for (i in 1:100) {
  state <- try(app$getValue("state", "input"))
  if (inherits(state, "try-error") || identical(state, "")) {
    Sys.sleep(0.2)
  } else {
    break
  }
}
app$snapshot()
app$setInputs(state = "California")
Sys.sleep(1)
app$snapshot()
