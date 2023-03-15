const express = require('express');
const router = express.Router();
const pool = require('../db');

// READ
router.get('/', async (req, res) => {
    const query = {
        text: `SELECT * FROM compras`,
    };

    try {
        const dbRes = await pool.query(query);
        res.json({
            message: 'GET /compras',
            compras: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// READ ESPECIFICO
router.get('/:idCompra', async (req, res) => {
    const { idCompra } = req.params;

    const query = {
        text: `SELECT * FROM fn_compra_read(${idCompra})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'GET /compras/:idCompra',
            compra: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

//CREATE
router.post('/registrar-compra', async (req, res) => {
    // No se si estos son los campos de la tabla compra
    const { idProveedor, usuario_creador, sp_total } =
        req.body;

    const query = {
        text: `CALL sp_compra_create(${idProveedor}, '${usuario_creador}', '${sp_total}')`,
    };

    try {
        const dbRes = await pool.query(query);

        res.json({
            message: 'POST /compras',
            compra: dbRes.rows,
        });
    } catch (error) {
        console.log(error);
    }
});

// UPDATE ESPECIFICO
router.patch('/:idCompra', async (req, res) => {
    const { idCompra } = req.params;

    const { sp_total, usuario_modificador } = req.body;

    console.log(
        `'${sp_total}', '${usuario_modificador}'`
    );

    const query = {
        text: `CALL sp_compra_update(${idCompra},  '${sp_total}', '${usuario_modificador}')`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'PATCH /compras/:idCompra',
            data: req.body,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// DELETE ESPECIFICO
router.delete('/:idCompra', async (req, res) => {
    const { idCompra } = req.params;

    const query = {
        text: `CALL sp_compra_delete(${idCompra})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'DELETE /compras/:idCompra',
            idCompra,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

module.exports = router;
