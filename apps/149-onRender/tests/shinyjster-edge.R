if (shiny:::is_installed("htmlwidgets", "1.4")) {
  shinycoreci::test_shinyjster_app("edge")
}
