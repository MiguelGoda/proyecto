const express = require("express");
const router = express.Router();

const pool = require("../database");

router.get("/add", async (req, res) => {
  const direcciones = await pool.query(
    "select id_direccion as direccion_id_direccion, nombre_direccion from direcciones;"
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
    "SELECT direcciones.id_direccion as direccion_id_direccion, direcciones.nombre_direccion,unidades.id_unidad , unidades.nombre_unidad, unidades.descripcion FROM direcciones RIGHT JOIN unidades ON direcciones.id_direccion = unidades.id_direccion ;"
  );
  res.render("unidades/list", { unidades });
});

router.get("/delete/:id", async (req, res) => {
  const { id } = req.params;
  await pool.query("DELETE FROM unidades WHERE id_unidad = ?", [id]);
  req.flash("success", "Unidad eliminada correctamente");
  res.redirect("/unidades");
});

router.get("/edit/:id", async (req, res) => {
  const { id } = req.params;
  const direcciones = await pool.query(
    "select id_direccion as direccion_id_direccion, nombre_direccion from direcciones;"
  );
  const unidades = await pool.query(
    "SELECT direcciones.id_direccion as direccion_id_direccion, direcciones.nombre_direccion,unidades.id_unidad , unidades.nombre_unidad, unidades.descripcion FROM direcciones RIGHT JOIN unidades ON direcciones.id_direccion = unidades.id_direccion  WHERE id_unidad = ?",
    [id]
  );
  res.render("unidades/edit", { unidades: unidades[0], direcciones });
});

// por hacer metodo POST

module.exports = router;
