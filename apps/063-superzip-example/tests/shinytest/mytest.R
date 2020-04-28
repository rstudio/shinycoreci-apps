app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))

print(1)
print(app$getDebugLog())
cat('\n\n')
app$snapshotInit("mytest")

Sys.sleep(4)

print(2)
print(app$getDebugLog())
cat('\n\n')
app$snapshot()
app$setInputs(threshold = 3)
app$setInputs(color = "college")

Sys.sleep(2)
print(3)
print(app$getDebugLog())
cat('\n\n')
app$snapshot()

app$setInputs(nav = "Data explorer")

Sys.sleep(2)
print(4)
print(app$getDebugLog())
cat('\n\n')
app$snapshot()

# Input 'ziptable_rows_current' was set, but doesn't have an input binding.
# Input 'ziptable_rows_all' was set, but doesn't have an input binding.
app$setInputs(states = "MA")
# Input 'ziptable_rows_current' was set, but doesn't have an input binding.
# Input 'ziptable_rows_all' was set, but doesn't have an input binding.

Sys.sleep(1)
print(5)
print(app$getDebugLog())
cat('\n\n')
app$snapshot()
