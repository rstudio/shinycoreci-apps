app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

Sys.sleep(3)
app$snapshot()
app$setInputs(ex5_visible = TRUE)
Sys.sleep(2)
app$snapshot()
