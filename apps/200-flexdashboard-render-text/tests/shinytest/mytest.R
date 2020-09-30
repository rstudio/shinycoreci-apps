app <- ShinyDriver$new("../../index.Rmd", seed = 75237)
app$snapshotInit("mytest")

app$snapshot()
app$snapshot()
app$snapshot()
app$snapshot()
app$setInputs(month = "Mar")
app$snapshot()
