--Questão 1:

CREATE DATABASE rede_games;

--Questão 2:

CREATE TABLE loja (
	id_loja SERIAL PRIMARY KEY,
	nome VARCHAR(60),
	cidade VARCHAR(30)
);

CREATE TABLE jogo (
	id_jogo SERIAL PRIMARY KEY,
	titulo VARCHAR(30),
	ano_lancamento INT,
	genero VARCHAR(20)
);

CREATE TABLE cliente (
	id_cliente SERIAL PRIMARY KEY,
	nome VARCHAR(50),
	email VARCHAR(50) UNIQUE,
	cidade VARCHAR(30)
);

CREATE TABLE compra (
	id_compra SERIAL PRIMARY KEY,
	data_compra DATE,
	id_cliente INT REFERENCES cliente (id_cliente),
	id_loja INT REFERENCES loja(id_loja)
);

CREATE TABLE compra_jogo (
	id_compra INT REFERENCES compra(id_compra),
	id_jogo INT REFERENCES jogo (id_jogo),
	quantidade INT,
	PRIMARY KEY (id_compra, id_jogo)
);
	