library(testthat)
library(shiny)

# We explicitly pass environment() here because shiny::runTests() has sourced
# the files in R/, and the module we're testing was defined in those files. If
# we don't specify env, testthat uses an environment that doesn't include the
# module, and the tests fail.
testthat::test_file("testthat/tests.R", env = environment())
