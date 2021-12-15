app <- ShinyDriver$new("../../flexlib.Rmd", seed = 101)
app$snapshotInit("mytest")

app$snapshot()

## Components tab

# Slider Input
app$setInputs(slider = 50)
app$snapshot()

app$executeScript(
  "tabShown = false;
  $(document).on('shown.bs.tab', function(e) { tabShown = true; });"
)

# Interactive table
app$executeScript('$(".nav [href=\'#section-interactive-table\']").tab("show")')
app$waitFor("tabShown")
app$snapshot()


## Navbar - Click other tabs
app$executeScript(
  "tabShown = false;
  $(document).on('shown.bs.tab', function(e) { tabShown = true; });"
)

# Story board
app$executeScript('$(".nav [href=\'#section-storyboard\']").tab("show")')
app$waitFor("tabShown")
app$snapshot()

app$executeScript('$(".nav [href=\'#section-cards\']").tab("show")')
app$waitFor("tabShown")
app$snapshot()
