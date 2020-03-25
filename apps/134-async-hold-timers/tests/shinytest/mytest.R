app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

app$snapshot()
# This is the literal data structure that is sent for output$status. We're
# waiting for it to change so that it no longer says "Waiting...". The data
# structure was retrieved by using `dput(app$getAllValues()$output$status)`.
app$waitForValue("status", iotype = "output", timeout = 20000,
  ignore = list(list(html = structure("<h4>\n  <span style=\"background-color: #dddddd;\">Waiting...</span>\n</h4>", html = TRUE, class = c("html",
"character")), deps = list())))
app$snapshot()
