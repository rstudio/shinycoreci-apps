app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$waitForValue("ex1_rows_all")
app$snapshot()
app$setInputs(tabs = 'Length menu')

app$waitForValue("ex2_rows_all")
app$snapshot()
app$setInputs(tabs = 'No pagination')

app$waitForValue("ex3_rows_all")
app$snapshot()
app$setInputs(tabs = 'No filtering')

app$waitForValue("ex4_rows_all")
app$snapshot()
app$setInputs(tabs = 'Function callback')

app$waitForValue("ex5_rows_all")
app$snapshot()
