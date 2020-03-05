

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

  shinyjster::run_jster_apps(
    apps = c(
      file.path(app, "169-prerender-a", "index.Rmd"),
      file.path(app, "169-prerender-b")
    ),
    ...,
    type = "lapply"
  )
}
