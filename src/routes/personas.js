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
  await pool.query("INSERT INTO personas SET ?", [newPersona]);
  req.flash("success", "La persona se adicciono correctamente");
  res.redirect("/personas");
});

router.get("/", async (req, res) => {
  const personal = await pool.query("SELECT * FROM personas;");
  res.render("personas/list", { personal });
});

router.get("/delete/:id", async (req, res) => {
  const { id } = req.params;
  await pool.query("DELETE FROM personas WHERE id_persona = ?", [id]);
  req.flash("success", "Persona eliminada correctamente");
  res.redirect("/personas");
});

router.get("/edit/:id", async (req, res) => {
  const { id } = req.params;
  const personas = await pool.query(
    "SELECT * FROM personas WHERE id_persona = ?",
    [id]
  );
  res.render("personas/edit", { personas: personas[0] });
});

router.post("/edit/:id", async (req, res) => {
  const { id } = req.params;
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

  await pool.query("UPDATE personas SET ? WHERE id_persona = ?", [
    newPersona,
    id
  ]);
  req.flash("success", "Persona editada Correctamente");
  res.redirect("/personas");
});

module.exports = router;
