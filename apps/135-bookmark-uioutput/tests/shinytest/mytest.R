app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

Sys.sleep(1)
app$snapshot()

app$setInputs(`._bookmark_` = "click")
Sys.sleep(1)
app$snapshot()

app$setInputs(x = 10)
app$setInputs(`._bookmark_` = "click")
Sys.sleep(1)
app$snapshot()

app$setInputs(reset = "click")
app$snapshot()
