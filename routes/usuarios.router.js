const express = require('express');
const pool = require('../db');

const router = express.Router();

const { sp_usuario_read } = require('../controllers/usuarios.controller');

// LOGIN
// GET : conseguir un usuario en especifico
// POST : crear un usuario
// UPDATE : actualizar un usuario
// DELETE : eliminar un usuario

// Pagina de bienvenida y pues funciones generales

// conseguir todos los usuarios
router.get('/', async (req, res) => {
    const query = {
        text: `SELECT * FROM usuario`,
    };

    try {
        const allUsuarios = await pool.query(query);
        res.json(allUsuarios.rows);
    } catch (error) {
        console.error(error);
    }
});

// conseguir un usuario por id
router.get('/:username', async (req, res) => {
    const { username } = req.params;

    
    const result = 'result'
    console.log(`username: '${username}' y result: '${result}'`);        
    const query = {
        text: `SELECT * FROM sp_usuario_read('${username}')`,
            // text: `
            // BEGIN;
            //     CALL sp_usuario_read('${username}', 'result');
            //     FETCH ALL IN "result";
            // END;    
            // `,
            // text: `SELECT * FROM usuario WHERE username = $1`,
            // values: [username],
    };

    try {
        
        let dbRes = await pool.query(query)
        res.json(dbRes.rows);

    } catch (error) {}

});

// crear usuario
router.post('/registrarse', async (req, res) => {
    const { username, nombre, apellido, email, clave, usuario_creador } = req.body;

    const query = {
        text: `CALL sp_usuario_create('${username}', '${nombre}', '${apellido}', '${email}', '${clave}', ${usuario_creador})`,
    };

    try {
        const nuevoUsuario = await pool.query(query);

        res.json(nuevoUsuario.rows);
    } catch (error) {
        console.log('Uno de los campos esta repetido compa');
    }
});

router.patch('/:username', async (req, res) => {
    const { username, nombre, apellido, email, clave, usuario_modificador } = req.params;
    const body = req.body;

    res.json({
        message: 'Usuario actualizado',
        data: body,
        username,
    });
});

router.delete('/:username', async (req, res) => {
    const { username } = req.params;
    const body = req.body;

    const query = {
        text: `CALL sp_usuario_delete('${username}')`,
    };

    try {

        let dbRes = await pool.query(query)

    } catch (error) {}

    res.json({
        message: 'Usuario eliminado',
        username,
    });
});

module.exports = router;
