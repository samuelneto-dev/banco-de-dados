drop database sistemaLocalizacao;
create database sistemaLocalizacao;

use sistemaLocalizacao;

create table pais(
    id_pais int primary key auto_increment,
    nome varchar(20),
    continente varchar(30)
);
create table estado(
    id_estado int primary key auto_increment,
    nome_estado varchar(100),
    sigla varchar(100),
    id_pais int,
    foreign key(id_pais) references pais(id_pais)
);
create table cidade(
    id_cidade int primary key auto_increment,
    nome_cidade varchar(100),
    id_estado int,
    foreign key(id_estado) references estado(id_estado)
);
create table endereco(
    id_endereco int primary key auto_increment,
    rua varchar(20),
    numero varchar(20),
    bairro varchar(30),
    id_cidade int,
    foreign key(id_cidade) references cidade(id_cidade)
);
create table clientes(
    id_cliente int primary key auto_increment,
    nome varchar(100),
    cpf varchar(20),
    data_nasc DATE,
    sexo varchar(20),
    email varchar(30),
    id_cidade int,
    foreign key (id_cidade) references cidade (id_cidade)
);

insert into pais(nome, continente) values("Brasil", "América do Sul");

insert into estado(nome_estado, sigla, id_pais) values("Bahia", "BA", 1);
insert into estado(nome_estado, sigla, id_pais) values("Paraiba", "PB", 1);

insert into cidade(nome_cidade, id_estado) values("Salvador", 1);
insert into cidade(nome_cidade, id_estado) values("Joao Pessoa", 2);

insert into endereco (rua, numero, bairro, id_cidade) values("Rua Piaui", "412", "Centro", 1);

insert into clientes(nome, cpf, data_nasc, sexo, email, id_cidade) 
values("Carlos Silva", "12345678900", "1990-05-15", "Masculino", "carlos@email.com", 1);

insert into clientes(nome, cpf, data_nasc, sexo, email, id_cidade) 
values("Maria Santos", "98765432100", "1995-08-20", "Feminino", "maria@email.com", 2);

-- select * from estado;
-- select * from cidade;
-- select * from endereco;

select 
    e.nome_estado AS estado,
    c.nome_cidade AS cidade,
    en.rua AS rua,
    en.bairro AS bairro,
    en.numero AS numero
from endereco en
inner join cidade c on en.id_cidade = c.id_cidade
inner join estado e on c.id_estado = e.id_estado;
-- 1
 -- SELECT 
--     cl.nome AS cliente,
--     e.nome_estado AS estado
-- FROM clientes cl
-- INNER JOIN cidade c ON cl.id_cidade = c.id_cidade
-- INNER JOIN estado e ON c.id_estado = e.id_estado;
-- -- 2
-- SELECT 
--     c.nome_cidade AS cidade,
--     e.nome_estado AS estado
-- FROM cidade c
-- INNER JOIN estado e ON c.id_estado = e.id_estado;
-- -- 3
-- SELECT 
--     e.nome_estado AS estado,
--     p.nome AS pais
-- FROM estado e
-- INNER JOIN pais p ON e.id_pais = p.id_pais;
-- -- 4
-- SELECT 
--     cl.nome AS cliente,
--     p.nome AS pais
-- FROM clientes cl
-- INNER JOIN cidade c ON cl.id_cidade = c.id_cidade
-- INNER JOIN estado e ON c.id_estado = e.id_estado
-- INNER JOIN pais p ON e.id_pais = p.id_pais;
-- -- 5
-- SELECT 
--     cl.nome AS cliente,
--     c.nome_cidade AS cidade,
--     e.nome_estado AS estado,
--     p.nome AS pais
-- FROM clientes cl
-- INNER JOIN cidade c ON cl.id_cidade = c.id_cidade
-- INNER JOIN estado e ON c.id_estado = e.id_estado
-- INNER JOIN pais p ON e.id_pais = p.id_pais;

