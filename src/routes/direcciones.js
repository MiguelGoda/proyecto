const express = require("express");
const router = express.Router();

const pool = require("../database");

// router.get("/add", (req, res) => {
//   res.render("direcciones/add");
// });

router.post("/", async (req, res) => {
  const { nombre_direccion, descripcion_direccion } = req.body;
  const newDireccion = {
    nombre_direccion,
    descripcion_direccion
  };
  console.log(newDireccion);

  await pool.query("INSERT INTO direcciones set ?", [newDireccion]);
  req.flash("success", "La Direccion adicciono Correctamente");
  res.redirect("/direcciones");
});

router.get("/", async (req, res) => {
  const direcciones = await pool.query("SELECT * FROM direcciones");
  const bien = true;
  res.render("direcciones/list", { direcciones, bien });
});

router.get("/delete/:id", async (req, res) => {
  const { id } = req.params;
  await pool.query("DELETE FROM direcciones WHERE ID_DIRECCION = ?", [id]);
  req.flash("success", "Direccion eliminada Correctamente");
  res.redirect("/direcciones");
});

router.get("/:id", async (req, res) => {
  const { id } = req.params;
  const direcciones = await pool.query(
    "SELECT * FROM direcciones WHERE ID_DIRECCION = ?",
    [id]
  );
  res.render("direcciones/edit", { direcciones: direcciones[0] });
});

router.put("/:id", async (req, res) => {
  const { id } = req.params;
  const { nombre_direccion, descripcion_direccion } = req.body;
  const newDireccion = {
    nombre_direccion,
    descripcion_direccion
  };
  await pool.query("UPDATE direcciones set ? WHERE ID_DIRECCION = ?", [
    newDireccion,
    id
  ]);
  req.flash("success", "Direccion editada Correctamente");
  res.redirect("/");
});

module.exports = router;
