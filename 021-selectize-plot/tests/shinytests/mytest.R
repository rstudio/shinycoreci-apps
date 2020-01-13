app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

Sys.sleep(2.5)
app$snapshot()
app$setInputs(state = "California")
Sys.sleep(.5)
app$snapshot()
