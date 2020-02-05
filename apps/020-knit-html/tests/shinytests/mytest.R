app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

Sys.sleep(3)
app$snapshot()
app$setInputs(x = "hp")
Sys.sleep(2)
app$snapshot()
