

function(app = ".", ..., type = "ignored") {

  # run 169-prerender-a in same R session as 169-prerender-b

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

  ret <- shinyjster::run_headless(
    apps = c(
      file.path(app, "169-prerender-a", "index.Rmd"),
      file.path(app, "169-prerender-b")
    ),
    ...,
    type = "lapply"
  )

  ret169 <- ret[1, ]
  ret169$appDir <- app
  ret169$successful <- all(ret$successful)
  if (!ret169$successful[[1]]) {
    ret169$returnValue[[1]] <- ret$returnValue[[(!ret$successful)[[1]]]]
  }

  return(ret169)
}
