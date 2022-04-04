if (nzchar(system.file(package = "reactR")) &&
    packageVersion("reactR") > "0.4") {
  shinytest2::test_app()
}
