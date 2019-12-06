var express = require('express');
var mysql = require('../bd/data-base-connection/index');

var router = require('./routes/index');

var app = express();


app.use('/', router);



app.listen(3000, function () {
    console.log('Example app listening on port 3000!');
});


  