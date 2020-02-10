app <- ShinyDriver$new("../../index.Rmd", seed = 91546)
app$snapshotInit("mytest")

app$snapshot()
