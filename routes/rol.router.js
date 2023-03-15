const express = require('express');
const router = express.Router();
const pool = require('../db');

// READ
router.get('/', async (req, res) => {
   const query = {
        text: `SELECT * FROM rol`,
    };

    try {
        const dbRes = await pool.query(query);
        res.json({
            message: 'GET /roles',
            roles: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// READ ESPECIFICO
router.get('/:idRol', async (req, res) => {
    const { idRol } = req.params;

    const query = {
        text: `SELECT * FROM fn_rol_read(${idRol})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'GET /roles/:idRol',
            role: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

//CREATE
router.post('/registrar-rol', async (req, res) => {
    // No se si estos son los campos de la tabla rol
    const { nombre, usuario_creador} =
        req.body;

    const query = {
        text: `CALL sp_rol_create('${nombre}', '${usuario_creador}')`,
    };

    try {
        const dbRes = await pool.query(query);

        res.json({
            message: 'POST /roles',
            role: dbRes.rows,
        });
    } catch (error) {
        console.log(error);
    }
});

// UPDATE ESPECIFICO
router.patch('/:idRol', async (req, res) => {
    const { idRol } = req.params;

    const { nombre, usuario_modificador } = req.body;

    console.log(
        `${idRol}, '${nombre}', '${usuario_modificador}'`
    );

    const query = {
        text: `CALL sp_role_update(${idRol}, '${nombre}', '${usuario_modificador}')`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'PATCH /roles/:idRol',
            data: req.body,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// DELETE ESPECIFICO
router.delete('/:idRol', async (req, res) => {
   const { idRol } = req.params;

    const query = {
        text: `CALL sp_role_delete(${idRol})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'DELETE /roles/:idRol',
            idRol,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

module.exports = router;
