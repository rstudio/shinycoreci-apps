library(shiny)
library(htmltools)
# Make sure Cairo and ragg are installed (but not attached)
if (FALSE) {
  library(Cairo)
  library(ragg)
}

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
  size = "10px"
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

display_in_row <- function(x, y) {
  fluidRow(column(6, x), column(6, y))
}

shinyApp(
  fluidPage(
    # gfonts::generate_css("pacifico", output = "www/pacifico.css", font_dir = "fonts/")
    tags$head(tags$link(href="pacifico.css", rel="stylesheet", type="text/css")),
    info2css(info1, "body"),
    info2css(info2, "#info2"),
    tags$h5(
      "This test is primarily for testing that getCurrentOutputInfo()",
      "returns bg+fg+accent+font styles, but also makes sure that renderPlot()",
      "and renderImage() can render custom fonts via showtext and ragg. ",
      "Here are those plot results (which use the bg/fg/font information):"
    ),
    display_in_row(
      imageOutput("image", height = 150),
      imageOutput("image_no_font", height = 150)
    ),
    display_in_row(
      plotOutput("default", height = 150),
      plotOutput("default_no_font", height = 150)
    ),
    display_in_row(
      plotOutput("ragg", height = 150),
      plotOutput("ragg_no_font", height = 150)
    ),
    display_in_row(
      plotOutput("cairo", height = 150),
      plotOutput("cairo_no_font", height = 150)
    ),
    tags$h5("And here is the raw getCurrentOutputInfo() information:"),
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

          var image_string = function(id) {
            return JSON.stringify(Jster.image.data(id));
          }

          var do_assert_diff = function(id) {
            var id2 = id + '_no_font';
            Jster.assert.isTrue(image_string(id) !== image_string(id2), {id: id, id2: id2});
          }

          do_assert_diff('image');
          do_assert_diff('default');
          do_assert_diff('ragg');
          do_assert_diff('cairo');

        });

        jst.test();", to_json(info1), to_json(info2)
      )
    )
  ),
  function(input, output, session) {
    shinyjster::shinyjster_server(input, output, session)

    do_image <- function(family = "Pacifico") {
      height <- session$clientData$output_image_height
      width <- session$clientData$output_image_width
      pixelratio <- session$clientData$pixelratio
      png("tmp.png", height = height*pixelratio, width = width*pixelratio, res = 72*pixelratio)
      do_plot(family = family)
      dev.off()
      list(src = "tmp.png", height = 150, width = "100%")
    }

    do_plot <- function(family = "Pacifico") {
      info <- getCurrentOutputInfo()
      par(bg = info$bg())
      plot(1, type = "n")
      text(1, "Here's some text generated via renderPlot()/renderImage()", family = family, col = info$fg())
    }

    output$image <- renderImage(do_image())
    output$image_no_font <- renderImage(do_image(family = ""))

    output$default <- renderPlot(do_plot())
    output$default_no_font <- renderPlot(do_plot(family = ""))

    # Option must be set prior to plotting code for shiny to know
    # which device to open...
    withr::with_options(
      list(shiny.useragg = TRUE), {
        output$ragg <- renderPlot(do_plot())
        output$ragg_no_font <- renderPlot(do_plot(family = ""))
      }
    )

    withr::with_options(
      list(shiny.useragg = FALSE, shiny.usecairo = FALSE), {
        output$cairo <- renderPlot(do_plot())
        output$cairo_no_font <- renderPlot(do_plot(family = ""))
      }
    )

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
