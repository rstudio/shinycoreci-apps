app <- ShinyDriver$new("../../", loadTimeout = 15000)
app$snapshotInit("mytest")

app$waitForValue("without_connection_upgrade", iotype = "output")
app$snapshot()
