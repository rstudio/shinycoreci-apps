app <- ShinyDriver$new("../../index.Rmd", seed = 75237)
app$snapshotInit("mytest")

app$waitForValue("plotly_afterplot-A")
app$snapshot()

app$setInputs(month = "Mar")
app$snapshot()

# View second page
app$executeScript('$("#navbar li a").last().click();')
app$waitForValue("p2r1content", iotype = "output")
app$snapshot()
