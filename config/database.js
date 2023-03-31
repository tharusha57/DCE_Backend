require('dotenv').config()
const mysql = require('mysql')

const db = mysql.createConnection({
    host: process.env.host,
    user: process.env.user,
    password: process.env.password,
    database: process.env.database,
    debug: true,
    wait_timeout: 28800,
    connect_timeout: 10
})

module.exports = db