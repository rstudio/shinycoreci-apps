async function verifyPOST() {
  const response = await fetch("post_endpoint", {method: "POST"});
  if (!response.ok) {
    throw new Error(`${response.status}: ${response.statusText}`);
  }

  const str = await response.text();
  if (str !== "All good!") {
    throw new Error(`Unexpected response value: "${str}"`);
  }
  return true;
}
