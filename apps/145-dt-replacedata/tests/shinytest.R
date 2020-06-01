if (nzchar(system.file(package = "DT")) &&
    packageVersion("DT") >= "0.6") {
  shinycoreci::test_shinytest_app()
}


