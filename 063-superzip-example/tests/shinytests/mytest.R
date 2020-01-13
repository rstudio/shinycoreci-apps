app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

Sys.sleep(2)
app$snapshot()
app$setInputs(threshold = 3)
app$setInputs(color = "college")
Sys.sleep(1)
app$snapshot()

app$setInputs(nav = "Data explorer")
Sys.sleep(1)
app$snapshot()
# Input 'ziptable_rows_current' was set, but doesn't have an input binding.
# Input 'ziptable_rows_all' was set, but doesn't have an input binding.
app$setInputs(states = "MA")
# Input 'ziptable_rows_current' was set, but doesn't have an input binding.
# Input 'ziptable_rows_all' was set, but doesn't have an input binding.
Sys.sleep(1)
app$snapshot()
