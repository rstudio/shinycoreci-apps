app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$setInputs(show = "click")
Sys.sleep(1)
app$snapshot()

# Click selectize input - https://github.com/rstudio/shiny/pull/3450
app$executeScript("$('.selectize-input').click()");
app$snapshot()

# Select an option
app$setInputs(selectizeInput = "California")
app$snapshot()

# Click the Dismiss button
app$executeScript("$('button[data-dismiss=\"modal\"]').click()")
Sys.sleep(1)
app$snapshot()
