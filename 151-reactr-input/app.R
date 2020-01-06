library(shiny)
library(reactR)

simpleTextInput <- function(inputId, default = "") {
  createReactShinyInput(
    inputId = inputId,
    class = 'simple-text-input',
    dependencies = htmltools::htmlDependency(
      'simple-text-input',
      '1.0.0',
      src = file.path(getwd(), "js"),
      script = 'input.js',
      all_files = FALSE
    ),
    default = default,
    container = tags$span
  )
}

ui <- function(request) {
  fluidPage(
    titlePanel("reactR Input Demo"),
    tags$p("Enter text under 'Input' below. It should show up under 'Output'."),
    tags$p("You should also be able to bookmark this page and the input will retain its value."),
    tags$p(bookmarkButton()),
    tags$h1("Input"),
    tags$div(
      tags$p(simpleTextInput('simpleTextInput')),
      tags$h1("Output"),
      textOutput("simpleTextOutput")
    ),
    shinyjster::shinyjster_js("
      var jst = jster();
      jst.add(Jster.shiny.waitUntilStable);
      var has_redirected = false;
      jst.add(function() {
        if (/simpleTextInput=%22testValue%22/.test(window.location.href)) {
          // already redirected
          has_redirected = true;
        }

        $('#simpleTextInput input').val('testValue');
        $('#simpleTextInput').data('value', 'testValue');
        $('#simpleTextInput').data('callback')(false); // trigger reactR value
      });
      jst.add(Jster.shiny.waitUntilStable);
      jst.add(function() {
        if (has_redirected) return;
        Jster.assert.isEqual(
          $('#simpleTextOutput').text().trim(),
          'testValue'
        );
      });

      jst.add(function() {
        if (has_redirected) return;
        Jster.bookmark.click('._bookmark_');
      });
      jst.add(Jster.shiny.waitUntilStable);

      jst.add(function() {
        if (has_redirected) return;
        Jster.assert.isTrue(
          /simpleTextInput=%22testValue%22/.test(
            $('.modal-body .form-control').val()
          )
        );
      })

      jst.add(function(done) {
        if (has_redirected) {
          done();
          return;
        };

        var new_url = $('.modal-body .form-control').val() + '&shinyjster=1';
        window.location.assign(new_url);
        // never call `done()` as to not allow shinyjster to close the window
      })

      jst.test();
    ")
  )
}

server <- function(input, output, session) {
  shinyjster::shinyjster_server(input, output, session)
  output$simpleTextOutput <- renderText(input$simpleTextInput)
}

shinyApp(ui, server, enableBookmarking = "url")
