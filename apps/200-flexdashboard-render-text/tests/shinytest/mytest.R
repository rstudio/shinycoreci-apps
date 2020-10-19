app <- ShinyDriver$new("../../index.Rmd", seed = 75237)
app$snapshotInit("mytest")

app$waitForValue("month")
app$snapshot()

app$setInputs(month = "Mar")
app$snapshot()
