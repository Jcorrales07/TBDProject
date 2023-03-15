const express = require('express');
const router = express.Router();
const pool = require('../db');

// READ
router.get('/', async (req, res) => {
    const query = {
        text: `SELECT * FROM ajuste`,
    };

    try {
        const allAjustes = await pool.query(query);
        res.json(allAjustes.rows);
    } catch (error) {
        console.error(error);
    }
});

// READ ESPECIFICO
router.get('/:idAjuste', async (req, res) => {
    const { idAjuste } = req.params;

    const query = {
        text: `SELECT * FROM fn_ajuste_read(${idAjuste})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'GET /ajustes/:idAjuste',
            idAjuste: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

//CREATE
router.post('/registrar-ajuste', async (req, res) => {
    // No se si estos son los campos de la tabla ajuste
    const { comentario, usuario_creador } = req.body;

    const query = {
        text: `CALL sp_ajuste_create('${comentario}', '${usuario_creador}')`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'POST /ajustes',
            ajuste: dbRes.rows,
        });
    } catch (error) {
        console.log(error);
    }
});

// UPDATE ESPECIFICO
router.patch('/:idAjuste', async (req, res) => {
    const { idAjuste } = req.params;

    const { comentario, usuario_modifico } = req.body;

    console.log(`${idAjuste}, '${comentario}', '${usuario_modifico}'`);

    const query = {
        text: `CALL sp_ajuste_update(${idAjuste}, '${comentario}', '${usuario_modifico}')`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'PATCH /ajustes/:idAjuste',
            data: req.body,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// DELETE ESPECIFICO
router.delete('/:idAjuste', async (req, res) => {
    const { idAjuste } = req.params;

    const query = {
        text: `CALL sp_ajuste_delete(${idAjuste})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'DELETE /ajustes/:idAjuste',
            data: idAjuste,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

module.exports = router;
