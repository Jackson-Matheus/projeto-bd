CREATE TABLE usuario(
        id_usuario INT(4) AUTO_INCREMENT,
        nome_usuario  VARCHAR(30) not null,
        email_usuario VARCHAR(25) not null,     
        senha_usuario VARCHAR(20) not null,
        telefone_usuario VARCHAR(11),
    nome_loja VARCHAR(30),
    total_de_vendas VARCHAR(4),
        primary key (id_usuario,nome_usuario,email_usuario,senha_usuario)
) ENGINE = innodb;


CREATE TABLE produto(
        id_produto INT(4)AUTO_INCREMENT,
        nome_produto varchar(30) NOT NULL,
        preco_produto numeric(3,2) NOT NULL,
        categoria_produto varchar(15) NOT NULL,
        descricao_produto varchar(150),
        quantidade_produto varchar(4) NOT NULL,
        primary key (id_produto, nome_produto, preco_produto, categoria_produto, quantidade_produto)
)ENGINE = innodb;

CREATE TABLE servico(
        id_servico INT(4)AUTO_INCREMENT,
        nome_servico varchar(30) NOT NULL,
        preco_servico numeric(5,2) NOT NULL,
        categoria_servico varchar(15) NOT NULL,
        descricao_servico varchar(150),
        prazo_servico varchar(4) NOT NULL,
        primary key (id_servico, nome_servico, preco_servico, categoria_servico, prazo_servico)
)ENGINE = innodb;

CREATE TABLE pedido(
        id_pedido INT(4) AUTO_INCREMENT,
   produto_nome VARCHAR(20) NOT NULL,
   nome_comprador VARCHAR(30) NOT NULL,
   nome_vendedor VARCHAR(30) NOT NULL,
        localidade varchar(15) not null,
        hora_entrega varchar(4) not null,
        observacao varchar(50),
   produto_preco NUMERIC(3,2) NOT NULL,
   troco numeric(3,2) NOT NULL,
        primary key (id_pedido, localidade, troco, hora_entrega),
   CONSTRAINT fk_pedir FOREIGN KEY (id_pedido,produto_nome, produto_preco) references produto(id_produto,nome_produto, preco_produto)
);

CREATE TABLE compras(
    ID_compra INT(4) AUTO_INCREMENT,
    total_compras INT(4) NULL,
    codigo_produto INT(4) NOT NULL,
    data_compra DATE,
    PRIMARY KEY (ID_compra),
    CONSTRAINT fk_comprar FOREIGN KEY (codigo_produto) references produto(id_produto)
);

CREATE TABLE vendas(
    ID_venda INT(4) AUTO_INCREMENT,
    total_vendas INT(4) NULL,
    codigo_produtoVenda INT(4) NOT NULL,
    data_venda DATE,
    PRIMARY KEY (ID_venda),
    CONSTRAINT fk_vender FOREIGN KEY (codigo_produtoVenda) references produto(id_produto)
);


insert into usuario(id_usuario, nome_usuario, email_usuario, senha_usuario,telefone_usuario, nome_loja, total_de_vendas)  
VALUES (null, 'Pedro', 'ooo@gmail.com', '1234', null, 'henriqueG', null);

insert into usuario(id_usuario, nome_usuario, email_usuario, senha_usuario,telefone_usuario, nome_loja, total_de_vendas)  
VALUES (null, 'João', 'aaaa@gmail.com', '1333', '92981887344', 'Best Cake', '1234');

insert into usuario(id_usuario, nome_usuario, email_usuario, senha_usuario,telefone_usuario, nome_loja, total_de_vendas)  
VALUES (null, 'Maria', 'qqqqq@gmail.com', '09989', null, 'TudoTem', '83');

insert into usuario(id_usuario, nome_usuario, email_usuario, senha_usuario,telefone_usuario, nome_loja, total_de_vendas)  
VALUES (null, 'Joana', 'tttt@gmail.com', '00000', null, 'Cade', 3);


