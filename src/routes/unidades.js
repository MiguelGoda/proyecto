const express = require("express");
const router = express.Router();

const pool = require("../database");

router.get("/add", async (req, res) => {
  const direcciones = await pool.query(
    "select id_direccion as direccion_id_direccion, nombre_direccion from direccion;"
  );
  res.render("unidades/add", { direcciones });
});

router.post("/add", async (req, res) => {
  const { direccion_id_direccion, nombre_unidad, descripcion } = req.body;
  const newUnidad = {
    nombre_unidad,
    descripcion,
    direccion_id_direccion
  };
  await pool.query("INSERT INTO unidad SET ?", [newUnidad]);
  req.flash("success", "La Unidad se adicciono correctamente");
  res.redirect("/unidades");
});

router.get("/", async (req, res) => {
  const unidades = await pool.query(
    "SELECT direccion_id_direccion as direccion_id_direccion, direccion.nombre_direccion,unidad.id_unidad , unidad.nombre_unidad, unidad.descripcion FROM direccion RIGHT JOIN unidad ON direccion.id_direccion = unidad.direccion_id_direccion ;"
  );
  res.render("unidades/list", { unidades });
});

router.get("/delete/:id", async (req, res) => {
  const { id } = req.params;
  await pool.query("DELETE FROM unidad WHERE id_unidad = ?", [id]);
  req.flash("success", "Unidad eliminada correctamente");
  res.redirect("/unidades");
});

router.get("/edit/:id", async (req, res) => {
  const { id } = req.params;
  const unidades = await pool.query(
    "SELECT direccion_id_direccion as id_direccion, direccion.nombre_direccion,unidad.id_unidad , unidad.nombre_unidad, unidad.descripcion FROM direccion RIGHT JOIN unidad ON direccion.id_direccion = unidad.direccion_id_direccion WHERE id_unidad = ?",
    [id]
  );
  console.log(unidades);
  res.render("unidades/edit", { unidades: unidades[0] });
});

module.exports = router;
