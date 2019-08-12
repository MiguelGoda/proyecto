const express = require("express");
const router = express.Router();

const pool = require("../database");

router.get("/add", (req, res) => {
    res.render("contrataciones/add");
  });

router.get("/", async (req, res) => {
    const contrataciones = await pool.query(
        "SELECT t.PIN, t.contrato, t.fecha_ingreso, t.fecha_retiro, t.motivo_retiro, t.activo, concat(p.nombres, ' ', p.ap_paterno, ' ', p.ap_materno) as nombre_completo, t.id_persona, r.id_requisito, n.nombre_nivel, c.nombre_cargo, h.nombre_horario FROM contrataciones t LEFT JOIN personas p ON t.id_persona = p.id_persona LEFT JOIN requisitos r ON r.id_persona = t.id_persona LEFT JOIN niveles n ON n.id_nivel = t.id_nivel LEFT JOIN cargos c on t.id_cargo = c.id_cargo LEFT JOIN horarios h ON h.id_horario = t.id_horario;"
    );
    res.render("contrataciones/list", { contrataciones });
  })

module.exports = router;


