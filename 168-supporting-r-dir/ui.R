fluidPage(
  HTML("<p>Demonstrates that <code>.R</code> files in the <code>R/<code> directory are automatically loaded at runtime.</p>

<p>At the moment, this functionality is opt-in so this app requires setting the following option in order to work:</p>

<pre>
options(shiny.autoload.r = TRUE)
</pre>

<p>Without setting that option, the example will fail.</p>

<p>Requires Shiny with the change in <a href='https://github.com/rstudio/shiny/pull/2547'>https://github.com/rstudio/shiny/pull/2547</a>. This requires Shiny v1.3.2.9001.</p>"),

  counterButton("counter1", "Counter #1")
)
