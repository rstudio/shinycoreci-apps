app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

plotInit <- app$waitForValue("plot1", ignore = list(NULL, ""), iotype = "output")
app$snapshot()

# Set inputs
app$setInputs(text = "hello world", wait_=FALSE, values_=FALSE)
app$setInputs(n = 20, wait_=FALSE, values_=FALSE)
# Make sure the app does NOT change yet.
app$snapshot()

# Hit submit button
app$executeScript("$('button[type=\"submit\"]').trigger('click')")
app$waitForValue("plot1", ignore = list(NULL, plotInit), iotype = "output")
app$snapshot()
