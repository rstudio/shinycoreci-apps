function selectOption(jst, id, index) {
  jst.add(function() {
    Jster.selectize.click(id);
  });
  jst.add(Jster.shiny.waitUntilStable);
  jst.add(function() {
    Jster.selectize.clickOption(id, index);
  })
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
  // TODO: Check that line 2(?) is `dplyr::pull(!!as.symbol("cyl"))`, etc.
});

jst.test();
