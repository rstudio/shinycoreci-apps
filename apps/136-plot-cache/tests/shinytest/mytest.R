app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(n = 24)
app$snapshot()
app$setInputs(n = 8)
app$snapshot()
