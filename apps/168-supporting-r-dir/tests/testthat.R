library(testthat)
library(shiny)

# We explicitly pass environment() here because shiny::runTests() has sourced
# the files in R/, and the module we're testing was defined in those files. If
# we don't specify env, testthat uses an environment that doesn't include the
# module, and the tests fail.
testthat::test_dir(
  "testthat/",
  env = environment(),
  # Ensure that errors propagate out to runTests(), which is generally how app
  # tests should be exercised.
  stop_on_failure = TRUE
)
