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

if (interactive()) {
  bs_theme_preview(theme)
} else {
  old_theme <- bs_global_set(theme)
  onStop(function() {
    bs_global_set(old_theme)
  })
  shinyAppDir(system.file("themer-demo", package = "bslib"))
}
