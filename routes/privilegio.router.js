const express = require('express')
const router = express.Router()


//CREATE
router.post('/registrar-privilegio', (req, res) => {
    
        // No se si estos son los campos de la tabla privilegio
        const campos  = req.body

        res.json({ message: 'POST /privilegios', data: campos })

    
})


// READ
router.get('/', (req, res) => {

    res.json({ message: 'GET /privilegios' })

})

// READ ESPECIFICO
router.get('/:idPrivilegio', (req, res) => {
    const { idPrivilegio } = req.params

    res.json({
        message: 'GET /privilegios/:idPrivilegio',
        idPrivilegio
    })

})

// UPDATE ESPECIFICO
router.patch('/:idPrivilegio', (req, res) => {
    const { idPrivilegio } = req.params

    const body = req.body

    res.json({
        message: 'PATCH /privilegios/:idPrivilegio',
        data: body,
        idPrivilegio

    })
})

// DELETE ESPECIFICO
router.delete('/:idPrivilegio', (req, res) => {

        const { idPrivilegio } = req.params

        res.json({
            message: "privilegio eliminado",
            idPrivilegio
        })


})



module.exports = router