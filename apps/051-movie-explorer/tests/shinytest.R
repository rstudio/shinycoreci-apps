# Doesn't want to consistently pass on all builds...there some sort of timing
# issue where shinytest doesn't know how long to wait before taking a snapshot
if (FALSE) {
  shinycoreci::test_shinytest_app()
}

