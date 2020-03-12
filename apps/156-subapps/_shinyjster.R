
function(app, ...) {
  shinyjster::run_jster(
    appDir = file.path(app, "index.Rmd"),
    ...
  )
}
