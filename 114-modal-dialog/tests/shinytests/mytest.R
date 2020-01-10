app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$setInputs(show = "click")
Sys.sleep(1)
app$snapshot()

# Click the Dismiss button
app$executeScript("$('button[data-dismiss=\"modal\"]').click()")
Sys.sleep(1)
app$snapshot()
