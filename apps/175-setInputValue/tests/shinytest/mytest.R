app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

app$waitForValue("result", iotype = "output")
app$snapshot()
