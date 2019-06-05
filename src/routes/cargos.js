const express = require("express");
const router = express.Router();

const pool = require("../database");

router.get("/add", async (req, res) => {
  const unidades = await pool.query(
    "select id_unidad, nombre_unidad from unidades; "
  );
  res.render("cargos/add", { unidades });
});

router.post("/add", async (req, res) => {
  const { id_unidad, nombre_cargo, descripcion } = req.body;
  const newCargo = {
    id_unidad,
    nombre_cargo,
    descripcion
  };
  await pool.query("INSERT INTO cargos SET ?", [newCargo]);
  req.flash("success", "El cargo se adicciono correctamente");
  res.redirect("/cargos");
});

router.get("/", async (req, res) => {
  const unidades = await pool.query(
    "select id_unidad, nombre_unidad from unidades;"
  );
  const cargos = await pool.query(
    " SELECT cargos.id_unidad, unidades.nombre_unidad ,cargos.id_cargo , cargos.nombre_cargo, cargos.descripcion FROM cargos left JOIN unidades ON   unidades.id_unidad = cargos.id_unidad ; "
  );
  res.render("cargos/list", { cargos, unidades });
});

router.get("/delete/:id", async (req, res) => {
  const { id } = req.params;
  await pool.query("DELETE FROM cargos WHERE id_cargo = ?", [id]);
  req.flash("success", "Cargo eliminado correctamente");
  res.redirect("/cargos");
});

router.get("/edit/:id", async (req, res) => {
  const { id } = req.params;
  const unidades = await pool.query(
    "select id_unidad, nombre_unidad from unidades"
  );
  const cargos = await pool.query(
    "SELECT cargos.id_unidad, unidades.nombre_unidad ,cargos.id_cargo , cargos.nombre_cargo, cargos.descripcion FROM cargos left JOIN unidades ON   unidades.id_unidad = cargos.id_unidad WHERE id_cargo = ?",
    [id]
  );
  res.render("cargos/edit", { cargos: cargos[0], unidades });
});

router.post("/edit/:id", async (req, res) => {
  const { id } = req.params;
  const { id_unidad, nombre_cargo, descripcion } = req.body;
  const newCargo = {
    id_unidad,
    nombre_cargo,
    descripcion
  };
  await pool.query("UPDATE cargos SET ? WHERE id_cargo = ?", [newCargo, id]);
  req.flash("success", "El cargo se edito correctamente");
  res.redirect("/cargos");
});

module.exports = router;
