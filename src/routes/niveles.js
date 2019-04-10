const express = require("express");
const router = express.Router();

const pool = require("../database");

router.get("/add", async (req, res) => {
  res.render("niveles/add");
});

router.post("/add", async (req, res) => {
  const { nombre_nivel, haber_basico } = req.body;
  const newNivel = {
    nombre_nivel,
    haber_basico
  };
  await pool.query("INSERT INTO niveles set ?", [newNivel]);
  req.flash("success", "El Nivel se adicciono Correctamente");
  res.redirect("/niveles");
});

router.get("/", async (req, res) => {
  const niveles = await pool.query("SELECT * FROM niveles");
  res.render("niveles/list", { niveles });
});

router.get("/delete/:id", async (req, res) => {
  const { id } = req.params;
  await pool.query("DELETE FROM niveles WHERE id_niveles = ?", [id]);
  req.flash("success", "El nivel fue eliminado correctamente");
  res.redirect("/niveles");
});

module.exports = router;
