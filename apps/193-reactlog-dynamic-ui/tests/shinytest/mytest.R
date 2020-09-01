app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")


take_snapshot <- function(refresh = TRUE) {
  app$setInputs(`reactlog_module-refresh` = "click")
  Sys.sleep(4)
  app$snapshot()
}
take_snapshot(FALSE)


app$setInputs(dynamic = 14)
take_snapshot()
app$setInputs(input_type = "text")
app$setInputs(dynamic = "abcd")

app$setInputs(input_type = "numeric")
app$setInputs(dynamic = 100)

app$setInputs(input_type = "checkbox")
app$setInputs(dynamic = FALSE)

app$setInputs(input_type = "checkboxGroup")
app$setInputs(dynamic = c("option1", "option2"))

app$setInputs(dynamic = "option1")
app$setInputs(dynamic = character(0))

app$setInputs(input_type = "radioButtons")
app$setInputs(dynamic = "option1")

app$setInputs(input_type = "selectInput")
app$setInputs(dynamic = "option1")

app$setInputs(input_type = "selectInput (multi)")

app$setInputs(dynamic = "option1")
app$setInputs(dynamic = character(0))

app$setInputs(input_type = "date")
app$setInputs(dynamic = "2020-01-31")

app$setInputs(input_type = "daterange")
app$setInputs(dynamic = c("2020-01-08", "2020-01-31"))

take_snapshot()
