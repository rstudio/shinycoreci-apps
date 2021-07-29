app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

# Verify modal is open
app$executeScript(
  "window.modalShown = false;
  $(document).on('shown.bs.modal', function(e) { window.modalShown = true; });"
)
app$setInputs(openModalBtn = "click")
app$waitFor("window.modalShown")
app$snapshot()


# Verify modal is closed
app$executeScript(
  "window.modalHidden = false;
  $(document).on('hidden.bs.modal', function(e) {window.modalHidden = true; });"
)
app$setInputs(closeModalBtn = "click")
app$waitFor("window.modalHidden")
app$snapshot()
