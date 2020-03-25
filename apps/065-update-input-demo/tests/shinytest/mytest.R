app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$waitForValue("inCheckboxGroup")
app$snapshot()
app$setInputs(control_num = 8)
app$snapshot()
