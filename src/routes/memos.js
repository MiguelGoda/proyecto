const express = require("express");
const router = express.Router();

const pool = require("../database");

router.get("/add", async (req, res) => {
  const tipo_memos = await pool.query(
    "select id_tipo_memo as tipo_memo_id_tipo_memo, tipo_memo from tipo_memo; "
  );
  const persona = await pool.query(
    "select id_persona as persona_id_persona, ap_paterno, ap_materno, nombres from persona;"
  );

  console.log(tipo_memos);
  console.log(persona);

  res.render("memos/add", { tipo_memos, persona });
});

// router.post("/add", async (req, res) => {
//     const {tipo_memo_id_tipo_memo, nro_memo, descripcion_memo, fecha_memo, }
// })

module.exports = router;
