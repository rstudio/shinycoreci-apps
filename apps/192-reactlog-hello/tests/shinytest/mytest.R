app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

take_snapshot <- function(refresh = TRUE) {
  app$setInputs(`reactlog_module-refresh` = "click")
  Sys.sleep(4)
  app$snapshot()
}
take_snapshot(FALSE)

app$setInputs(bins = 8)
take_snapshot()
app$setInputs(bins = 5)
app$setInputs(bins = 22)
take_snapshot()
