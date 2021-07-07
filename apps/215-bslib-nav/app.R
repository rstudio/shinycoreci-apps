library(shiny)
library(bslib)

nav_items <- list(
  nav("a", "tab a"),
  nav("b", "tab b"),
  nav_item(
    tags$a(icon("github"), "Shiny", href = "https://github.com/rstudio/shiny", target = "_blank")
  ),
  nav_spacer(),
  nav_menu(
    "Other links", align = "right",
    nav("c", "tab c"),
    nav_item(
      tags$a(icon("r-project"), "RStudio", href = "https://rstudio.com", target = "_blank")
    )
  )
)

shinyApp(
  page_navbar(
    title = "page_navbar()",
    bg = "#0062cc",
    !!!nav_items,
    header = markdown("Testing app for `bslib::nav_spacer()` and `bslib::nav_item()` [#319](https://github.com/rstudio/bslib/pull/319)."),
    footer = div(
      style = "width:80%; margin: 0 auto",
      h4("navs_tab()"),
      navs_tab(!!!nav_items),
      h4("navs_pill()"),
      navs_pill(!!!nav_items),
      h4("navs_tab_card()"),
      navs_tab_card(!!!nav_items),
      h4("navs_pill_card()"),
      navs_pill_card(!!!nav_items),
      h4("navs_pill_list()"),
      navs_pill_list(!!!nav_items)
    )
  ),
  function(...) { }
)
