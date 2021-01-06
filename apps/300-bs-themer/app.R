### Keep this line to manually test this shiny application. Do not edit this line; shinycoreci::::is_manual_app
library(shiny)
library(bslib)
library(ggplot2)
library(thematic)
library(sf)
library(DT)

# Essentially the same as bs_theme_preview(), but deployable
old_theme <- bs_global_set(bs_theme())
onStop(function() {
  bs_global_set(old_theme)
})
bslib:::as_themer_app(system.file("themer-demo", package = "bslib"))
