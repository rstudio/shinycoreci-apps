library(shiny)
library(shinyjster)

defs <- list(
  text = list(
    ui = ~textInput(.id, label = NULL, .value),
    update = ~updateTextInput(session, .id, value = .value),
    value1 = "foo",
    value2 = "bar"
  ),
  textarea = list(
    ui = ~textAreaInput(.id, label = NULL, .value),
    update = ~updateTextAreaInput(session, .id, value = .value),
    value1 = "a",
    value2 = "b"
  ),
  password = list(
    ui = ~passwordInput(.id, label = NULL, .value),
    update = ~updateTextInput(session, .id, value = .value),
    value1 = "pass1",
    value2 = "pass2pass2"
  ),
  number = list(
    ui = ~numericInput(.id, label = NULL, value = .value),
    update = ~updateNumericInput(session, .id, value = .value),
    value1 = 0,
    value2 = 1
  ),
  checkbox = list(
    ui = ~checkboxInput(.id, label = "yep", value = .value),
    update = ~updateCheckboxInput(session, .id, value = .value),
    value1 = TRUE,
    value2 = FALSE
  ),
  slider = list(
    ui = ~sliderInput(.id, label = NULL, 0, 10, value = .value),
    update = ~updateSliderInput(session, .id, value = .value),
    value1 = 5,
    value2 = 6
  ),
  slider_range = list(
    ui = ~sliderInput(.id, label = NULL, 0, 10, value = .value),
    update = ~updateSliderInput(session, .id, value = .value),
    value1 = c(4, 5),
    value2 = c(5, 6)
  ),
  date = list(
    ui = ~dateInput(.id, label = NULL, value = .value),
    update = ~updateDateInput(session, .id, value = .value),
    value1 = "2020-10-01",
    value2 = "2020-10-04"
  ),
  date_range = list(
    ui = ~dateRangeInput(.id, label = NULL, start = .value[[1]], end = .value[[2]]),
    update = ~updateDateRangeInput(session, .id, start = .value[[1]], end = .value[[2]]),
    value1 = c("2020-10-01", "2020-10-02"),
    value2 = c("2020-10-04", "2020-10-05")
  ),
  selectize = list(
    ui = ~selectInput(.id, label = NULL, letters[1:5], selected = .value),
    update = ~updateSelectInput(session, .id, selected = .value),
    value1 = "a",
    value2 = "b"
  ),
  selectize_multi = list(
    ui = ~selectInput(.id, label = NULL, letters[1:5], selected = .value, multiple = TRUE),
    update = ~updateSelectInput(session, .id, selected = .value),
    value1 = letters[1:2],
    value2 = letters[3:4]
  ),
  select = list(
    ui = ~selectInput(.id, label = NULL, letters[1:5], selected = .value, selectize = FALSE),
    update = ~updateSelectInput(session, .id, selected = .value),
    value1 = "a",
    value2 = "b"
  ),
  select_multi = list(
    ui = ~selectInput(.id, label = NULL, letters[1:5], selected = .value, multiple = TRUE, selectize = FALSE),
    update = ~updateSelectInput(session, .id, selected = .value),
    value1 = letters[1:2],
    value2 = letters[3:4]
  ),
  radio = list(
    ui = ~radioButtons(.id, label = NULL, letters[1:5], selected = .value, inline = TRUE),
    update = ~updateRadioButtons(session, .id, selected = .value),
    value1 = "a",
    value2 = "b"
  ),
  checkbox_group = list(
    ui = ~checkboxGroupInput(.id, label = NULL, letters[1:5], selected = .value, inline = TRUE),
    update = ~updateCheckboxGroupInput(session, .id, selected = .value),
    value1 = letters[1:2],
    value2 = letters[3:4]
  ),
  tabset = list(
    ui = ~do.call(tabsetPanel, c(list(id = .id),
      lapply(letters[1:5], function(x) { tabPanel(x, x) }),
      list(selected = .value))),
    update = ~updateTabsetPanel(session, .id, selected = .value),
    value1 = "b",
    value2 = "c"
  )
)

