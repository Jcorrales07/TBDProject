const pool = require('../db');

async function sp_usuario_read(username) {
console.log('pase')
    const query = {
        text: `CALL sp_usuario_read('${username}', 'results');
                FETCH ALL IN "results";`,
        // text: `SELECT * FROM usuario WHERE username = '${username}'`,
    };

    try {
        
        let dbRes = await pool.query(query);
        res.json(dbRes.rows);

    } catch (error) {}

}


module.exports = {
    sp_usuario_read
}
