shinycoreci:::with_options(list(shiny.autoload.r = TRUE), {
  shinycoreci::test_shinyjster_app("ie")
})
