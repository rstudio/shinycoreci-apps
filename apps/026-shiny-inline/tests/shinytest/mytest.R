app <- ShinyDriver$new("../../index.Rmd", seed = 8296, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")
Sys.sleep(4)
app$snapshot()
app$setInputs(asp = 0.3)
app$snapshot()
app$setInputs(asp = 0.02)
app$setInputs(asp = 0.3)
app$setInputs(asp = 0.02)
app$setInputs(size = 3.25)
app$snapshot()
