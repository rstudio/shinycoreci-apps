if (nzchar(system.file(package = "future")) &&
    packageVersion("future") >= "1.21.0") {
  shinycoreci::test_shinyjster_app("firefox")
}
