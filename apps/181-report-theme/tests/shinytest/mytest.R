app <- ShinyDriver$new("../../index.Rmd", seed = 71069)
app$snapshotInit("mytest")

app$snapshot()
