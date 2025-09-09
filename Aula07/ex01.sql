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

INSERT INTO categoria_usuario (nome) VALUES
('Cidadão'),
('Bombeiro'),
('Defesa Civil');

INSERT INTO tipo_evento (nome, descricao) VALUES
('Enchente', 'Acúmulo excessivo de água em uma área que normalmente é seca.'),
('Incêndio Florestal', 'Fogo que se espalha por áreas de vegetação ou áreas urbanas de forma descontrolada.');
('Deslizamento de Terra', 'Movimento de solo ou rocha encosta abaixo.'),

INSERT INTO localizacao (latitude, longitude, cidade, estado) VALUES
(-23.5505, -46.6333, 'São Paulo', 'SP'),
(-19.912998, -43.940933, 'Belo Horizonte', 'MG');
(-22.9068, -43.1729, 'Rio de Janeiro', 'RJ'),

INSERT INTO usuario (nome, email, senha_hash, id_categoria) VALUES
('Bruno Mark', 'bruno.mark@email.com', 'hash_senha_123', 1),
('Leonardo Broinizi', 'leonardo.broinizi@email.com', 'hash_senha_456', 2),
('Davi Snaider', 'davi.snaider@email.com', 'hash_senha_789', 3);

INSERT INTO evento (titulo, descricao, data_hora, status, id_tipo_evento, id_localizacao) VALUES
('Alagamento na Zona Leste', 'Fortes chuvas causaram alagamento na região de Itaquera.', '2024-01-15 18:30:00', 'Encerrado', 1, 1),
('Risco de Deslizamento no Morro do Alemão', 'Solo encharcado apresenta risco iminente de deslizamento.', '2024-02-20 10:00:00', 'Ativo', 2, 2),
('Fumaça na Reserva Florestal', 'Focos de incêndio detectados próximos à reserva Adolpho Ducke.', '2024-08-10 14:00:00', 'Confirmado', 3, 3);

SELECT nome, email FROM usuario;

SELECT titulo, dataHora, status FROM evento;

SELECT titulo, descricao, cidade, estado
FROM evento
WHERE status = 'Ativo';

SELECT usuario.nome, usuario.email, categoria_usuario.nome AS categoria
FROM usuario
WHERE categoria_usuario.nome = 'Cidadão';

INSERT INTO relato (texto, data_hora, id_evento, id_usuario) VALUES ('A água subiu muito inesperadamente e danificou carros.', '2024-01-15 19:00:00', 1, 1), ('Deslizamento atingiu parte da rodovia.', '2024-02-20 10:30:00', 3, 2);

INSERT INTO alerta (mensagem, data_hora, nivel, id_evento) VALUES ('Evitem a região do Tietê. Alagamento severo.', '2024-01-15 18:45:00', 'Alto', 1), ('Moradores do Morro do Alemão devem evacuar imediatamente.', '2024-02-20 10:15:00', 'Crítico', 3);

SELECT titulo, data_hora
FROM evento
ORDER BY data_hora;

SELECT titulo, data_hora
FROM evento
ORDER BY data_hora DESC
LIMIT 3;

-- Quantidade total de usuários do banco.
SELECT COUNT(*) AS total_usuarios FROM Usuario;

-- Calcular a SOMA total da área afetada por todos os eventos.
SELECT SUM(area_afetada_km2) AS area_total_afetada_em_km2 FROM Evento;

-- Calcular a MÉDIA da área afetada por evento.
SELECT AVG(area_afetada_km2) AS media_de_area_afetada_em_km2 FROM Evento;