if (nzchar(system.file(package = "htmltools")) &&
    packageVersion("htmltools") >= "0.5.0") {
  shinycoreci::test_shinyjster_app("chrome")
}
