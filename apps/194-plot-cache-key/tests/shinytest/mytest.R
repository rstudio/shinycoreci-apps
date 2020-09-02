app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

take_snapshot <- function(refresh = TRUE) {
  app$setInputs(`reactlog_module-refresh` = "click")
  Sys.sleep(4)
  app$snapshot()
}
take_snapshot(FALSE)


app$setInputs(n = 250)
take_snapshot()
app$setInputs(n = 100)
take_snapshot()
app$setInputs(newdata = "click")
take_snapshot()
app$setInputs(n = 300)
take_snapshot()
