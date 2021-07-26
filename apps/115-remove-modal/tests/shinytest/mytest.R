app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

app$setInputs(openModalBtn = "click")
Sys.sleep(1)
app$snapshot()

# Verify modal is closed
app$setInputs(closeModalBtn = "click")
Sys.sleep(1)
app$snapshot()
