CREATE DATABASE clima_alerta;

CREATE TABLE tipo_evento (
    id_tipo_evento SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    descricao VARCHAR(255)
);

CREATE TABLE localizacao (
    id_localizacao SERIAL PRIMARY KEY,
    latitude FLOAT,
    longitude FLOAT,
    cidade VARCHAR(100),
    estado VARCHAR(2)
);

CREATE TABLE categoria_usuario (
    id_categoria SERIAL PRIMARY KEY,
    nome VARCHAR(50) 
);

CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(150),
    email VARCHAR(150) UNIQUE,
    senha_hash VARCHAR(255),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categoria_usuario(id_categoria)
);

CREATE TABLE evento (
    id_evento SERIAL PRIMARY KEY,
    titulo VARCHAR(255),
    descricao TEXT,
    data_hora TIMESTAMP,
    status VARCHAR(50), 
    id_tipo_evento INT,
    id_localizacao INT,
    FOREIGN KEY (id_tipo_evento) REFERENCES tipo_evento(id_tipo_evento),
    FOREIGN KEY (id_localizacao) REFERENCES localizacao(id_localizacao)
);

CREATE TABLE relato (
    id_relato SERIAL PRIMARY KEY,
    texto TEXT,
    data_hora TIMESTAMP,
    id_evento INT,
    id_usuario INT,
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE alerta (
    id_alerta SERIAL PRIMARY KEY,
    mensagem TEXT,
    data_hora TIMESTAMP,
    nivel VARCHAR(50),
    id_evento INT,
    FOREIGN KEY (id_evento) REFERENCES evento(id_evento)
);
