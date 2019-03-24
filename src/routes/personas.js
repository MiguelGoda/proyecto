const express = require("express");
const router = express.Router();

const pool = require("../database");

// router.get("/add", async (req, res) => {
//   const direcciones = await pool.query("select * from persona;");
//   res.render("personas/add", { direcciones });
// });

router.get("/", async (req, res) => {
  const personal = await pool.query("SELECT * FROM persona;");
  res.render("personas/list", { personal });
});

module.exports = router;
