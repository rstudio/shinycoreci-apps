app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

app$waitForValue("status", iotype = "output")
app$snapshot()
