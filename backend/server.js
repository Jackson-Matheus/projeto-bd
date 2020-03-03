const connection = require('./db/index');
const express = require('express');
var session = require("express-session");
var body = require('body-parser')
var expressLayouts = require('express-ejs-layouts')

const port = 9001;
const app = express();


app.use(session({
  secret: 'secret',
  resave: true,
  saveUninitialized: true
}));

app.set('view engine', 'ejs')
app.use(expressLayouts)
app.use(body.urlencoded())
app.use(express.static(__dirname + '/public'))


app.get('/', (req, res) => {
  res.render('pages/login');
});

app.get('/register', (req, res) => {
  res.render('pages/register');
});

app.post('/register', (req, res) => {
  var username = req.body.username;
  var password = req.body.password;
  var email = req.body.email;
  var phone = req.body.telefone;
  var sql = `INSERT INTO user(nome_user, email_user, senha_user, telefone)
  VALUES("${username}", "${email}" , "${password}", "${phone}");`;
  connection.query(sql, function (error, results, fields) {
    if (error) console.log(error);
    res.redirect('/')
  });
});


app.post('/auth', async (req, res) => {
  var email = req.body.email;
  var password = req.body.password;
  if (email && password) {
  await connection.query('SELECT * FROM user WHERE email_user = ? AND senha_user = ?;',
    [email, password], function (err, results, fields) {
      if (results.length > 0) {
        req.session.user = results[0];      
				req.session.loggedin = true;
        req.session.email_user = email;
        res.redirect('/profile')

      }
      else {
        res.send('SENHA OU EMAIL INCORRETOS');
      }
    });
  } else {
		res.send('ENTRE COM EMAIL E SENHA');
		res.end();
	}
});

app.get('/profile', (req, res) => {
  var user_ = req.session.user;
  res.render('pages/profile', { data: user_ });
});


app.get('/store', async (req, res) => {
  const id_user = req.session.user.id_user;
  sql = `SELECT * FROM produto WHERE id_user = ${id_user} `
  await connection.query(sql, function (error, results, fields) {
    if (error) console.log(error);
    else res.render('pages/store', { product: results });
  });
  console.log(sql);
});

app.post('/product', (req, res) => {
  var id_usuario = req.session.user.id_user;
  var nome = req.body.name;
  var price = req.body.price;
  var description = req.body.description;
  var amount = req.body.amount;
  
  var sql = `INSERT INTO produto (id_user, nome_produto, preco, descricao, quantidade)
    VALUES("${id_usuario}", "${nome}", "${price}", "${description}","${amount}");`;
  connection.query(sql, function (error) {
    if (error) console.log(error);
    else res.redirect('/store')

  });

})

app.route('/store/:id')
  .get((req, res) => {
    var id = req.params.id;
    console.log(id);
    var sql = `SELECT * FROM produto WHERE id_produto = ${id}`;
    connection.query(sql, (err, results, fields) => {
      if (err)console.log(err);
      else res.render('pages/edit-product', {data: results});
    });  
  })
  .post((req, res) => {
    var id_produto = req.params.id;
    var nome = req.body.name;
    var price = req.body.price;
    var description = req.body.description;
    var amount = req.body.amount;
    var category = req.body.category;
    var sql = `UPDATE produto SET   
      nome_produto = "${nome}", preco_produto ="${price}",
      categoria_produto="${category}", descricao_produto="${description}", quantidade_produto ="${amount}"
      wHERE id_produto = ${id_produto};`;
    connection.query(sql, (err, results, fields) => {
      if (err)console.log(err);
      else res.redirect('/store');
    }); 
  })

//todos os produtos
app.get('/shopping', (req, res) => {
  var sql = `SELECT id_user, nome_user, id_produto, preco , nome_produto, 
    preco,quantidade, descricao from produto natural join user`;
  
  connection.query(sql, function (error, results, fields) {
    if (error) {
      console.log(error)
    };
    res.render('pages/shopping', { product: results });
  });
});

