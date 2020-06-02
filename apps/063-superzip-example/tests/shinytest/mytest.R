app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))

verbose <- FALSE
if (verbose) {
  print(1)
  print(app$getDebugLog())
  cat('\n\n')
}
app$snapshotInit("mytest")

app$waitForValue("map", iotype = "output")
Sys.sleep(4) # let map fill in

if (verbose) {
  print(2)
  print(app$getDebugLog())
  cat('\n\n')
}

app$snapshot()
app$setInputs(threshold = 3)
app$setInputs(color = "college")

Sys.sleep(4) # let map fill in

if (verbose) {
  print(3)
  print(app$getDebugLog())
  cat('\n\n')
}
app$snapshot()

app$setInputs(nav = "Data explorer")

ziptable_rows_all_init <- app$waitForValue("ziptable_rows_all")
if (verbose) {
  print(4)
  print(app$getDebugLog())
  cat('\n\n')
}
app$snapshot()

# Input 'ziptable_rows_current' was set, but doesn't have an input binding.
# Input 'ziptable_rows_all' was set, but doesn't have an input binding.
app$setInputs(states = "MA")
# Input 'ziptable_rows_current' was set, but doesn't have an input binding.
# Input 'ziptable_rows_all' was set, but doesn't have an input binding.
app$waitForValue("ziptable_rows_all", ignore = list(ziptable_rows_all_init, NULL))

if (verbose) {
  print(5)
  print(app$getDebugLog())
  cat('\n\n')
}
app$snapshot()
