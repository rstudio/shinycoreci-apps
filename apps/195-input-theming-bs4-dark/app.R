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

# TODO: thematic needs a fix for this "Error: cannot open file 'Rplots.pdf'"
# https://github.com/ropensci/plotly/issues/494
pdf(NULL)

if (interactive()) {
  bs_theme_preview(theme)
} else {
  old_theme <- bs_global_set(theme)
  onStop(function() {
    bs_global_set(old_theme)
  })
  shinyAppDir(system.file("themer-demo", package = "bslib"))
}
