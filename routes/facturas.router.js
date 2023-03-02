const express = require('express')
const router = express.Router()


//CREATE
router.post('/registrar-factura', (req, res) => {
    
        // No se si estos son los campos de la tabla factura
        const campos  = req.body

        res.json({ message: 'POST /facturas', data: campos })

    
})


// READ
router.get('/', (req, res) => {

    res.json({ message: 'GET /facturas' })

})

// READ ESPECIFICO
router.get('/:idfactura', (req, res) => {
    const { idfactura } = req.params

    res.json({
        message: 'GET /facturas/:idfactura',
        idfactura
    })

})

// UPDATE ESPECIFICO
router.patch('/:idfactura', (req, res) => {
    const { idfactura } = req.params

    const body = req.body

    res.json({
        message: 'PATCH /facturas/:idfactura',
        data: body,
        idfactura

    })
})

// DELETE ESPECIFICO
router.delete('/:idfactura', (req, res) => {

        const { idfactura } = req.params

        res.json({
            message: "factura eliminado",
            idfactura
        })


})



module.exports = router