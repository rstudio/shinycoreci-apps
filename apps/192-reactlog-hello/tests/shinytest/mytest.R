app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$setInputs(`reactlog_module-refresh` = "click")
Sys.sleep(4)
app$snapshot()

app$setInputs(bins = 8)
app$setInputs(`reactlog_module-refresh` = "click")
Sys.sleep(4)
app$snapshot()

app$setInputs(bins = 5)
app$setInputs(bins = 22)
app$setInputs(`reactlog_module-refresh` = "click")
Sys.sleep(4)
app$snapshot()
