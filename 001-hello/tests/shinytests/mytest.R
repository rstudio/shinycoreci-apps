app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(bins = 8)
app$snapshot()
app$setInputs(bins = 5)
app$setInputs(bins = 22)
app$snapshot()
