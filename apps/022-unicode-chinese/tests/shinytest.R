
# (default) windows has trouble with chinese characters. Better to test manually at a later time
if (shinycoreci::platform() != "win") {
  library(shinytest)
  shinytest::expect_pass(
    shinytest::testApp(
      "../",
      suffix = shinycoreci::platform()
    )
  )
}
