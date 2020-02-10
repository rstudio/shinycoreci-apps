app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

app$setInputs(go = "click", wait_ = FALSE, values_ = FALSE)
app$setInputs(choice = "b", wait_ = FALSE, values_ = FALSE)
app$setInputs(choice = "c", wait_ = FALSE, values_ = FALSE)
app$snapshot()
Sys.sleep(4)
app$snapshot()
