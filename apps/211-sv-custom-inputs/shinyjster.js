function checkForMessage(selector, message) {
  let el = document.querySelector(selector);
  if (!el) {
    return false;
  } else {
    return el.innerText === message;
  }
}

function runAndCheck(jst, run, check) {
  jst.add(run);
  jst.add(Jster.shiny.waitUntilStable);
  jst.add(Jster.shiny.waitUntilIdleFor(500));
  jst.add(check);
}

var jst = jster();
jst.add(Jster.shiny.waitUntilStable);

jst.add(() => {
  Jster.assert.isTrue(!checkForMessage("#selfie > span.feedback-message",
    "Click the 'Take photo' button before submitting"));
});

runAndCheck(jst,
  () => { Jster.button.click("submit"); },
  () => {
    Jster.assert.isTrue(checkForMessage("#selfie > span.feedback-message",
      "Click the 'Take photo' button before submitting"));
  }
);

runAndCheck(jst,
  () => { Jster.radio.clickOption("type", "upload"); },
  () => {
    Jster.assert.isTrue(checkForMessage(".form-group > span.help-block.shiny-validation-message",
      "Please choose a file"));
  }
);

runAndCheck(jst,
  () => { Jster.radio.clickOption("type", "gravatar"); },
  () => {
    Jster.assert.isTrue(checkForMessage(".form-group > span.help-block.shiny-validation-message",
      "Required"));
  }
);

runAndCheck(jst,
  () => { Jster.input.setValue("email", "hello"); },
  () => {
    Jster.assert.isTrue(checkForMessage(".form-group > span.help-block.shiny-validation-message",
      "Not a valid email address"));
  }
);

runAndCheck(jst,
  () => { Jster.input.setValue("email", "joe@example.com"); },
  () => {
    Jster.assert.isTrue(!document.querySelector(".shiny-validation-message"));
  }
);

jst.test();
