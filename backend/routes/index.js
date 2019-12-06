var express = require('express');
var mysql = require('../../bd/data-base-connection/index');

var router = express.Router();

router.use(function timeLog(req, res, next) {
  console.log('Time: ', Date.now());
});

router.get('/', function(req, res) {
  res.send('HOME');
});
router.get('/about', function(req, res) {
  res.send('About');
});

module.exports = router;
