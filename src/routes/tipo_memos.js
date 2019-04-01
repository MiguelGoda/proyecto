const express = require("express");
const router = express.Router();

const pool = require("../database");

router.get("/add", (req, res) => {
  res.render("tipo_memos/add");
});

router.post("/add", async (req, res) => {
  const { tipo_memo, descripcion } = req.body;
  const newTipoMemo = {
    tipo_memo,
    descripcion
  };
  await pool.query("INSERT INTO tipo_memo set ?", [newTipoMemo]);
  req.flash("success", "El tipo memo se adicciono correctamente");
  res.redirect("/tipo_memos");
});

router.get("/", async (req, res) => {
  const tipo_memo = await pool.query("SELECT * FROM tipo_memo");
  res.render("tipo_memos/list", { tipo_memo });
});

router.get("/delete/:id", async (req, res) => {
  const { id } = req.params;
  await pool.query("DELETE FROM tipo_memo WHERE ID_TIPO_MEMO = ?", [id]);
  req.flash("success", "Tipo Memo eliminado correctamente");
  res.redirect("/tipo_memos");
});

router.get("/edit/:id", async (req, res) => {
  const { id } = req.params;
  const tipo_memos = await pool.query(
    " SELECT * FROM tipo_memo WHERE ID_TIPO_MEMO = ?",
    [id]
  );
  res.render("tipo_memos/edit", { tipo_memos: tipo_memos[0] });
});

router.post("/edit/:id", async (req, res) => {
  const { id } = req.params;
  const { tipo_memo, descripcion } = req.body;
  const newTipoMemo = { tipo_memo, descripcion };
  await pool.query("UPDATE tipo_memo SET ? WHERE ID_TIPO_MEMO = ? ", [
    newTipoMemo,
    id
  ]);
  req.flash("success", "Tipo Memo editado correctamente");
  res.redirect("/tipo_memos");
});

router.get("/delete/:id", async (req, res) => {
  const { id } = rq.params;
  await pool.query("DELETE FROM tipo_memo WHERE ID_TIPO_MEMO = ?", [id]);
  req.flash("success", "Tipo Memo eliminado Correctamente");
  res.redirect("/tipo_memo");
});

module.exports = router;
