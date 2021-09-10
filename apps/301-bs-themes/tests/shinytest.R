library(shinytest)
library(bslib)

run_test_app <- function() {
  old <- setwd("../")
  on.exit(setwd(old), add = TRUE)

  # bs_theme() defs may be added/removed from this file, which will
  # add/remove new shinytests
  test_names <- names(yaml::yaml.load_file("themes.yaml", eval.expr = TRUE))
  test_names <- gsub("\\s+", "-", test_names)

  # Prevent the possibility of weird subdirs
  bad_names <- grep("/", test_names, fixed = TRUE, value = TRUE)
  if (length(bad_names)) {
    stop(
      "`/` is not allowed in theme name(s), please remove it:",
      paste(bad_names, collapse = ", ")
    )
  }

  # Ensure shinytest/ doesn't include anything other than themes.yaml tests
  test_dir <- file.path("tests", "shinytest")
  bad_dirs <- grep(
    paste0("^", test_names, collapse = "|^"),
    list.dirs(test_dir), value = TRUE
  )
  unlink(bad_dirs, recursive = TRUE)
  unlink(Sys.glob(file.path(test_dir, "*.R")))

  lapply(test_names, function(x) {
    brio::write_file(
      paste0(
        "# Do not edit this test script by hand. This script was generated automatically by \n# ./app/shinytest-template.R & ./app/tests/shinytest.R\n",
        glue::glue(brio::read_file("shinytest-template.R"), test_name = x, .open = "{{", .close = "}}")
      ),
      file.path(test_dir, paste0(x, ".R"))
    )
  })

  shinycoreci::test_shinytest_app(".", testnames = test_names)
}

# Only run these tests on mac + r-release
# (To reduce the amount of screenshot diffing noise)
release <- rversions::r_release()$version
release <- paste0(
  strsplit(release, ".", fixed = TRUE)[[1]][1:2],
  collapse = "."
)
if (identical(paste0("mac-", release), shinycoreci::platform_rversion())) {
  # Yell if there are extra expected folders
  folders <- dir("shinytest", pattern = "-expected-")
  is_bad_folder <- !(grepl(paste0("-", release, "$"), folders) & grepl("-mac-", folders))
  if (any(is_bad_folder)) {
    stop("Unexpected output folders found:\n", paste0("* ", folders[is_bad_folder], collapse = "\n"))
  }

  run_test_app()
}
