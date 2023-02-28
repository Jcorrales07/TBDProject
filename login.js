import client from "./conexionDB.js"

const insertUser = async (name, secondName, email, username) => {
    console.log('insert')


    const query = {
        text: `INSERT INTO usuario(nombre, apellido, email, username)
                    VALUES($1, $2, $3, $4)`,
        values: [name, secondName, email, username]
    }
    
    try {
        
        await client.query(query)

    } catch (error) {

        console.log(error.stack)

    } finally {
    }

    // client.connect()
    // client.query(query, (err, res) => {
    //     if(err) throw err

    //     console.log('rows:', res.rows)
    //     client.end()
    // })
    
}

const getUsers = async () => {
    console.log('select')

    const query = {
        text: `SELECT * FROM usuario`
    }


    try {
        
        let res = await client.query(query)

        console.log(res.rows)

    } catch (error) {
    
        console.log(error.stack)

    } finally {

    }

    // client.query(query, (err, res) => {
    //     if(err) throw err

    //     console.log(res.rows)
    //     client.end()
    // })
        
}

client.connect()
// insertUser('Lucy', 'Rodas', 'lucy.rodas@unitec.edu', 'lucyr')
// insertUser('Ian', 'Corrales', 'iancorrales05@gmail.com', 'ianskrrt')
getUsers();