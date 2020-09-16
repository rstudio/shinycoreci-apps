library(shiny)
library(bootstraplib)

helloModal <- function(mode = c("dark", "light"), font = bs_theme_get_variables("font-family-base")) {
  modalDialog(
    title = "Welcome!",
    markdown(c(
      "Please make sure all the colors (and fonts) in this app reflect a",
      sprintf("*%s*", match.arg(mode)), "mode", "with the",
      sprintf("**[%s font](https://fonts.google.com/specimen/%s)**. ", font, font),
      "Also, make sure that, when interacting with each UI component, relevant",
      "hover, focus, and active colors and fonts are 'sensible'",
      "(if you think anything is obviously wrong, or needs improving, please notify the team)."
    )),
    easyClose = TRUE,
    footer = modalButton("Close")
  )
}



