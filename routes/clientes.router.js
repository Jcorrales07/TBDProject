const express = require('express')
const router = express.Router()


//CREATE
router.post('/registrar-cliente', (req, res) => {
    
        // No se si estos son los campos de la tabla cliente
        const campos  = req.body

        res.json({ message: 'POST /clientes', data: campos })

    
})


// READ
router.get('/', (req, res) => {

    res.json({ message: 'GET /clientes' })

})

// READ ESPECIFICO
router.get('/:idCliente', (req, res) => {
    const { idCliente } = req.params

    res.json({
        message: 'GET /clientes/:idCliente',
        idCliente
    })

})

// UPDATE ESPECIFICO
router.patch('/:idCliente', (req, res) => {
    const { idCliente } = req.params

    const body = req.body

    res.json({
        message: 'PATCH /clientes/:idCliente',
        data: body,
        idCliente

    })
})

// DELETE ESPECIFICO
router.delete('/:idCliente', (req, res) => {

        const { idCliente } = req.params

        res.json({
            message: "cliente eliminado",
            idCliente
        })


})



module.exports = router