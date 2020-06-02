if (nzchar(system.file(package = "reactR")) &&
    packageVersion("reactR") > "0.4") {
shinycoreci::test_shinyjster_app("chrome")
}
