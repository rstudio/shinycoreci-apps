if (nzchar(system.file(package = "highcharter")) &&
    packageVersion("highcharter") >= "0.8.2") {
  shinycoreci::test_shinytest_app()
}
