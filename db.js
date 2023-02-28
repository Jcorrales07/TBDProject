console.log("Conexion DB")

const { Pool } = require('pg');

// Info de acceso a la db
const config = {
    user: 'postgres',
    host: 'localhost',
    port: 5432,
    password: 'HxMnBmP9qgbinY',
    database: 'proyecto_inventario'
};

// instancia y conexion de la db
const pool = new Pool(config)

module.exports = pool