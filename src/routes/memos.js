const express = require("express");
const router = express.Router();

const pool = require("../database");

router.get("/add", async (req, res) => {
  const tipo_memos = await pool.query(
    "select id_tipo_memo as tipo_memo_id_tipo_memo, tipo_memo from tipo_memo; "
  );
  const persona = await pool.query(
    "select id_persona as persona_id_persona, concat(nombres, ' ', ap_paterno, ' ', ap_materno) as nombre_completo from persona;"
  );
  res.render("memos/add", { tipo_memos, persona });
});

router.post("/add", async (req, res) => {
  const {
    nro_memo,
    descripcion_memo,
    fecha_memo,
    tipo_memo_id_tipo_memo,
    persona_id_persona
  } = req.body;
  const newMemo = {
    nro_memo,
    descripcion_memo,
    fecha_memo,
    tipo_memo_id_tipo_memo,
    persona_id_persona
  };
  await pool.query("INSERT INTO memos set ?", [newMemo]);
  req.flash("success", "El Memo se adiciono correctamente");
  res.redirect("/memos");
});

router.get("/", async (req, res) => {
  const memos = await pool.query(
    "SELECT M.id_memos, M.nro_memo, M.descripcion_memo, M.fecha_memo, T.tipo_memo, CONCAT(P.nombres, ' ', P.ap_paterno, ' ', P.ap_materno) as nombre_completo FROM memos M LEFT JOIN persona P ON (M.persona_id_persona = P.id_persona) LEFT JOIN tipo_memo T ON (T.id_tipo_memo = M.tipo_memo_id_tipo_memo);"
  );
  res.render("memos/list", { memos });
});

module.exports = router;
