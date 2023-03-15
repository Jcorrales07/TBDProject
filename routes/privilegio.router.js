const express = require('express');
const router = express.Router();
const pool = require('../db');

// READ
router.get('/', async (req, res) => {
    const query = {
        text: `SELECT * FROM privilegio`,
    };

    try {
        const dbRes = await pool.query(query);
        res.json({
            message: 'GET /privilegios',
            privilegios: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// READ ESPECIFICO
router.get('/:idPrivilegio', async (req, res) => {
    const { idPrivilegio } = req.params;

    const query = {
        text: `SELECT * FROM fn_privilegio_read(${idPrivilegio})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'GET /privilegios/:idPrivilegio',
            privilegio: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// CREATE
router.post('/registrar-privilegio', async (req, res) => {
    // No se si estos son los campos de la tabla privilegio
    const { nombre, usuario_creador  } = req.body;

    const query = {
        text: `CALL sp_privilegio_create('${nombre}', '${usuario_creador}')`,
    };

    try {
        const dbRes = await pool.query(query);

        res.json({
            message: 'POST /privilegios',
            privilegio: dbRes.rows,
        });
    } catch (error) {
        console.log(error);
    }
});

// UPDATE ESPECIFICO
router.patch('/:idPrivilegio', async (req, res) => {
    const { idPrivilegio } = req.params;

    const { nombre, usuario_modificador } = req.body;

    console.log(
        `${idPrivilegio}, '${nombre}', '${usuario_modificador}'`
    );

    const query = {
        text: `CALL sp_privilegio_update(${idPrivilegio}, '${nombre}', '${usuario_modificador}')`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'PATCH /privilegios/:idPrivilegio',
            data: req.body,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// DELETE ESPECIFICO
router.delete('/:idPrivilegio', async (req, res) => {
    const { idPrivilegio } = req.params;

    const query = {
        text: `CALL sp_privilegio_delete(${idPrivilegio})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'DELETE /privilegios/:idPrivilegio',
            idPrivilegio,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

module.exports = router;
