

function(app, ...) {
  shinycoreci:::with_options(list(shiny.autoload.r = TRUE), {
    shinyjster::run_jster(
      appDir = app,
      ...
    )
  })
}
