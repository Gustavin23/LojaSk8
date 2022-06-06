/**
	Lojinha
    @author Gustavo Rene
    @version 1.2
*/

create database lojask8;
use lojask8;

-- Criando Usuários
create table usuarios (
	idusu int primary key auto_increment,
    usuario varchar(50) not null,
    login varchar(50) not null unique, 
    senha varchar(255) not null,
    perfil varchar(50) not null
);
describe usuarios;

insert into usuarios(usuario,login,senha,perfil)
values ('Administrador','admin',md5('admin'),'admin');

insert into usuarios(usuario,login,senha,perfil)
values ('Rene','rene',md5('123456'),'user');

select * from usuarios; 

select * from usuarios where login='admin' and senha=md5('admin');
select * from usuarios where login='rene' and senha=md5('123456');

-- Criando a tabela de Fornecedores
create table fornecedores(
	idfor int primary key auto_increment,
    cnpj varchar(14) unique not null,
    ie varchar(14) unique,
    im varchar(14) unique,
    razao varchar(255) not null,
    fantasia varchar(255) not null,
    site varchar(255),
    fone varchar(20) not null,
    contato varchar(50),
    email varchar(50), 
    cep varchar(8) not null,
    endereco varchar(150) not null,
    numero varchar(10) not null,
    complemento varchar(150),
    bairro varchar(150) not null,
    cidade varchar(150) not null,
    uf varchar(2) not null
);

insert into fornecedores(cnpj, ie, im, razao, fantasia, site, fone, contato, email, cep, endereco, numero, bairro, cidade, uf) 
values(43216554305843, '12343214368765', '12343214368765', 'Element Propaganda Comunicação e Design Ltda', 'Element','www.elementbrand.com.br', 1136188600, 'Ricardo','sac@elementbrand.com', 12922670, 'Rua Argemiro Rocha de Moraes', 322, 'Bragança Paulista', 'São Paulo', 'SP');

insert into fornecedores(cnpj, ie, im, razao, fantasia, site, fone, contato, email, cep, endereco, numero, bairro, cidade, uf) 
values(20799526000190, '54325342565427', '51453453416341', 'SDS COMPANY ARTIGOS ESPORTIVOS E VESTUARIO LTDA', 'Skate Dos Sonhos','www.skatedosonhos.com.br', 1145694329, 'Jefferson','sac@sdsonhos.com', 02405000, 'Rua Augusto Tolle', 538, 'Santanta', 'São Paulo', 'SP');

select * from fornecedores;

-- Criando a tabela produtos
create table produtos(
	id int primary key auto_increment,
    barcode varchar(13), -- codigo de barras
    produto varchar(100) not null,
    descricao varchar(100) not null,
    fabricante varchar(100) not null,
    datacad timestamp default current_timestamp, -- data de cadastro
    dataval date, -- data de validade
    setor varchar(50) not null,
    estoque int not null,
    estoquemin int not null,
    unidade varchar(50) not null,
    localizacao varchar(150),
	custo decimal(10,2) not null,
    lucro decimal(10,2),
    venda decimal(10,2),
    idfor int not null,
    foreign key(idfor) references fornecedores(idfor)
);

insert into produtos(barcode, produto, descricao,fabricante,dataval,setor,estoque,estoquemin,unidade,localizacao,custo,lucro,venda,idfor)
values 
('1010101010','Rolamento','Rolamento Bones','Bones',20210110,'Rolamento',50,20,'UN','SkateShop',90,50,135,1);

insert into produtos(barcode, produto, descricao,fabricante,dataval,setor,estoque,estoquemin,unidade,localizacao,custo,lucro,venda,idfor)
values 
('9090909090','Rolamento','Rolamento Spitfire','Spitfire',20220310,'Rolamento',5,10,'UN','SkateShop',90,100,180,2);

insert into produtos(barcode, produto, descricao,fabricante,dataval,setor,estoque,estoquemin,unidade,localizacao,custo,lucro,venda,idfor)
values 
('6060606060','Bucha de borracha','Bucha de truck','Brasa',20210703,'Borracha',30,20,'UN','SkateShop',10,20,12,1);

