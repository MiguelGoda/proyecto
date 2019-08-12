const express = require("express");
const router = express.Router();

const pool = require("../database")

router.get("/", async (req,res) =>{
    const formacion_academica = await pool.query("SELECT * FROM formacion_academica")
});

module.exports = router;
