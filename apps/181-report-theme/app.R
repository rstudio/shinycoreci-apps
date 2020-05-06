### Keep this line to manually test this shiny application. Do not edit this line; shinycoreci::::is_manual_app

library(shiny)
library(htmltools)

# This test is primarily for testing that getCurrentOutputInfo() returns bg+fg+accent+font
# info, but also makes sure that renderPlot() can render custom fonts via showtext and ragg

# Register font for use with showtext and ragg
# NOTE: these were downloaded via `gfonts::download_font("pacifico", "www/fonts")`
sysfonts::font_add("Pacifico", "www/fonts/pacifico-v16-latin-regular.ttf")
systemfonts::register_font("Pacifico", "www/fonts/pacifico-v16-latin-regular.ttf")

# Now enable showtext so that font can render with a non-ragg renderPlot()
showtext::showtext_auto()
onStop(function() { showtext::showtext_auto(FALSE) })

# Set up CSS styles using a structure that getCurrentOutputInfo() should return
font <- list(
  families = c("Definitely not a font", "Pacifico"),
  size = "10px",
  renderedFamily = "Pacifico"
)

info1 <- list(
  bg = "#000000",
  fg = "#FFFFFF",
  accent = "#00FF00",
  font = font
)

info2 <- list(
  bg = "#008080",
  fg = "#0000FF",
  accent = "#000000",
  font = font
)

to_json <- function(x, ...) {
  jsonlite::toJSON(x, auto_unbox = TRUE, ...)
}

# Translate R lists to CSS
info2css <- function(info, selector = "body") {
  tagList(
    tags$style(HTML(sprintf(
      "%s {color: %s; background-color: %s; font-family: '%s'; font-size: %s}",
      selector, info$fg, info$bg, paste(info$font$families, collapse = "', '"),
      info$font$size
    ))),
    tags$style(HTML(sprintf(
      "%s a {color: %s}",
      selector, info$accent
    )))
  )
}


shinyApp(
  fluidPage(
    # gfonts::generate_css("pacifico", output = "www/pacifico.css", font_dir = "fonts/")
    tags$head(tags$link(href="pacifico.css", rel="stylesheet", type="text/css")),
    info2css(info1, "body"),
    info2css(info2, "#info2"),
    tags$h5("You should see 3 'Test passed!' messages below"),
    plotOutput("plot", height = 150),
    plotOutput("plot_ragg", height = 150),
    imageOutput("image", height = 150),
    tags$h5("Ignore the output below (it's for a shinyjster test)"),
    tagAppendAttributes(
      textOutput("info1"),
      class = "shiny-report-theme"
    ),
    tagAppendAttributes(
      textOutput("info2"),
      class = "shiny-report-theme"
    ),

    shinyjster::shinyjster_js(
      sprintf(
      "
        var jst = jster();
        jst.add(Jster.shiny.waitUntilStable);

        jst.add(function() {
          Jster.assert.isEqual(
            JSON.parse($('#info1').text()), JSON.parse('%s')
          );
          Jster.assert.isEqual(
            JSON.parse($('#info2').text()), JSON.parse('%s')
          );
        });

        jst.test();", to_json(info1), to_json(info2)
      )
    )
  ),
  function(input, output, session) {
    shinyjster::shinyjster_server(input, output, session)

    do_plot <- function() {
      info <- getCurrentOutputInfo()
      par(bg = info$bg())
      plot(1, type = "n")
      text(1, "Test passed!", family = "Pacifico", col = info$fg())
    }

    output$plot <- renderPlot(do_plot())

    output$image <- renderImage({
      height <- session$clientData$output_image_height
      width <- session$clientData$output_image_width
      pixelratio <- session$clientData$pixelratio
      png("tmp.png", height = height*pixelratio, width = width*pixelratio, res = 72*pixelratio)
      do_plot()
      dev.off()
      list(src = "tmp.png", height = 150, width = "100%")
    })

    # Option must be set prior to plotting code for shiny to know
    # which device to open..
    withr::with_options(
      list(shiny.useragg = TRUE), {
        output$plot_ragg <- renderPlot(do_plot())
      }
    )

    # TODO: test with and without shiny.usecairo?
    output$info1 <- renderText({
      info <- getCurrentOutputInfo()
      to_json(list(
        bg = info$bg(),
        fg = info$fg(),
        accent = info$accent(),
        font = info$font()
      ))
    })

    output$info2 <- renderText({
      info <- getCurrentOutputInfo()
      to_json(list(
        bg = info$bg(),
        fg = info$fg(),
        accent = info$accent(),
        font = info$font()
      ))
    })
  }
)
