const express = require('express')
const router = express.Router()


//CREATE
router.post('/registrar-compra', (req, res) => {
    
        // No se si estos son los campos de la tabla compra
        const campos  = req.body

        res.json({ message: 'POST /compras', data: campos })

    
})


// READ
router.get('/', (req, res) => {

    res.json({ message: 'GET /compras' })

})

// READ ESPECIFICO
router.get('/:idCompra', (req, res) => {
    const { idCompra } = req.params

    res.json({
        message: 'GET /compras/:idCompra',
        idCompra
    })

})

// UPDATE ESPECIFICO
router.patch('/:idCompra', (req, res) => {
    const { idCompra } = req.params

    const body = req.body

    res.json({
        message: 'PATCH /compras/:idCompra',
        data: body,
        idCompra

    })
})

// DELETE ESPECIFICO
router.delete('/:idCompra', (req, res) => {

        const { idCompra } = req.params

        res.json({
            message: "compra eliminado",
            idCompra
        })


})



module.exports = router