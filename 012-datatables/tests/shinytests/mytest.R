app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

Sys.sleep(0.5)
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(show_vars = c("carat", "cut", "color", "clarity", "depth", "price", "x", "y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(show_vars = c("carat", "cut", "color", "clarity", "price", "x", "y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$snapshot()
app$setInputs(show_vars = c("color", "clarity", "price", "y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(show_vars = c("clarity", "price", "y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(show_vars = c("price", "y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(show_vars = c("y", "z"))
# Input 'mytable1_rows_current' was set, but doesn't have an input binding.
# Input 'mytable1_rows_all' was set, but doesn't have an input binding.
app$setInputs(show_vars = "z")
app$snapshot()
app$setInputs(dataset = "mtcars")
app$snapshot()
