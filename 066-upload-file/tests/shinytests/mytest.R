app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$uploadFile(file1 = "mtcars.csv")
app$setInputs(header = FALSE)
app$setInputs(quote = "")
app$snapshot()
