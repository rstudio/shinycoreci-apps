app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

# These are set by an update function - instead of setting them in our tests,
# we'll wait for the app to automatically set them before moving on.
# app$setInputs(`server-8-select` = "a1")
# app$setInputs(`server-9-select` = "a1")
# app$setInputs(`server-10-select` = "a1")
# app$setInputs(`server-11-select` = "a1")

app$waitForValue("server-8-select")
app$waitForValue("server-9-select")
app$waitForValue("server-10-select")
app$waitForValue("server-11-select")
app$snapshot()
