app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(go = "click")
app$snapshot()
