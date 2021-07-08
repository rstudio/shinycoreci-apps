library(bslib)
local({
  old_theme <- bs_global_set(bs_theme(version=5))
  on.exit(bs_global_set(old_theme))
  shinycoreci::test_shinyjster_app("edge", dimensions = "550x700")
})
