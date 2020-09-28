library(shiny)

helloModal <- function(mode = c("dark", "light")) {
  modalDialog(
    title = "Welcome!",
    markdown(c(
      "Please make sure all the colors (and fonts) in this app reflect a",
      sprintf("*%s*", match.arg(mode)), "mode", "with the",
      "**[Grandstander font](https://fonts.google.com/specimen/Grandstander)**. ",
      "Also, make sure that, when interacting with each UI component, relevant",
      "hover, focus, and active colors and fonts are 'sensible'",
      "(if you think anything is obviously wrong, or needs improving, please notify the team)."
    )),
    easyClose = TRUE,
    footer = modalButton("Close")
  )
}
