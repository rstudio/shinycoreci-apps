app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

Sys.sleep(2)
app$snapshot()
app$setInputs(threshold = 3)
app$setInputs(color = "college")
app$snapshot()

app$setInputs(nav = "Data explorer")
app$snapshot()
# Input 'ziptable_rows_current' was set, but doesn't have an input binding.
# Input 'ziptable_rows_all' was set, but doesn't have an input binding.
app$setInputs(states = "MA")
# Input 'ziptable_rows_current' was set, but doesn't have an input binding.
# Input 'ziptable_rows_all' was set, but doesn't have an input binding.
app$snapshot()
