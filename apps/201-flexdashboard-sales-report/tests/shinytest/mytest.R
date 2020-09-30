app <- ShinyDriver$new("../../index.Rmd", seed = 59457)
app$snapshotInit("mytest")

app$snapshot()
app$snapshot()
