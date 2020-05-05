library(shinyjster)

test_jster_169 <- function(browser_func) {

  app <- "../"

  # delete cache file
  cache_file <- file.path(app, "169-prerender-a", "index.html")
  if (file.exists(cache_file)) {
    unlink(cache_file)
  }
  on.exit({
    if (file.exists(cache_file)) {
      unlink(cache_file)
    }
  }, add = TRUE)

  ret <- shinyjster::test_jster(
    apps = c(
      file.path(app, "169-prerender-a", "index.Rmd"),
      file.path(app, "169-prerender-b")
    ),
    type = "lapply",
    browsers = browser_func,
    assert = FALSE
  )

  shinyjster::assert_jster(ret)
  tibble::tibble(
    appDir = normalizePath(app),
    successful = TRUE,
    # will be a "success"
    returnValue = ret$returnValue[[1]]
  )

}
