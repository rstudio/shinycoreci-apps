app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

app$waitForValue("status", iotype = "output")

Sys.sleep(2) # wait for map
app$snapshot()
