app <- ShinyDriver$new("../../", seed = 100, shinyOptions = list(display.mode = "normal"))
app$snapshotInit("mytest")

a_dist <- app$waitForValue("a_distPlot", iotype = "output")
b_dist <- app$waitForValue("b_distPlot", iotype = "output")
app$snapshot()


app$setInputs(a_recalc = "click")
app$setInputs(a_monthly_withdrawals = 68000)
app$setInputs(b_recalc = "click")
app$setInputs(b_recalc = "click")
app$setInputs(b_annual_ret_std_dev = 12.3)
app$setInputs(b_annual_ret_std_dev = 16.8)
app$setInputs(b_n_sim = 1070)

app$waitForValue("a_distPlot", ignore = list(NULL, a_dist), iotype = "output")
app$waitForValue("b_distPlot", ignore = list(NULL, b_dist), iotype = "output")
app$snapshot()
