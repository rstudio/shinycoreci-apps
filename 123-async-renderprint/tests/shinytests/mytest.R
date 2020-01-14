app <- ShinyDriver$new("../../", loadTimeout = 10000, seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

Sys.sleep(2)
app$snapshot()
