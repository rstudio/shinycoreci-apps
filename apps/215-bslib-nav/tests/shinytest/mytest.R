app <- ShinyDriver$new("../../")
app$snapshotInit("mytest")

app$executeScript('$(".nav [data-value=b]").tab("show")')
app$waitFor('var b = $(".tab-pane[data-value=b]"); var bv = b.find(":visible"); b.length == bv.length > 0')
app$snapshot()

app$executeScript('$(".nav [data-value=c]").tab("show")')
app$waitFor('var c = $(".tab-pane[data-value=c]"); var cv = c.find(":visible"); c.length == cv.length > 0')
app$snapshot()
