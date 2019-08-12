const express = require("express");
const router = express.Router();

const pool = require("../database");

router.get("/", async (req, res) =>{
    const biometrico = await pool.query(
"select id_biometrico, (select concat(p.nombres, ' ', p.ap_paterno, ' ', p.ap_materno) as nombre_completo FROM contrataciones t LEFT JOIN personas p ON t.id_persona = p.id_persona where PIN = 55 limit 1) as nombre, fecha, hora, observacion from biometrico where PIN = 55;"
    );
    res.render("biometrico/list", {biometrico})
})





module.exports = router;