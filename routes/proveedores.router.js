const express = require('express');
const router = express.Router();
const pool = require('../db');

// READ
router.get('/', async (req, res) => {
    const query = {
        text: `SELECT * FROM proveedor`,
    };

    try {
        const dbRes = await pool.query(query);
        res.json({
            message: 'GET /proveedor',
            proveedores: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// READ ESPECIFICO
router.get('/:idProveedor', async (req, res) => {
    const { idProveedor } = req.params;

    const query = {
        text: `SELECT * FROM fn_proveedor_read(${idProveedor})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'GET /proveedores/:idProveedor',
            proveedor: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

//CREATE
router.post('/registrar-proveedor', async (req, res) => {
    // No se si estos son los campos de la tabla proveedor
    const {
        nombre,
        dirrecion,
        telefono,
        nombre_contacto_principal,
        usuario_creador,
    } = req.body;

    const query = {
        text: `CALL sp_proveedor_create('${nombre}', '${dirrecion}', '${telefono}', '${nombre_contacto_principal}', '${usuario_creador})`,
    };

    try {
        const dbRes = await pool.query(query);

        res.json({
            message: 'POST /proveedores',
            proveedor: dbRes.rows,
        });
    } catch (error) {
        console.log(error);
    }
});

// UPDATE ESPECIFICO
router.patch('/:idProveedor', async (req, res) => {
    const { idProveedor } = req.params;

    const {
        nombre,
        dirrecion,
        telefono,
        nombre_contacto_principal,
        estado,
        usuario_modificador,
    } = req.body;

    console.log(
        `${idProveedor}, '${nombre}', '${dirrecion}', '${telefono}', '${nombre_contacto_principal}', ${estado}, '${usuario_modificador}'`
    );

    const query = {
        text: `CALL sp_proveedor_update(${idProveedor}, '${nombre}', '${dirrecion}', '${telefono}', '${nombre_contacto_principal}', ${estado}, '${usuario_modificador}')`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'PATCH /proveedores/:idProveedor',
            data: req.body,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// DELETE ESPECIFICO
router.delete('/:idProveedor', async (req, res) => {
    const { idProveedor } = req.params;

    const query = {
        text: `CALL sp_proveedor_delete(${idProveedor})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'DELETE /proveedores/:idProveedor',
            idProveedor,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

module.exports = router;
