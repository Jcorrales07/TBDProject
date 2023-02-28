const express = require('express')

const router = express.Router()


// Conseguir todos los productos
router.get('/', async (req, res) => {
    try {
        res.json({message: 'Listado de productos'})
    } catch (error) {
        console.error(error)
    }
})

// Conseguir un producto en especifico
router.get('/:idProducto', async (req, res) => {

    const {idProducto} = req.params

    try {

        res.json({
            idProducto,
            nombreProducto: 'Producto especifico',
            precio: 1000
        })


    } catch(error) {

    }

}) 


//Crear un producto
router.post('/crear-producto', async (req, res) => {

    try {
        res.json({message: 'Producto creado'})
    } catch (error) {
        console.error(error)
    }

})

module.exports = router;