app <- ShinyDriver$new("../../", seed = 54322)
app$snapshotInit("mytest")

take_snapshot <- function(refresh = TRUE) {
  app$setInputs(`reactlog_module-refresh` = "click")
  Sys.sleep(4)
  app$snapshot()
}
take_snapshot(FALSE)

app$setInputs(a = 5, b = 12)

take_snapshot()
