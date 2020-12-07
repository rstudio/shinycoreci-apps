library(shiny)
library(bslib)
library(ggplot2)
library(thematic)
library(sf)
library(DT)

theme <- bs_theme(version = 3)

old_theme <- bs_global_set(theme)
onStop(function() {
  bs_global_set(old_theme)
})
shinyAppDir(system.file("themer-demo", package = "bslib"))
