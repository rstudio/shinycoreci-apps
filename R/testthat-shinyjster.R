#' @export
#'
testthat_shinyjster <- function(
  test_name = NULL,
  app_dir = "../../",
  ...,
  browsers = c("chrome", "firefox", "edge", "ie"),
  timeout = 2 * 60,
  dimensions = "1200x1200"
) {

  browsers <- unique(match.arg(browsers, several.ok = TRUE))

  app_name <- basename(normalizePath(app_dir))
  name <- paste0(app_name, " - shinyjster - ")
  suffix <- if (!is.null(test_name)) paste0(" - ", test_name) else ""

  ret <- list()

  lapply(browsers, function(browser) {
    testthat::test_that(paste0(name, browser, suffix), {
      if (browser == "edge") testthat::skip("Not testing Edge browser")
      if (browser %in% c("edge", "ie") && shinycoreci::platform() != "windows") testthat::skip("Only testing Edge or IE on Windows")

      # Temp workaround while mac firefox apps don't complete in time
      if (browser == "firefox" && shinycoreci::platform() == "mac") testthat::skip("Not testing Firefox on macOS")
      browser_func <- switch(browser,
        chrome = shinyjster::selenium_chrome(timeout = timeout, dimensions = dimensions),
        firefox = shinyjster::selenium_firefox(timeout = timeout, dimensions = dimensions),
        edge = shinyjster::selenium_edge(timeout = timeout, dimensions = dimensions),
        ie = shinyjster::selenium_ie(timeout = timeout, dimensions = dimensions),
        stop("Unknown browser: ", browser)
      )

      shinyjster::test_jster(apps = app_dir, browsers = browser_func, type = "lapply")
    })
  })
}
