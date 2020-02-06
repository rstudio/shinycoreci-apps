library(shiny)
library(websocket)
library(shinyjs)

ui <- fluidPage(
  shinyjs::useShinyjs(),
  fluidRow(
    column(6, offset = 3,
      h1("WebSocket client", style = "text-align: center;"),
      tags$p(
        tags$strong("Status:"),
        textOutput("status", inline = TRUE)
      ),
      wellPanel(
        textInput("input", "Message to send:"),
        actionButton("send", "Send"),
        actionButton("close", "Close")
      ),

      tags$strong("Messages received:"),
      tableOutput("output")
    )
  ),
  shinyjster::shinyjster_js("
    var jst = jster();
    jst.add(Jster.shiny.waitUntilStable);
    jst.add(function() { Jster.button.click('connect'); });

    [
      'test input value',
      'other value to test',
      'third test val'
    ].map(function(testVal) {

      jst.add(Jster.shiny.waitUntilStable);
      jst.add(function(done) {
        var i = 0;
        var wait = function() {
          console.log('waiting!')
          if (/^Connected/.test($('#status').text().trim()) ) {
            done();
            return;
          }

          if (i > 30 * 10) {
            done();
            return;
          }

          i = i + 1;
          setTimeout(wait, 100);
        }
        wait();
      })
      jst.add(function() {
        Jster.assert.isEqual($('#status').text().trim(), 'Connected to wss://echo.websocket.org');

        Jster.input.setValue('input', testVal);
      });
      jst.add(Jster.shiny.waitUntilStable);

      jst.add(function() {
        Jster.button.click('send');
      })
      jst.add(Jster.shiny.waitUntilStable);
      jst.add(function(done) {
        var wait = function() {
          if (Jster.input.value('input') === '') {
            console.log('done!')
            done();
            return;
          }
          setTimeout(wait, 100);
        }
        wait();
      });
      jst.add(Jster.shiny.waitUntilIdleFor(2000));

      jst.add(function() {
        Jster.assert.isEqual(
          // first output value is equal to test value
          $('#output table tr:nth-child(1) td:nth-child(2)').text().trim(),
          testVal
        );
      });
    });
    jst.add(Jster.shiny.waitUntilStable);
    jst.add(function() {
      Jster.button.click('close');
    });
    jst.add(Jster.shiny.waitUntilStable);
    jst.add(function() {
      Jster.assert.isEqual(
        $('#status').text().trim(),
        'Closed: 1000 -'
      );
    });

    jst.test();
  ")
)

server <- function(input, output, session) {
  shinyjster::shinyjster_server(input, output, session)

  status <- reactiveVal("Waiting for input")
  history <- reactiveVal(
    data.frame(Date = NULL, Message = NULL)
  )

  setEnabled <- function(enable) {
    withReactiveDomain(session, {
      shinyjs::toggleState("input", enable)
      shinyjs::toggleState("send", enable)
      shinyjs::toggleState("close", enable)
    })
  }
  setEnabled(FALSE)

  connect <- function(url) {
    ws <- WebSocket$new("ws://echo.websocket.org")
    status(paste0("Connecting to ", url, ", please wait..."))
    ws$onError(function(event) {
      setEnabled(FALSE)
      status(paste0("Error: ", event$message))
    })
    ws$onMessage(function(event) {
      old <- isolate(history())
      new <- data.frame(
        Date = format(Sys.time()),
        Message = event$data,
        stringsAsFactors = FALSE)
      history(rbind(new, old))
    })
    ws$onOpen(function(event) {
      setEnabled(TRUE)
      status(paste0("Connected to ", isolate(input$url)))
    })
    ws$onClose(function(event) {
      setEnabled(FALSE)
      status(paste0("Closed: ", event$code, " - ", event$reason))
    })
    ws
  }

  ws <- NULL

  showModal(
    modalDialog(
      textInput("url", "WebSocket URL", "wss://echo.websocket.org"),
      footer = actionButton("connect", "OK"),
      easyClose = FALSE,
      size = "s"
    )
  )

  observeEvent(input$connect, {
    removeModal()
    ws <<- connect(input$url)
  })

  observeEvent(input$send, {
    msg <- input$input
    ws$send(msg)
    updateTextInput(session, "input", value = "")
  })

  observeEvent(input$close, {
    ws$close()
  })

  output$output <- renderTable(width = "100%", {
    history()
  })

  output$status <- renderText({
    status()
  })

}

shinyApp(ui, server)
