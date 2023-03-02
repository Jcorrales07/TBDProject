const express = require('express')
const router = express.Router()


//CREATE
router.post('/registrar-kardex', (req, res) => {
    
        // No se si estos son los campos de la tabla kardex
        const campos  = req.body

        res.json({ message: 'POST /kardexs', data: campos })

    
})


// READ
router.get('/', (req, res) => {

    res.json({ message: 'GET /kardexs' })

})

// READ ESPECIFICO
router.get('/:idKardex', (req, res) => {
    const { idKardex } = req.params

    res.json({
        message: 'GET /kardexs/:idKardex',
        idKardex
    })

})

// UPDATE ESPECIFICO
router.patch('/:idKardex', (req, res) => {
    const { idKardex } = req.params

    const body = req.body

    res.json({
        message: 'PATCH /kardexs/:idKardex',
        data: body,
        idKardex

    })
})

// DELETE ESPECIFICO
router.delete('/:idKardex', (req, res) => {

        const { idKardex } = req.params

        res.json({
            message: "kardex eliminado",
            idKardex
        })


})



module.exports = router