# defs <- defs["tabset"]

apply_defs <- function(fun) {
  mapply(names(defs), defs, FUN = fun, USE.NAMES = FALSE, SIMPLIFY = FALSE)
}

generate_ui <- function(f, id, value, env = rlang::caller_env()) {
  rlang::eval_tidy(rlang::f_rhs(f), list(.id = id, .value = value), env)
}

ui <- fluidPage(
  fluidRow(
    column(6,
      actionButton("go", "Go"),
      verbatimTextOutput("check"),
      helpText("(It's fine for \"Fail\" to appear momentarily)"),
      verbatimTextOutput("debug")
    ),
    column(6,
      apply_defs(function(name, def) {
        tagList(
          h4(name),
          generate_ui(def$ui, id = paste0(name, "_same"), value = def$value1),
          generate_ui(def$ui, id = paste0(name, "_diff"), value = def$value2),
          uiOutput(paste0(name, "_ui_container"))
        )
      })
    )
  ),
  shinyjster_js("
    var jst = jster();
    jst.add(Jster.shiny.waitUntilIdleFor(1000));
    jst.add(function() { $('#go').click(); });
    jst.add(Jster.shiny.waitUntilIdleFor(1000));
    jst.add(function() { Jster.assert.isEqual($('#check').text(), 'OK') });
    jst.test();
  ")
)

freeze_and_update_input <- function(f, id, value) {
  session <- getDefaultReactiveDomain()
  freezeReactiveValue(session$input, id)
  rlang::eval_tidy(rlang::f_rhs(f), list(.id = id, .value = value))
}

count_obs <- function(id, successful_reads) {
  session <- getDefaultReactiveDomain()

  force(id)

  successful_reads[[id]] <- 0

  observe({
    req(!is.null(session$input[[id]]))
    successful_reads[[id]] <- successful_reads[[id]] + 1
  })
}

server <- function(input, output, session) {
  shinyjster::shinyjster_server(input, output, session)

  successful_reads <- new.env(parent = emptyenv())

  # For each definition...
  apply_defs(function(name, def) {

    first_time <- TRUE

    # Set up the
    output[[paste0(name, "_ui_container")]] <- renderUI({
      input$go

      on.exit(first_time <<- FALSE)

      freezeReactiveValue(input, paste0(name, "_ui_same"))
      freezeReactiveValue(input, paste0(name, "_ui_diff"))
      tagList(
        generate_ui(def$ui, paste0(name, "_ui_same"), def$value1),
        generate_ui(def$ui, paste0(name, "_ui_diff"), if (first_time) def$value2 else def$value1)
      )
    })

    observeEvent(input$go, {
      freeze_and_update_input(def$update, paste0(name, "_same"), def$value1)
      freeze_and_update_input(def$update, paste0(name, "_diff"), def$value1)
    }, priority = -1)

    count_obs(paste0(name, "_same"), successful_reads)
    count_obs(paste0(name, "_diff"), successful_reads)
    count_obs(paste0(name, "_ui_same"), successful_reads)
    count_obs(paste0(name, "_ui_diff"), successful_reads)
  })

  output$check <- renderPrint({
    reactiveValuesToList(input)

    if (all(input$go + 1 == unlist(as.list(successful_reads)))) {
      cat("OK\n")
    } else {
      cat("Fail\n")
    }
  })
  outputOptions(output, "check", priority = -10)

  output$debug <- renderPrint({
    reactiveValuesToList(input)

    df <- data.frame(reads = unlist(as.list(successful_reads)))
    df <- df[order(df$reads, rownames(df)),,drop = FALSE]
    print(df)
  })
  outputOptions(output, "debug", priority = -10)
}

shinyApp(ui, server)
