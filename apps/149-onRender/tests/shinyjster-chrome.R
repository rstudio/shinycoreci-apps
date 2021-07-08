if (shiny:::is_available("htmlwidgets", "1.4")) {
  shinycoreci::test_shinyjster_app("chrome")
}
