app <- ShinyDriver$new("../../", seed = 54322)
app$snapshotInit("mytest")

app$setInputs(`reactlog_module-refresh` = "click")
Sys.sleep(4)
app$snapshot()

app$setInputs(`reactlog_module-refresh` = "click")
Sys.sleep(4)
app$snapshot()

app$setInputs(obs = 9)
app$setInputs(obs = 8)

app$setInputs(`reactlog_module-refresh` = "click")
Sys.sleep(4)
app$snapshot()

app$setInputs(`reactlog_module-refresh` = "click")
Sys.sleep(4)
app$snapshot()
