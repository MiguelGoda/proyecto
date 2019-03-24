const express = require("express");
const router = express.Router();

const pool = require("../database");

router.get("/add", (req, res) => {
  res.render("direcciones/add");
});

router.post("/add", async (req, res) => {
  const { nombre_direccion, descripcion_direccion } = req.body;
  const newDireccion = {
    nombre_direccion,
    descripcion_direccion
  };
  await pool.query("INSERT INTO direccion set ?", [newDireccion]);
  req.flash("success", "La Direccion adicciono Correctamente");
  res.redirect("/direcciones");
});

router.get("/", async (req, res) => {
  const direcciones = await pool.query("SELECT * FROM direccion");
  res.render("direcciones/list", { direcciones });
});

router.get("/delete/:id", async (req, res) => {
  const { id } = req.params;
  await pool.query("DELETE FROM direccion WHERE ID_DIRECCION = ?", [id]);
  req.flash("success", "Direccion eliminada Correctamente");
  res.redirect("/direcciones");
});

router.get("/edit/:id", async (req, res) => {
  const { id } = req.params;
  const direcciones = await pool.query(
    "SELECT * FROM direccion WHERE ID_DIRECCION = ?",
    [id]
  );
  res.render("direcciones/edit", { direcciones: direcciones[0] });
});

router.post("/edit/:id", async (req, res) => {
  const { id } = req.params;
  const { nombre_direccion, descripcion_direccion } = req.body;
  const newDireccion = {
    nombre_direccion,
    descripcion_direccion
  };
  await pool.query("UPDATE direccion set ? WHERE ID_DIRECCION = ?", [
    newDireccion,
    id
  ]);
  req.flash("success", "Direccion editada Correctamente");
  res.redirect("/direcciones");
});

module.exports = router;
