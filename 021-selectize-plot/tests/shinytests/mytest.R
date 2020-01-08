app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(state = "Alabama")
app$snapshot()
app$setInputs(state = "California")
app$snapshot()
