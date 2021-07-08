app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$snapshot()

# Add Dynamic-1 and show it
app$setInputs(add = "click")
app$setInputs(tabs = "Dynamic-1")
app$executeScript("$('.dropdown-toggle').click()"); # show
app$snapshot()
app$executeScript("$('.dropdown-toggle').click()"); # hide

# Remove Foo tabs
app$setInputs(removeFoo = "click")
app$snapshot()

# Add Foo-1 (also opens tab)
app$setInputs(addFoo = "click")
app$snapshot()

# View Default Hello tab
app$setInputs(tabs = "Hello")
app$snapshot()

# Add Dynamic-2 tab and show it in menu. Do not show Dynamic-2 tab.
app$setInputs(add = "click")
app$executeScript("$('.dropdown-toggle').click()"); # show
app$snapshot()
app$executeScript("$('.dropdown-toggle').click()"); # hide

# Add Foo-2 tab (also opens tab)
app$setInputs(addFoo = "click")
app$snapshot()

# Remove second Foo tab
app$setInputs(removeFoo = "click")
app$snapshot()
