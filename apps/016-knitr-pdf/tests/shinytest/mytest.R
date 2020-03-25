app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(format = "HTML", values_ = FALSE, wait_ = FALSE)
app$setInputs(x = "disp")
app$snapshot()
app$snapshotDownload("downloadReport")

# Note: PDF and Word output are different each time, so we only test HTML
# output.
