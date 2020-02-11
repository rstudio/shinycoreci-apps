app <- ShinyDriver$new("../../index.Rmd", seed = 91546)
app$snapshotInit("mytest")

Sys.sleep(8)
app$snapshot()
