app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(`counter1-button` = "click")
app$setInputs(`counter1-button` = "click")
app$snapshot()
