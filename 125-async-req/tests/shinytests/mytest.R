app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

Sys.sleep(2)
app$snapshot()
app$setInputs(boom = "click")
app$snapshot()
