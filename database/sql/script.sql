CREATE DATABASE final;
USE final;

CREATE TABLE user(
id_user INT(4) NOT NULL AUTO_INCREMENT,
nome_user VARCHAR(30) NOT NULL,
email_user VARCHAR(30) NOT NULL,
senha_user VARCHAR(20) NOT NULL,
telefone VARCHAR(11),
nome_loja VARCHAR(30),
PRIMARY KEY (id_user, nome_user)
);


CREATE TABLE produto(
id_produto INT(4) NOT NULL AUTO_INCREMENT,
id_user INT(4),
nome_produto VARCHAR(30) NOT NULL,
preco NUMERIC(4,2) NOT NULL,
descricao VARCHAR(150),
quantidade VARCHAR(4) NOT NULL,
PRIMARY KEY (id_produto, preco, id_user),
CONSTRAINT fk_pro FOREIGN KEY (id_user) references user(id_user)
);


CREATE TABLE pedido(
id_pedido INT(4) NOT NULL AUTO_INCREMENT,
id_produto INT(4),
id_comprador INT(4),
id_vendedor INT(4),
localidade VARCHAR(15) NOT NULL,
hora_entrega TIME,
data_entrega DATE,
observacao VARCHAR(75),
troco DECIMAL(4,2),
pedido_aprovado INT(1),
PRIMARY KEY (id_pedido, id_produto, id_comprador, id_vendedor, pedido_aprovado)
);



CREATE TABLE compra(
id_compra INT(4) NOT NULL AUTO_INCREMENT,
id_comprador INT(4),
id_produto INT(4),
id_vendedor INT(4),
id_pedido INT(4),
PRIMARY KEY(id_compra)
);


CREATE TABLE venda(
id_venda INT(4) NOT NULL AUTO_INCREMENT,
id_vendedor INT(4),
id_produto INT(4),
id_comprador INT(4),
id_pedido INT(4),
PRIMARY KEY(id_venda)
);


ALTER TABLE pedido ADD CONSTRAINT fk_produt FOREIGN KEY (id_produto) references produto(id_produto);
ALTER TABLE pedido ADD CONSTRAINT fk_vended FOREIGN KEY (id_vendedor) references user(id_user);
ALTER TABLE pedido ADD CONSTRAINT fk_comprad FOREIGN KEY (id_comprador) references user(id_user);


ALTER TABLE compra ADD CONSTRAINT fk_ped FOREIGN KEY (id_pedido) references pedido(id_pedido);
ALTER TABLE compra ADD CONSTRAINT fk_comprador FOREIGN KEY (id_comprador) references pedido(id_comprador);
ALTER TABLE compra ADD CONSTRAINT fk_produtoCompra FOREIGN KEY (id_produto) references pedido(id_produto);


ALTER TABLE venda ADD CONSTRAINT fk_pedi FOREIGN KEY (id_pedido) references pedido(id_pedido);
ALTER TABLE venda ADD CONSTRAINT fk_vendedor FOREIGN KEY (id_vendedor) references pedido(id_vendedor);
ALTER TABLE venda ADD CONSTRAINT fk_produtoVenda FOREIGN KEY (id_produto) references produto(id_produto);




INSERT INTO user(id_user,nome_user,email_user,senha_user,telefone,nome_loja)
VALUES
(NULL,'Reinan','reinan@gmail.com', 'rei123', NULL, NULL),
(NULL,'Messi','messi@gmail.com', 'messi10', 92981664422, 'messi10'),
(NULL,'Cristiano','cris@hotmail.com', 'camisarosa', NULL, 'CrisCris'),
(NULL,'LeBron','bronJames@gmail.com', 'kingjames1', 92993221876, NULL),
(NULL,'Senna','sennabrasil@outlook.com', 'brasil00', NULL, NULL),
(NULL,'Marta','marta10@gmail.com', 'rainhamarta', 92991443212, 'Marta10'),
(NULL,'Falcão','falcaorei@gmail.com', 'falcao12', 92981213644, NULL),
(NULL,'Ronaldinho','ronaldo@hotmail.com', 'barca1', NULL, 'Melhor do Mundo'),
(NULL,'Neymar','ney@gmail.com', 'caicai10', 92993554321, 'PSG'),
(NULL,'Tite','tite@gmail.com', 'tite', NULL, NULL);


INSERT INTO produto(id_produto,id_user,nome_produto,preco,quantidade,descricao)
VALUES
(NULL,2,'Brigadeiro de morango',2.5, 15,'Brigadeiro delicioso'),
(NULL,5,'Brigadeiro comum',2.0, 20, NULL),
(NULL,9,'Brownie', 3.0 , 10, 'Melhor brownie de Manaus'),
(NULL,1,'Brownie com leite',3.5, 2, 'Novo sabor de brownie'),
(NULL,2,'Brigadeiro pequeno',1.0, 5, NULL),
(NULL,2,'Pirulito',0.5, 12, 'Pirulito da melhor qualidade'),
(NULL,4,'Chiclete',0.25, 7, NULL),
(NULL,1,'Brownie',2.5, 0, 'Brownie barato'),
(NULL,3,'Brigadeiro gigante',3.0, 30, 'Brigadeiro grande'),
(NULL,10,'Salgado',2.0, 2, 'Salgado com massa de macaxeira'),
(NULL, 3, 'Chiclete Babaloo', 0.1, 10, 'O melhor chiclete da ufam'),
  (NULL, 1, 'Chiclete de carinha ', 1.0, 10, 'Muito bom'),
(NULL, 5, 'Chiclete preto', 0.1, 10, 'O maior chiclete da ufam'),
  (NULL, 2, 'Chiclete azul', 1.5, 10, NULL);



INSERT INTO pedido(id_pedido,id_produto,id_comprador, id_vendedor,localidade, hora_entrega, data_entrega, observacao, troco, pedido_aprovado)
VALUES
(NULL, 2, 1, 2, 'FT', '12:10:01', '2019-12-12', NULL,1.0, 0 ),
(NULL, 13, 1, 3, 'ice', '2:10:01', '2019-12-12', 'blusa branca',2.0, 0 ),
(NULL, 1, 7, 4, 'icomp', '00:10:01', '2019-12-12','calça' ,1.0, 0),
(NULL, 4, 9, 7, 'mini', '17:10:01', '2019-12-12', 'short branco',20.0, 0 ),
(NULL, 9, 2, 1, 'feff', '23:10:01', '2019-12-12', 'perto do campo',0.0, 0 ),
(NULL, 8, 5, 4, 'R.U', '11:10:01', '2019-12-12', NULL,1.0, 0),
(NULL, 4, 1, 5, 'lab 1', '9:10:01', '2019-12-12', 'primerio pc',1.0, 0),
(NULL, 1, 2, 8, 'FT', '5:10:01', '2019-12-12', NULL,1.0, 0 ),
(NULL, 10, 9, 9, 'ICOMP', '3:10:01', '2019-12-12', NULL,1.0, 0 );

