const express = require("express");
const router = express.Router();
const moment = require("handlebars.moment");
const pool = require("../database");

router.get("/add", async (req, res) => {
  res.render("personas/add");
});

router.post("/add", async (req, res) => {
  const {
    ap_paterno,
    ap_materno,
    nombres,
    fecha_nacimiento,
    provincia,
    departamento,
    CI,
    celular,
    estado_civil,
    domicilio,
    sexo
  } = req.body;
  const newPersona = {
    ap_paterno,
    ap_materno,
    nombres,
    fecha_nacimiento,
    provincia,
    departamento,
    CI,
    celular,
    estado_civil,
    domicilio,
    sexo
  };
  console.log(newPersona);

  await pool.query("INSERT INTO persona SET ?", [newPersona]);
  res.redirect("/personas");
});

router.get("/", async (req, res) => {
  const personal = await pool.query("SELECT * FROM persona;");
  res.render("personas/list", { personal });
});

module.exports = router;
