library(shiny)
library(magrittr)

ui <- fluidPage(
  fluidRow(
    column(12,
      h1("Throttle/debounce test app"),
      p("Click the button quickly. 'Unmetered' should update constantly. 'Throttle' should update every second. 'Debounce' should update only after you've stopped clicking for one second."),
      hr(),
      actionButton("click", "Increment")
    ),
    column(4,
      h3("Unmetered"),
      verbatimTextOutput("raw")
    ),
    column(4,
      h3("Throttle (1 second)"),
      verbatimTextOutput("throttle")
    ),
    column(4,
      h3("Debounce (1 second)"),
      verbatimTextOutput("debounce")
    )
  ),
  shinyjster::shinyjster_js("
    var jst = jster(0);
    jst.add(Jster.shiny.waitUntilIdle);

    var click = function() {
      $('#click').click();
    }

    var base_vals = [0, 10, 20];
    base_vals.map(function(base_value) {
      var is_equal = function(id, val, clicks) {
        Jster.assert.isEqual(
          $('#' + id).text().trim() - base_value,
          val,
          {id: id, clicks: clicks}
        );
      }

      var equal_vals = function(raw_val, debounce_val) {
        var observed_raw = $('#raw').text().trim() - base_value;
        // make sure observed is never bigger than actual
        Jster.assert.isTrue(raw_val >= observed_raw);
        // make sure the gap is never bigger than 1
        Jster.assert.isTrue((raw_val - observed_raw) <= 1);

        // is_equal('throttle', throttle_val, raw_val);
        var throttle_val = $('#throttle').text().trim() - base_value;
        Jster.assert.isTrue(throttle_val <= raw_val, {throttle_val: throttle_val, raw_val: raw_val})
        Jster.assert.isTrue(debounce_val <= throttle_val, {throttle_val: throttle_val, debounce_val: debounce_val})

        is_equal('debounce', debounce_val, raw_val);
      }

      jst.add(function(done) {
        equal_vals(0, 0);
        is_equal('throttle', 0, 0);

        setTimeout(click, 0);
        setTimeout(click, 250);
        setTimeout(click, 500);
        setTimeout(click, 750);
        setTimeout(click, 1000);
        setTimeout(click, 1250);
        setTimeout(click, 1500);
        setTimeout(click, 1750);
        setTimeout(click, 2000);
        setTimeout(click, 2250);

        setTimeout(function() { equal_vals( 1,  0); },    0 + 125);
        setTimeout(function() { equal_vals( 2,  0); },  250 + 125);
        setTimeout(function() { equal_vals( 3,  0); },  500 + 125);
        setTimeout(function() { equal_vals( 4,  0); },  750 + 125);
        setTimeout(function() { equal_vals( 5,  0); }, 1000 + 125);
        setTimeout(function() { equal_vals( 6,  0); }, 1250 + 125);
        setTimeout(function() { equal_vals( 7,  0); }, 1500 + 125);
        setTimeout(function() { equal_vals( 8,  0); }, 1750 + 125);
        setTimeout(function() { equal_vals( 9,  0); }, 2000 + 125);
        setTimeout(function() { equal_vals(10,  0); }, 2250 + 125);

        setTimeout(function() {
          equal_vals(10, 10);
          is_equal('throttle', 10, 10);
          done();
        }, 3250 + 125);
      });
    });


    jst.test();
  ")
)

server <- function(input, output, session) {
  shinyjster::shinyjster_server(input, output, session)

  pos_raw <- reactive(input$click)
  pos_throttle <- pos_raw %>% throttle(1000)
  pos_debounce <- pos_raw %>% debounce(1000)

  output$raw <- renderText({
    pos_raw()
  })

  output$throttle <- renderText({
    pos_throttle()
  })

  output$debounce <- renderText({
    pos_debounce()
  })

}

shinyApp(ui, server)
