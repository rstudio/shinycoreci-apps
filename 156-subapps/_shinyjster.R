
function(app, ...) {
  ret156 <- shinyjster::run_headless(
    apps = file.path(app, "index.Rmd"),
    ...
  )

  ret156$appDir <- app
  ret156
}
