app <- ShinyDriver$new("../../", seed = 54322)
app$snapshotInit("mytest")

app$setInputs(`reactlog_module-refresh` = "click")
Sys.sleep(4)
app$snapshot()

app$setInputs(a = 5, b = 12)

app$setInputs(`reactlog_module-refresh` = "click")
Sys.sleep(4)
app$snapshot()
