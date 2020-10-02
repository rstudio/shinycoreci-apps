app <- ShinyDriver$new("../../index.Rmd", seed = 31782)
app$snapshotInit("mytest")

app$snapshot()

app$setInputs(clusterNum = "2")
app$snapshot()
