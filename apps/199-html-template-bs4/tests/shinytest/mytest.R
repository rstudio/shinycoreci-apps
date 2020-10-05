library(shinytest)
app <- ShinyDriver$new("../../", debug = "all")
app$snapshotInit("mytest")

# Take initial screenshot, then open selectize dropdown
app$snapshot()
app$executeScript("$('#select')[0].selectize.open()")

try_find_element <- function(css) {
  tryCatch(app$findElement(css), error = function(e) NULL)
}

find_selectize_content <- function(css = ".selectize-dropdown-content *") {
  dropdown_content <- try_find_element(css)
  while(is.null(dropdown_content)) {
    dropdown_content <- try_find_element(css)
  }
  dropdown_content
}

# Take another snapshot of dropdown once it has content
content <- find_selectize_content()
app$snapshot()

# Do the same for the selectInput(multiple=T)
app$executeScript("$('#select')[0].selectize.close()")
app$executeScript("$('#select_multiple')[0].selectize.open()")
content <- find_selectize_content()
app$snapshot()

# Make sure the item styling is sensible
app$executeScript("$('#select_multiple')[0].selectize.setValue(['MN', 'CA'])")
app$snapshot()

