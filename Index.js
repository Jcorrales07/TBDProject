const express = require('express')
const routerApi = require('./routes/index')

const app = express();

const cors = require('cors');

// db conexion
const pool = require('./db');


//middleware
app.use(cors())
app.use(express.json()) //req.body




// home
app.get('/', async (req, res) => {
    try {
        res.json({message: 'Welcome to the API'})
    } catch (error) {
        console.error(error)
    }
})

routerApi(app);

app.listen(5000, () => {
    console.log('Server has started on port 5000')
})