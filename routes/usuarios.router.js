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
        text: `SELECT * FROM usuario WHERE nombre_usuario = '${idUsuario}'`,
    }

    try {
        
        let dbRes = await pool.query(query)
        res.json(dbRes.rows)

    } catch (error) {
        
    }

})

// crear usuario
router.post('/crear-usuario', async (req, res) => {

    const { id_usuario, nombre, apellido, email, nombre_usuario } = req.body

    const query = {
        text: `INSERT INTO usuario(id_usuario, nombre, apellido, email, nombre_usuario)
                    VALUES($1, $2, $3, $4, $5)`,
        values: [id_usuario, nombre, apellido, email, nombre_usuario]
    }

    try {   

        const nuevoUsuario = await pool.query(query);

        res.json(nuevoUsuario.rows)

    } catch (error) {

        console.log('Uno de los campos esta repetido compa')
    
    }

})


module.exports = router;