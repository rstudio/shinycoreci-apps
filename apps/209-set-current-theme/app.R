library(shiny)
library(bslib)
light <- bs_theme()
dark <- bs_theme(bg = "black", fg = "white", primary = "purple")
ui <- fluidPage(
  theme = light,
  checkboxInput("dark_mode", "Dark mode", value = FALSE),
  shinyjster::shinyjster_js("
    var jst = jster();
    jst.add(Jster.shiny.waitUntilStable);
    jst.add(Jster.shiny.waitUntilIdleFor(1000));

    jst.add(function() {
      var bg = window.getComputedStyle(document.body).backgroundColor;
      Jster.assert.isEqual(bg, 'rgb(255, 255, 255)');
    });

    jst.add(function() {
      Shiny.setInputValue('dark_mode', true);
    });

    // Wait until the body's bg color has changed
    jst.add(function(done) {
      var wait = function() {
        var bg = window.getComputedStyle(document.body).backgroundColor;
        if (bg === 'rgb(255, 255, 255)') {
          setTimeout(wait, 100);
          return;
        }
        done();
        return;
      }
      wait();
    });

    jst.add(function() {
      var bg = window.getComputedStyle(document.body).backgroundColor;
      Jster.assert.isEqual(bg, 'rgb(0, 0, 0)');
    });

    jst.test();
  ")
)
server <- function(input, output, session) {
  shinyjster::shinyjster_server(input, output)

  observe(session$setCurrentTheme(
    if (isTRUE(input$dark_mode)) dark else light
  ))
}
shinyApp(ui, server)

