library(shiny)
library(shinyjster)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      actionButton("add", "DO NOT TOUCH!")
    ),
    mainPanel(
      tags$h1("Do not touch the tabs below"),
      "Original issue: ", tags$a(href="https://github.com/rstudio/shiny/issues/2116", "rstudio/shiny#2116"),tags$br(),
      "PR: ", tags$a(href="https://github.com/rstudio/shiny/pull/2545", "rstudio/shiny#2545"),tags$br(),
      tags$br(),
      "The javascript will show a passing or failing message in the sidebar when completed in < 10 seconds.",
      tags$br(),tags$br(),
      tags$div(id="progress"),
      tags$div(id="result"),
      tags$br(),tags$br(),
      tabsetPanel(id = "tabs",
        tabPanel(
          "Hello",
          tagList(
            "This is the hello tab. ",
            tags$span(class = "val", 0)
          )
        )
      )
    )
  ),
  shinyjster_js("
  var counter = 0;
  var jst = jster(200);

  // init working tabs
  function add_button_click() {
    jst.add(Jster.shiny.waitUntilStable);
    jst.add(function() { $('#add').click(); });
  }
  add_button_click()
  add_button_click()
  add_button_click()

  // click tabs to cause error state
  function add_click_tab(idx) {
    jst.add(Jster.shiny.waitUntilStable);
    jst.add(function() { $($('#tabs a').get(idx)).click(); });
  }
  add_click_tab(0)
  add_click_tab(1)
  add_click_tab(2)

  // add _broken_ tabs
  add_button_click()
  add_button_click()
  add_button_click()
  add_button_click()

  // calculate value of active tab to get sum to check if working
  function add_active_pane_counter() {
    jst.add(Jster.shiny.waitUntilStable);
    jst.add(function() {
      var val = $('.tab-pane.active .val').text() - 0;
      counter = counter + val;
    });
  }

  add_click_tab(0); add_active_pane_counter();
  add_click_tab(1); add_active_pane_counter();
  add_click_tab(2); add_active_pane_counter();
  add_click_tab(3); add_active_pane_counter();
  add_click_tab(4); add_active_pane_counter();
  add_click_tab(5); add_active_pane_counter();
  add_click_tab(6); add_active_pane_counter();
  add_click_tab(7); add_active_pane_counter();

  // verify the tabs work
  jst.add(Jster.shiny.waitUntilStable);
  jst.add(function() {
    var sum = 0;
    var len = $('.tab-pane').get().length;
    for (var i = 0; i < len; i++) {
      sum += i;
    }

    if (counter != sum) {
      throw `FAILED!\nCounted a sum of ${ counter } vs ${ sum }`
    }
  });

  jst.test();
  ")
)


server <- function(input, output, session) {
  shinyjster_server(input, outout, session)

  n <- 0
  observeEvent(input$add, {
    appendTab(inputId = "tabs",
      {
        n <<- n + 1
        tabPanel(
          "Dynamic",
          tagList(
            "Content for dynamic tab ",
            tags$span(class = "val", n)
          )
        )
      }
    )
  })
}

shinyApp(ui, server)
