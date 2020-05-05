library(shinytest)
shinytest::expect_pass(
  shinytest::testApp(
    "../",
    suffix = shinycoreci::platform()
  )
)
