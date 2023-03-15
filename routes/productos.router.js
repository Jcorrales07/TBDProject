const express = require('express');
const router = express.Router();
const pool = require('../db');

// Conseguir todos los productos
router.get('/', async (req, res) => {
    const query = {
        text: `SELECT * FROM producto`,
    };

    try {
        const dbRes = await pool.query(query);
        res.json({
            message: 'GET /productos',
            productos: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// Conseguir un producto en especifico
router.get('/:idProducto', async (req, res) => {
    const { idProducto } = req.params;

    const query = {
        text: `SELECT * FROM fn_producto_read(${idProducto})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'GET /productos/:idProducto',
            producto: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

//Crear un producto
router.post('/crear-producto', async (req, res) => {
    const {
        usuario_creador,
        nombre,
        costo,
        categoria,
        marca,
        precio,
        existencia_min,
        existencia_max,
    } = req.body;

    const query = {
        text: `CALL sp_producto_create('${usuario_creador}', '${nombre}', ${costo}, '${categoria}', '${marca}', ${precio}, ${existencia_min}, ${existencia_max})`,
    };

    try {
        const dbRes = await pool.query(query);

        res.json({
            message: 'POST /productos',
            producto: dbRes.rows,
        });
    } catch (error) {
        console.log(error);
    }
});

router.patch('/:idProducto', async (req, res) => {
    const { idProducto } = req.params;

    const {
        usuario_modificador,
        nombre,
        costo,
        categoria,
        marca,
        precio,
        existencia_min,
        existencia_max,
    } = req.body;

    console.log(
        `${idProducto}, '${usuario_modificador}', '${nombre}', ${costo}, '${categoria}', '${marca}', ${precio}, ${existencia_min}, ${existencia_max}`
    );

    const query = {
        text: `CALL sp_producto_update(${idProducto}, '${usuario_modificador}', '${nombre}', ${costo}, '${categoria}', '${marca}', ${precio}, ${existencia_min}, ${existencia_max})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'PATCH /productos/:idProducto',
            data: req.body,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

router.delete('/:idProducto', async (req, res) => {
    const { idProducto } = req.params;

    const query = {
        text: `CALL sp_producto_delete(${idProducto})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'DELETE /productos/:idProducto',
            idProducto,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

module.exports = router;
