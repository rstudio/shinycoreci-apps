function selectOption(jst, id, index) {
  jst.add(function() {
    Jster.selectize.click(id);
  });
  jst.add(Jster.shiny.waitUntilStable);
  jst.add(function() {
    Jster.selectize.clickOption(id, index);
  });
}

var jst = jster();
jst.add(Jster.shiny.waitUntilStable);

selectOption(jst, "x-col", 1);
selectOption(jst, "y-col", 2);
jst.add(Jster.shiny.waitUntilStable);
jst.add(function() {
  var btn = $("button");
  if (btn.length !== 1) {
    throw new Error("One and only one button was expected, found " + btn.length);
  }
  btn.click();
});
jst.add(Jster.shiny.waitUntilStable);
jst.add(function() {
  var lines = $(".shiny-ace").data("aceEditor").session.doc.getAllLines();
  Jster.assert.isEqual(
    lines.join(" \n "),
    "dataset <- mtcars \n x_values <- dataset %>% \n   dplyr::pull(!!as.symbol(\"cyl\")) \n y_values <- dataset %>% \n   dplyr::pull(!!as.symbol(\"disp\")) \n # Combine x and y into data frame for plotting \n df_plot <- data.frame(x = x_values, y = y_values) \n plot(df_plot) \n x_avg <- x_values %>% \n   mean() %>% \n   round(1) \n paste(\"Average of\", \"cyl\", \"is\", x_avg) \n y_avg <- y_values %>% \n   mean() %>% \n   round(1) \n paste(\"Average of\", \"disp\", \"is\", y_avg)"
  );
});

jst.test();
