
# (default) windows has trouble with chinese characters. Better to test manually at a later time
if (shinycoreci::platform() != "win") {
  shinycoreci::test_shinytest_app()
}
