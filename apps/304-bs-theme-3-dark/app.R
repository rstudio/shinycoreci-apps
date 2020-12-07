library(shiny)
library(bslib)
library(ggplot2)
library(thematic)
library(sf)
library(DT)

theme <- bs_theme(
  version = 3,
  bg = "#002B36", fg = "#EEE8D5",
  primary = "#2AA198",
  base_font = font_google("Grandstander")
)

# If run interactively, inject bs_themer() into the demo app
# so we can do manual tests with it
app_dir <- system.file("themer-demo", package = "bslib")
if (interactive()) {
  # Use this as opposed to bs_theme_preview() so we can deploy it
  bslib:::as_themer_app(app_dir, theme)
} else {
  old_theme <- bs_global_set(theme)
  onStop(function() {
    bs_global_set(old_theme)
  })
  shinyAppDir(app_dir)
}
