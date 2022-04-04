if (nzchar(system.file(package = "DT")) &&
    packageVersion("DT") >= "0.6") {
  shinytest2::test_app()
}
