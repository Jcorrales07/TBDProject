const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const routerApi = require('./routes/index');

const app = express();

const corsOptions = {
    origin: 'http://localhost:5000',
}


// db conexion
const pool = require('./db');

//middleware
app.use(cors(corsOptions));
app.use(express.json()); //req.body
// parse requests of content-type - application/json
app.use(bodyParser.json()); 
// parse requests of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

// home
app.get('/', async (req, res) => {
    try {
        res.json({ message: 'Welcome to the API' });
    } catch (error) {
        console.error(error);
    }
});

routerApi(app);

app.listen(5000, () => {
    console.log('Server has started on port 5000');
});
