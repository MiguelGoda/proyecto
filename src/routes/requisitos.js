const express = require("express");
const router = express.Router();

const pool = require("../database");

router.get("/add", async (req, res) => {
  const personas = await pool.query(
    "SELECT id_persona AS persona_id_persona, CONCAT(nombres, ' ', ap_paterno, ' ', ap_materno) AS nombre_completo FROM persona "
  );
  res.render("requisitos/add", { personas });
});

router.post("/add", async (req, res) => {
  const {
    curriculum,
    declaracion_jurada,
    fecha_declaracion,
    incompatibilidad,
    certificado_antecedentes,
    libreta_militar,
    patron_biometrico,
    seguro_salud,
    sippase,
    afp,
    idioma_nativo,
    persona_id_persona
  } = req.body;
  console.log(req.body);
  const newRequisito = {
    curriculum,
    declaracion_jurada,
    fecha_declaracion,
    incompatibilidad,
    certificado_antecedentes,
    libreta_militar,
    patron_biometrico,
    seguro_salud,
    sippase,
    afp,
    idioma_nativo,
    persona_id_persona
  };
  await pool.query("INSERT INTO requisitos SET ?", [newRequisito]);
  res.redirect("/requisitos");
});

router.get("/", async (req, res) => {
  const requisitos = await pool.query(
    "SELECT curriculum, declaracion_jurada, fecha_declaracion, incompatibilidad,  certificado_antecedentes,libreta_militar,  patron_biometrico,  seguro_salud,  sippase,  afp,  idioma_nativo,  concat(nombres, ' ', ap_paterno, ' ', ap_materno) as nombre_completo, id_persona AS persona_id_persona FROM requisitos LEFT JOIN persona on persona_id_persona = id_persona"
  );
  console.log(requisitos);
  res.render("requisitos/list", { requisitos });
});

module.exports = router;
