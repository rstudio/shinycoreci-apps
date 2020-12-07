library(shiny)
library(bslib)
library(ggplot2)
library(thematic)
library(sf)
library(DT)

theme <- bs_theme(
  version = 4,
  bg = "#202123",
  fg = "#B8BCC2",
  primary = "#EA80FC",
  secondary = "#00DAC6",
  success = "#4F9B29",
  info = "#28B3ED",
  warning = "#FD7424",
  danger = "#F7367E",
  base_font = font_google("Open Sans"),
  heading_font = font_google("Proza Libre"),
  code_font = font_google("Fira Code")
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
