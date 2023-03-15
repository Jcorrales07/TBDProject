const express = require('express');
const router = express.Router();
const pool = require('../db');

const { sp_usuario_read } = require('../controllers/usuarios.controller');

// conseguir todos los usuarios
router.get('/', async (req, res) => {
    const query = {
        text: `SELECT * FROM usuario`,
    };

    try {
        const dbRes = await pool.query(query);
        res.json({
            message: 'GET /usuarios',
            usuarios: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// conseguir un usuario por id
router.get('/:username', async (req, res) => {
    const { username } = req.params;

    // const query = {
    //     text: `SELECT * FROM fn_usuario_read('${username}')`,
    //     // text: `
    //     // BEGIN;
    //     //     CALL sp_usuario_read('${username}', 'result');
    //     //     FETCH ALL IN "result";
    //     // END;
    //     // `,
    //     // text: `SELECT * FROM usuario WHERE username = $1`,
    //     // values: [username],
    // };

    const query = {
        text: `SELECT * FROM fn_usuario_read('${username}')`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'GET /usuarios/:username',
            usuario: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

// crear usuario
router.post('/registrarse', async (req, res) => {
    const { username, nombre, apellido, email, clave, usuario_creador } =
        req.body;

    const query = {
        text: `CALL sp_usuario_create('${username}', '${nombre}', '${apellido}', '${email}', '${clave}', '${usuario_creador}')`,
    };

    try {
        const dbRes = await pool.query(query);

        res.json({
            message: 'POST /usuarios',
            usuario: dbRes.rows,
        });
    } catch (error) {
        console.log(error);
    }
});

router.patch('/:username', async (req, res) => {
    const { username } = req.params;

    const { nombre, apellido, email, clave, usuario_modificador } = req.body;

    console.log(
        `'${username}', '${nombre}', '${apellido}', '${email}', '${clave}', '${usuario_modificador}'`
    );

    const query = {
        text: `CALL sp_usuario_update('${username}', '${nombre}', '${apellido}', '${email}', '${clave}', '${usuario_modificador}')`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'PATCH /usuarios/:username',
            data: req.body,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

router.delete('/:username', async (req, res) => {
    const { username } = req.params;

    const query = {
        text: `CALL sp_usuario_delete('${username}')`,
    };

    try {
        let dbRes = await pool.query(query);

        res.json({
            message: 'DELETE /usuarios/:username',
            username,
            db: dbRes.rows,
        });
    } catch (error) {
        console.error(error);
    }
});

module.exports = router;