app.post('/order', (req, res) => {
  var id_usuario = req.session.user.id_user;
  var id_produto = req.body.id;
  var local = req.body.location;
  var date = req.body.date;
  
  console.log(date);
  var abc = req.body.hour;
  var hour = abc.toString();
  
  var change = req.body.change;
  var observartion = req.body.observation;
  var sql = `INSERT INTO pedido
      VALUES(NULL, ${id_produto},  ${id_usuario}, (SELECT id_user FROM produto WHERE id_produto=${id_produto}) , "${local}", "${hour}", "${date}",
      "${observartion}",${change}, 0);`    
   connection.query(sql, function (error, results, fields) {
    if (error) {
      console.log(error)
    };
    res.redirect('/shopping');
  });

  
  
});
app.get('/order', (req, res) => {
  var id = req.session.user.id_user;
  sql = `SELECT * FROM pedido WHERE id_comprador= "${id}";`;  
  connection.query(sql, function (error, results) {
    if (error) {
      console.log(error);
    }
    res.render('pages/orders', {data: results} );
  })
});


app.get('/order-to-approve/:id', (req, res) => {
  var id  = req.params.id;
  var sql = `SELECT * FROM pedido WHERE id_vendedor = "${id}" and pedido_aprovado = 0;`;

  connection.query(sql, function (err, results, fields){
    if(err) console.log(err);
    else res.render('pages/orders-to-approve', {data: results});
  });
});

///orders-to-approve
app.route('/orders-to-approve/:id/:flag')
  .get((req, res) => {
    var id = req.params.id;
     var sql = `SELECT * FROM pedido  WHERE id_pedido=${id};`     
     
    connection.query(sql,  (err, result) => { 
      if(err) console.log(err);
      res.render('pages/accept-or-reject', {data : result});  
    })   
  })
  .post((req, res) => {
    var id = req.params.id;
    var flag = req.params.flag;
    var id_ = req.session.user.id_user;
    console.log(id);
    
    var a = `UPDATE pedido SET pedido_aprovado = ${flag}  WHERE id_pedido = ${id};`;
 
    connection.query(a  , (err) => {
      if(err)console.log(err);
    })
    var b = `UPDATE produto SET quantidade = quantidade-1   WHERE id_produto = ${id};`;
    connection.query(b, (err) => {
      if(err)console.log(err);
    }) 

    var c = `INSERT  INTO venda SELECT null, id_vendedor, id_produto, id_comprador, id_pedido FROM pedido WHERE id_pedido = ${id}`;
    connection.query(c, (err) => {
      if(err)console.log(err);
    }) 

    var c = `INSERT INTO compra SELECT null, id_vendedor, id_produto, id_comprador, id_pedido FROM pedido WHERE id_pedido = ${id}`;
    connection.query(c, (err) => {
      if(err)console.log(err);
    }) 
  
    res.redirect(`/order-to-approve/${id}`);         
  }) 




//compras
app.get('/historic', (req, res) => {
  var id = req.session.user.id_user;
  var sql = ` SELECT distinct user.nome_user, produto.nome_produto, pedido.localidade, pedido.data_entrega  FROM venda, pedido, user, produto WHERE venda.id_comprador = ${id} and
  pedido.id_pedido = venda.id_pedido ;`;

  connection.query(sql, (err,results) => {
    if(err) console.log(err);
    else res.render('pages/historic', {data: results});
  });
});





//vendas
app.get('/sales', (req, res) => {
  var id = req.session.user.id_user;
  var sql = `SELECT distinct user.nome_user, produto.nome_produto, pedido.localidade, pedido.data_entrega 
    FROM venda, pedido, user, produto WHERE venda.id_vendedor = ${id} and
    pedido.id_pedido = venda.id_pedido;`

  connection.query(sql, (err,results) => {
    if(err) console.log(err);
    else res.render('pages/sales', {data: results});
  });
});


app.get('/consulta', (req, res) => {
  var id = req.session.user.id_user;
  var sql = `SELECT user.nome_user, nome_produto, preco FROM produto, user  WHERE nome_produto like 'Brigadeiro%' order by preco desc limit 1;`

  connection.query(sql, (err,results) => {
    if(err) console.log(err);
    else res.render('pages/consulta', {data: results});
  });

});


app.get('/logout', (req, res) => {
  res.redirect('/');
});


app.listen(port, () => {
  console.log('Example app listening on port : ' + port);
});


