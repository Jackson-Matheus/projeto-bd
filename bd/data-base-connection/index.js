var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : '',
  user     : '',
  password : ''
});

//connection.connect();

module.exports = connection;