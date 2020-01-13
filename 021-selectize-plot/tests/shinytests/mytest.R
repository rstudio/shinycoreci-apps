app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

Sys.sleep(1)
app$snapshot()
app$setInputs(state = "Alabama")
app$snapshot()
app$setInputs(state = "California")
app$snapshot()
