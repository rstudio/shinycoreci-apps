app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$setInputs(slider = 75)
app$snapshotDownload("report")
app$snapshot()
