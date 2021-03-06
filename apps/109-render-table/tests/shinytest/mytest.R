app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()
app$setInputs(dataset = "mock")
app$snapshot()
app$setInputs(format = "bordered")
app$setInputs(format = c("striped", "bordered"))
app$setInputs(spacing = "xs")
app$setInputs(align = "ccr")
app$snapshot()
app$setInputs(align = "NULL")
app$setInputs(rownames = "T")
app$setInputs(digits = "3")
app$setInputs(na = "-99")
app$snapshot()
