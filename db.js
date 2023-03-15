console.log("Conexion DB")

const { Pool } = require('pg');

// Info de acceso a la db
const config = {
    user: 'postgres',
    host: 'localhost',
    port: 5432,
    password: 'HxMnBmP9qgbinY',
    database: 'inventario_proyecto'
};

// instancia y conexion de la db
const pool = new Pool(config)

module.exports = pool



// CREATE OR REPLACE FUNCTION fn_insertar_kardex()
// RETURNS TRIGGER
// LANGUAGE PLPGSQL
// AS $$
// BEGIN
	
// 	-- Logic
// 	INSERT INTO kardex 

// END;
// $$