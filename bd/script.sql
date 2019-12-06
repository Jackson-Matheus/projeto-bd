CREATE DATABASE IF NOT EXISTS projetoBD;

USE projetoBD;
-- tb -> tabela
CREATE TABLE usuario(
	id_usuario INT(4) AUTO_INCREMENT,
	nome_usuario  VARCHAR(30) not null,
	email_usuario VARCHAR(25) not null,	
	senha_usuario VARCHAR(20) not null,
	telefone_usuario VARCHAR(11),
	primary key (id_usuario)
);


CREATE TABLE produto(
	id_produto INT(4)AUTO_INCREMENT,
	nome_produto varchar(20) NOT NULL,
	preco_produto numeric(3,2) NOT NULL,
	categoria_produto varchar(15) NOT NULL,
	descricao_produto varchar(150),
	quantidade_produto varchar(4) NOT NULL,
	primary key (id_produto)
);