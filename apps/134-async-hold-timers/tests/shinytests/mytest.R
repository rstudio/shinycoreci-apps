app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

app$snapshot()
Sys.sleep(10)
app$snapshot()
