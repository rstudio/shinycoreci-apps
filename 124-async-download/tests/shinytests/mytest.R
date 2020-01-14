app <- ShinyDriver$new("../../", loadTimeout = 15000, seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshotDownload("download")
app$setInputs(throw = TRUE)
app$snapshotDownload("download")
Sys.sleep(4)
app$snapshot()
