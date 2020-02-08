app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

# Wait until the DT table is fully initialized
init_parcoord <- app$waitForValue("parcoord", ignore = list(NULL, ""), iotype = "output")
app$waitForValue("rawdata_rows_current", ignore = list(NULL, ""))
app$snapshot()

app$setInputs(state = "California")
# Wait until the DT table is has new values
app$waitForValue("parcoord", ignore = list(init_parcoord), iotype = "output")

app$snapshot()
