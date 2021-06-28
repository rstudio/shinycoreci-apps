app <- ShinyDriver$new("../../index.Rmd", seed = 75237)
app$snapshotInit("mytest")

plotly_feb <- app$waitForValue("plotly_afterplot-A")
# wait some more time just to let the images adjust
Sys.sleep(5)
app$snapshot()

app$setInputs(month = "Mar")
# wait some more time just to let the images adjust
Sys.sleep(5)
app$snapshot()

# View second page
app$executeScript('$("#navbar li a").last().click();')
app$waitForValue("p2r1content", iotype = "output")
app$snapshot()
