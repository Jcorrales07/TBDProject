const express = require('express');
const router = express.Router();
const pool = require('../db');

// READ
router.get('/', async (req, res) => {
    const query = {
        text: `SELECT * FROM cliente`,
    };

    try {
        const dbRes = await pool.query(query);
        res.json({
            message: 'GET /clientes',
            usuarios: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// READ ESPECIFICO
router.get('/:idCliente', async (req, res) => {
    const { idCliente } = req.params;

    const query = {
        text: `SELECT * FROM fn_cliente_read(${idCliente})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'GET /clientes/:idCliente',
            cliente: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

//CREATE
router.post('/registrar-cliente', async (req, res) => {
    const { nombre, apellido, usuario_creador } = req.body;

    const query = {
        text: `CALL sp_cliente_create('${nombre}', '${apellido}', '${usuario_creador}')`,
    };

    try {
        const dbRes = await pool.query(query);

        res.json({
            message: 'POST /clientes',
            usuario: dbRes.rows,
        });
    } catch (error) {
        console.log(error);
    }
});

// UPDATE ESPECIFICO
router.patch('/:idCliente', async (req, res) => {
    const { idCliente } = req.params;

    const { nombre, apellido, usuario_modificador } = req.body;

    console.log(`'${nombre}', '${apellido}', '${usuario_modificador}'`);

    const query = {
        text: `CALL sp_cliente_update(${idCliente}, ${nombre}, '${apellido}', '${usuario_modificador}')`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'PATCH /clientes/:idCliente',
            data: req.body,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// DELETE ESPECIFICO
router.delete('/:idCliente', async (req, res) => {
    const { idCliente } = req.params;

    const query = {
        text: `CALL sp_cliente_delete(${idCliente})`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'DELETE /clientes/:idCliente',
            idCliente,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }

    res.json({
        message: 'cliente eliminado',
        idCliente,
    });
});

module.exports = router;
