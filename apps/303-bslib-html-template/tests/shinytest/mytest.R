library(shinytest)
app <- ShinyDriver$new("../../", debug = "all")
app$snapshotInit("mytest")

# date picker snapshots
# TODO: do we need to wait until the calendar renders?
app$executeScript("$('#date input').bsDatepicker('show')")
app$snapshot()
app$executeScript("$('#date input').bsDatepicker('hide')")

app$executeScript("$('#date_range input:first').bsDatepicker('show')")
app$snapshot()
app$executeScript("$('#date_range input:first').bsDatepicker('hide')")

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

# Take snapshot of dropdown once it has content
app$executeScript("$('#select')[0].selectize.open()")
content <- find_selectize_content()
Sys.sleep(1)
app$snapshot()

# Do the same for the selectInput(multiple=T)
app$executeScript("$('#select')[0].selectize.close()")
app$executeScript("$('#select_multiple')[0].selectize.open()")
content <- find_selectize_content()
Sys.sleep(1)
app$snapshot()

# Make sure the item styling is sensible
app$executeScript("$('#select_multiple')[0].selectize.setValue(['MN', 'CA'])")
app$snapshot()
app$executeScript("$('#select_multiple')[0].selectize.close()")
