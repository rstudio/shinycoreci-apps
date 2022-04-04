if (nzchar(system.file(package = "htmltools")) &&
    packageVersion("htmltools") >= "0.5.0") {
  shinytest2::test_app()
}
