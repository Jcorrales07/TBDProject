const express = require('express');
const router = express.Router();
const pool = require('../db');

// READ
router.get('/', async (req, res) => {
    const query = {
        text: `SELECT * FROM factura`,
    };

    try {
        const dbRes = await pool.query(query);
        res.json({
            message: 'GET /facturas',
            facturas: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// READ ESPECIFICO
router.get('/:idFactura', async (req, res) => {
    const { idFactura } = req.params;

    // const query = {
    //     text: `SELECT * FROM fn_factura_read('${idFactura}')`,
    //     // text: `
    //     // BEGIN;
    //     //     CALL sp_factura_read('${idFactura}', 'result');
    //     //     FETCH ALL IN "result";
    //     // END;
    //     // `,
    //     // text: `SELECT * FROM factura WHERE idFactura = $1`,
    //     // values: [idFactura],
    // };

    const query = {
        text: `SELECT * FROM fn_factura_read(${idFactura})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'GET /facturas/:idFactura',
            factura: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

//CREATE
router.post('/registrar-factura', async (req, res) => {
    const { usuario_creador, subtotal, porcentaje_descuento } = req.body;

    const query = {
        text: `CALL sp_factura_create('${usuario_creador}', ${subtotal}, ${porcentaje_descuento})`,
    };

    try {
        const dbRes = await pool.query(query);

        res.json({
            message: 'POST /facturas',
            factura: dbRes.rows,
        });
    } catch (error) {
        console.log(error);
    }
});

// UPDATE ESPECIFICO
router.patch('/:idFactura', async (req, res) => {
    const { idFactura } = req.params;

    const { subtotal, porcentaje_descuento, usuario_modificador } = req.body;

    console.log(
        `${idFactura}, ${subtotal} ${porcentaje_descuento}, '${usuario_modificador}'`
    );

    const query = {
        text: `CALL sp_factura_update(${idFactura}, ${subtotal}, ${porcentaje_descuento}, '${usuario_modificador}')`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'PATCH /facturas/:idFactura',
            data: req.body,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// DELETE ESPECIFICO
router.delete('/:idFactura', async (req, res) => {
    const { idFactura } = req.params;

    const query = {
        text: `CALL sp_factura_delete(${idFactura})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'DELETE /facturas/:idFactura',
            idFactura,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

module.exports = router;
