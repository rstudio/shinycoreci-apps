function(input, output, session) {
  shinyjster::shinyjster_server(input, output)

  callModule(counter, "counter1")
}
