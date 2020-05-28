if (nzchar(system.file(package = "ragg")) &&
    packageVersion("ragg") >= "0.2") {
  shinycoreci::test_shinytest_app()
}
