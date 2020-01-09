app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

app$uploadFile(file1 = "mtcars.csv")
app$setInputs(header = FALSE)
app$setInputs(quote = "")
app$snapshot()
