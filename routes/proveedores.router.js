const express = require('express')
const router = express.Router()


//CREATE
router.post('/registrar-proveedor', (req, res) => {
    
        // No se si estos son los campos de la tabla proveedor
        const { id_proveedor, nombre, apellido, email, nombre_usuario } = req.body

        res.json({ message: 'POST /proveedores' })

    
})


// READ
router.get('/', (req, res) => {

    res.json({ message: 'GET /proveedores' })

})

// READ ESPECIFICO
router.get('/:idProveedor', (req, res) => {
    const { idProveedor } = req.params

    res.json({
        message: 'GET /proveedores/:idProveedor',
        idProveedor
    })

})

// UPDATE ESPECIFICO
router.patch('/:idProveedor', (req, res) => {
    const { idProveedor } = req.params

    const body = req.body

    res.json({
        message: 'PATCH /proveedores/:idProveedor',
        data: body,
        idProveedor

    })
})

// DELETE ESPECIFICO
router.delete('/:idProveedor', (req, res) => {

        const { idProveedor } = req.params
        const body = req.body

        res.json({
            message: "Proveedor eliminado",
            idProveedor
        })


})



module.exports = router