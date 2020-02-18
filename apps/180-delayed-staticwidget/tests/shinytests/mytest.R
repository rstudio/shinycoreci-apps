app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$waitForValue("status", iotype = "output")

Sys.sleep(2) # wait for map
app$snapshot()
