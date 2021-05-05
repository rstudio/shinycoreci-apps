app <- ShinyDriver$new("../../index.Rmd", seed = 75237)
app$snapshotInit("mytest")

app$waitForValue("plotly_afterplot-A")
app$snapshot()

app$setInputs(month = "Mar")
app$snapshot()

# view second page
app$executeScript('$("#navbar li a").last().click();')
app$snapshot()
