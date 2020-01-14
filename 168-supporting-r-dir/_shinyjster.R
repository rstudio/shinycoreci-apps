

function(app, ...) {
  shinycoreci:::with_options(list(shiny.autoload.r = TRUE), {
    shinyjster::run_headless(
      apps = app,
      ...
    )
  })
}
