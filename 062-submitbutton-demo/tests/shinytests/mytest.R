app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(text = "hello world", wait_=FALSE, values_=FALSE)
app$setInputs(n = 20, wait_=FALSE, values_=FALSE)

# Make sure the app does NOT change yet.
app$snapshot()

app$executeScript("$('button[type=\"submit\"]').trigger('click')")
app$snapshot()
