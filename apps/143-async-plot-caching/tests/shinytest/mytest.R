app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")


app$waitForValue("plotNN", iotype = "output")
app$waitForValue("plotYN", iotype = "output")
app$waitForValue("plotNY", iotype = "output")
app$waitForValue("plotYY", iotype = "output")

app$waitForValue("ggplotNN", iotype = "output")
app$waitForValue("ggplotYN", iotype = "output")
app$waitForValue("ggplotNY", iotype = "output")
app$waitForValue("ggplotYY", iotype = "output")

app$snapshot()
