const mysql = require('mysql');

var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'geforce2020',
    database: 'final',
});

connection.connect((err) => {
    if (err)   console.log("CONNECTION FAILED");   
    else console.log("CONNECTED WITH DATABASE");
});

module.exports = connection;
