app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

Sys.sleep(1)
app$snapshot()
