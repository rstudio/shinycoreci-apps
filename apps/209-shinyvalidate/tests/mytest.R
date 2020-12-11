app <- ShinyDriver$new("../")
app$snapshotInit("mytest")

# Note different order of themes than radio buttons so all changes actually
# change style
bootswatch_types <- c("cerulean", "darkly", "flatly")

for(bootswatch in bootswatch_types){
  app$setInputs(current_theme = bootswatch)
  app$snapshot(filename = paste0("start-", bootswatch, ".png"))
  app$setInputs(text = "RStudio")
  app$setInputs(select = "Michigan")
  app$setInputs(date = "2020-12-24")
  app$setInputs(dateRange = c("2020-12-11", "2020-12-10"))
  app$setInputs(dateRange = c("2020-12-11", "2020-12-12"))
  app$setInputs(slider = 0)
  app$setInputs(slider = 1)
  app$setInputs(checkbox = TRUE)
  app$setInputs(checkboxGroup = "B")
  app$setInputs(radio = "B")
  app$snapshot(filename = paste0("all_satisfied-", bootswatch, ".png"))
  app$setInputs(radio = "A")
  app$setInputs(checkboxGroup = c("A", "B"))
  app$setInputs(checkbox = FALSE)
  app$setInputs(slider = 100)
  app$setInputs(dateRange = c("2020-12-02", "2020-12-11"))
  app$setInputs(date = "2020-12-08")
  app$setInputs(select = character(0))
  app$setInputs(text = "")
  app$snapshot(filename = paste0("all_broken-", bootswatch, ".png"))
}

