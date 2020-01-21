
function(app, ...) {
  shinyjster::run_headless(
    apps = file.path(app, "index.Rmd"),
    ...
  )
}
