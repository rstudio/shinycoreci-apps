app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

app$waitForValue("p3", iotype = "output")
Sys.sleep(2)
app$snapshot()
