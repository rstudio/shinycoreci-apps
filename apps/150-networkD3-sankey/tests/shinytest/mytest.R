app <- ShinyDriver$new("../../", seed = 100)
app$snapshotInit("mytest")

# Progress won't work right with shinytest because of timing.
#app$setInputs(progress = "click")
#app$snapshot()
app$setInputs(dates = c("2000-01-19", "2018-02-01"))
app$setInputs(dates = c("2000-01-19", "2018-01-31"))
# app$setInputs(progress = "click")
app$snapshot()
app$setInputs(`._bookmark_` = "click")
Sys.sleep(1)
app$snapshot()
