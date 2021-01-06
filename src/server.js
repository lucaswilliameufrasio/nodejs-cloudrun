const express = require("express");
const randomEmoji = require("random-unicode-emoji");

const app = express();

app.get("/status", (req, res) => {
  res.status(200).json({ message: "ok" });
});

app.get("/", (req, res) => {
  const emojis = randomEmoji.random({ count: 10 });

  res.send(emojis.join(""));
});

const port = process.env.PORT || 8080;
app.listen(port, () => {
  console.log("Node API listening on port", port);
});
