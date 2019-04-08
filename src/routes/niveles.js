const express = require("express");
const router = express.Router();

const pool = require("../database");

router.get("/add", async (req, res) => {
  res.render("niveles/add");
});

module.exports = router;
