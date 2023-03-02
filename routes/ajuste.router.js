const express = require('express')
const router = express.Router()


//CREATE
router.post('/registrar-ajuste', (req, res) => {
    
        // No se si estos son los campos de la tabla ajuste
        const campos  = req.body

        res.json({ message: 'POST /ajustes', data: campos })

    
})


// READ
router.get('/', (req, res) => {

    res.json({ message: 'GET /ajustes' })

})

// READ ESPECIFICO
router.get('/:idAjuste', (req, res) => {
    const { idAjuste } = req.params

    res.json({
        message: 'GET /ajustes/:idAjuste',
        idAjuste
    })

})

// UPDATE ESPECIFICO
router.patch('/:idAjuste', (req, res) => {
    const { idAjuste } = req.params

    const body = req.body

    res.json({
        message: 'PATCH /ajustes/:idAjuste',
        data: body,
        idAjuste

    })
})

// DELETE ESPECIFICO
router.delete('/:idAjuste', (req, res) => {

        const { idAjuste } = req.params

        res.json({
            message: "ajuste eliminado",
            idAjuste
        })


})



module.exports = router