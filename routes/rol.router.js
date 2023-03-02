const express = require('express')
const router = express.Router()


//CREATE
router.post('/registrar-rol', (req, res) => {
    
        // No se si estos son los campos de la tabla rol
        const campos  = req.body

        res.json({ message: 'POST /roles', data: campos })

})


// READ
router.get('/', (req, res) => {

    res.json({ message: 'GET /roles' })

})

// READ ESPECIFICO
router.get('/:idRol', (req, res) => {
    const { idRol } = req.params

    res.json({
        message: 'GET /roles/:idRol',
        idRol
    })

})

// UPDATE ESPECIFICO
router.patch('/:idRol', (req, res) => {
    const { idRol } = req.params

    const body = req.body

    res.json({
        message: 'PATCH /roles/:idRol',
        data: body,
        idRol

    })
})

// DELETE ESPECIFICO
router.delete('/:idRol', (req, res) => {

        const { idRol } = req.params

        res.json({
            message: "rol eliminado",
            idRol
        })


})



module.exports = router