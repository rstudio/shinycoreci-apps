test_that("text passes", {
  app <- shinytest::ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))

  val <- app$waitForValue("status", iotype = "output", ignore = list(NULL, ""))
  cat("val:\n")
  str(val)

  for (i in 1:50) {
    Sys.sleep(0.5)
    textVal <- app$findElement("#status")$getText()
    if (textVal != "") break
  }
  cat("textVal:\n")
  str(textVal)

  testthat::expect_equal(
    textVal,
    "PASS"
  )
})
