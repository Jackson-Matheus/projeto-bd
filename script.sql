CREATE DATABASE IF NOT EXISTS projetoBD;

USE projetoBD;
-- tb -> tabela
CREATE TABLE tb_usuario(
    
    nome VARCHAR(200) NOT NULL,
    telefone VARCHAR(12),
    email VARCHAR(50),

    PRIMARY KEY (nome),
    
);

CREATE TABLE tb_produto(
    
    id_produto VARCHAR(5), 
    id_fornecedor VARCHAR(5)  ,
    nome_produto VARCHAR(30),
    preco DECIMAL(3, 2),

    quantidade VARCHAR(5) ,
    descricao VARCHAR(100)

    PRIMARY KEY (id_produto, id_produto, nome)
);

CREATE TABLE tb_fornecedor(

    nome VARCHAR(200) NOT NULL,
    telefone VARCHAR(12),
    email VARCHAR(50),
    
    id_local VARCHAR(5), 
    id_produto VARCHAR(5),
    id_fornecedor VARCHAR(5),





);

CREATE TABLE tb_localizacao(
    id_local VARCHAR(5), 
    id_fornecedor VARCHAR(5) ,
    localizacao VARCHAR(100) 
);