insert into produtos(barcode, produto, descricao,fabricante,dataval,setor,estoque,estoquemin,unidade,localizacao,custo,lucro,venda,idfor)
values 
('8080808080','Roda','Roda Bones','Bones','Não Obrigatório','Rodas',2,10,'UN','SkateShop',150,100,300,2);

insert into produtos(barcode, produto, descricao,fabricante,dataval,setor,estoque,estoquemin,unidade,localizacao,custo,lucro,venda,idfor)
values 
('7070707070','Shape Maple','Shape de madeira de Maple','Primitive','Não Obrigatório','Shape',4,10,'UN','SkateShop',120,50,180,1);

describe produtos;
select * from produtos;

-- Relatório de Vencimento 
select id as código, produto,
date_format(dataval,'%d/%m/%Y') as data_validade,
datediff(dataval,curdate()) as dias_restantes
from produtos;

-- Relatório de Reposição
select id as código, produto,
date_format(dataval,'%d/%m/%Y') as data_validade,
estoque, estoquemin as estoque_minímo
from produtos where estoque < estoquemin;

-- Criando Tabela de Clientes
create table clientes (
	idcli int primary key auto_increment,
    nome varchar(50) not null,
	fone varchar(10) not null,
    datanasc date not null,
    cpf varchar(11) unique,
    email varchar(50),
    marketing varchar(3) not null,
    cep varchar(8),
    endereco varchar(150),
    numero varchar(10),
    complemento varchar(150),
    bairro varchar(150),
    cidade varchar(150),
    uf char(2)
);

insert into clientes(nome, fone, datanasc, cpf, email, marketing, cep, endereco, numero, complemento, bairro, cidade, uf)
values('Gustavo',20030702,20030702,23451363690,'gustavin@gmail.com', 'N', 04125643, 'Rua dos guimarães', 432, 'casa', 'Vila Mariana', 'São Paulo', 'SP');

insert into clientes(nome, fone, datanasc, cpf, email, marketing, cep, endereco, numero, complemento, bairro, cidade, uf)
values('Jefferson',20030612,20030913,23147854315,'jefferson@gmail.com', 'S', 43125431, 'Rua Itapura ', 1302, 'casa', 'Tatuape', 'São Paulo', 'SP');

select email from clientes where marketing=('S');

-- Criando uma tabela de pedidos
create table pedidos (
		pedido int primary key auto_increment,
        dataped timestamp default current_timestamp,
        total decimal(10,2),
        idcli int not null,
        foreign key(idcli) references clientes(idcli)
);

insert into pedidos(idcli) values(1);
insert into pedidos(idcli) values(2);

-- Relatório com os pedidos
select 
pedidos.pedido as Pedido, 
date_format(pedidos.dataped, '%d/%m/%Y - %H:%i') as Data_Pedido,
clientes.nome as Cliente,
clientes.fone as Telefone
from pedidos inner join clientes
on pedidos.idcli = clientes.idcli;

-- Criando Carrinho
create table carrinho(
	pedido int not null,
    id int not null,
    quantidade int not null,
    foreign key(pedido) references pedidos(pedido),
    foreign key(id) references produtos(id)
);

insert into carrinho values (1,1,2);
insert into carrinho values (2,1,4);
insert into carrinho values (1,2,2);

-- Exibir o Carrinho 
select pedidos.pedido as Pedido,
carrinho.id as Código,
produtos.produto as Produto,
carrinho.quantidade as Quantidade,
produtos.venda as Venda,
produtos.venda * carrinho.quantidade as SubTotal
from(carrinho inner join pedidos on carrinho.pedido = pedidos.pedido)
inner join produtos on carrinho.id = produtos.id;

-- Total do pedido(carrinho) Fechamento
select sum(produtos.venda * carrinho.quantidade) as Total
from carrinho inner join produtos on carrinho.id = produtos.id;

-- Atualização do estoque
update carrinho
inner join produtos
on carrinho.id = produtos.id
set produtos.estoque = produtos.estoque - carrinho.quantidade
where carrinho.quantidade > 0;

select * from produtos;