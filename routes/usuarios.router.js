const express = require('express')
const pool = require('../db')

const router = express.Router()



// LOGIN
// GET : conseguir un usuario en especifico
// POST : crear un usuario
// UPDATE : actualizar un usuario
// DELETE : eliminar un usuario

// Pagina de bienvenida y pues funciones generales


// conseguir todos los usuarios
router.get('/', async (req, res) => {
    const query = {
        text: `SELECT * FROM usuario`
    }
    
    try {


        const allUsuarios = await pool.query(query)
        res.json(allUsuarios.rows)

    } catch (error) {
        console.error(error)
    }
})

// conseguir un usuario por id
router.get('/:idUsuario', async (req, res) => {

    const { idUsuario } = req.params

    const query = {
        text: `SELECT * FROM usuario WHERE username = '${idUsuario}'`,
    }

    try {
        
        let dbRes = await pool.query(query)
        res.json(dbRes.rows)

    } catch (error) {
        
    }

})

// crear usuario
router.post('/crear-usuario', async (req, res) => {

    const { username, nombre, apellido, email, clave } = req.body

    const query = {
        text: `INSERT INTO usuario(username, nombre, apellido, email, clave)
                    VALUES($1, $2, $3, $4)`,
        values: [username, nombre, apellido, email, clave]
    }

    try {   

        const nuevoUsuario = await pool.query(query);

        res.json(nuevoUsuario.rows)

    } catch (error) {

        console.log('Uno de los campos esta repetido compa')
    
    }

})


router.patch('/:username', async (req, res) => {
    const { username } = req.params
    const body = req.body

    res.json({
        message: 'Usuario actualizado',
        data: body,
        username
    })

})

router.delete('/:username', async (req, res) => {
    const { username } = req.params
    const body = req.body

    res.json({
        message: 'Usuario eliminado',
        username
    })

})


module.exports = router;