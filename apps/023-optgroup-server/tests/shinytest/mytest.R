app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

row_init_value <- app$waitForValue("row", iotype = "output")

app$snapshot()
app$setInputs(group = "17")
row1 <- app$waitForValue("row", ignore = list(row_init_value), iotype = "output")
app$snapshot()

app$setInputs(group = c("17", "30"))
app$setInputs(group = c("17", "30", "22"))
app$setInputs(group = c("17", "30", "22", "14"))
app$setInputs(group = c("17", "30", "22", "14", "20"))
app$setInputs(group = c("17", "30", "22", "14", "20", "8"))
app$setInputs(group = c("17", "30", "22", "14", "20", "8", "12"))
Sys.sleep(1)
app$snapshot()
