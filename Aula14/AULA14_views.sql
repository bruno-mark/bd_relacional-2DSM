-- 0. CRIAÇÃO DO BANCO DE DADOS DE TESTE (limnologia_db)
-- (Conforme solicitado para o exercício)

-- Limpa tabelas anteriores para garantir um ambiente limpo
DROP VIEW IF EXISTS vw_media_temperatura_reservatorio;
DROP VIEW IF EXISTS vw_eventos_reservatorio;
DROP VIEW IF EXISTS vw_reservatorios_alta_turbidez;

DROP TABLE IF EXISTS serie_temporal;
DROP TABLE IF EXISTS reservatorio;
DROP TABLE IF EXISTS parametro;

-- Criação das tabelas base
CREATE TABLE reservatorio (
    id_reservatorio SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE parametro (
    id_parametro SERIAL PRIMARY KEY,
    nome_parametro VARCHAR(100) NOT NULL
);

CREATE TABLE serie_temporal (
    id_serie SERIAL PRIMARY KEY,
    id_reservatorio INT REFERENCES reservatorio(id_reservatorio),
    id_parametro INT REFERENCES parametro(id_parametro),
    valor FLOAT NOT NULL,
    data_hora TIMESTAMP NOT NULL
);

-- Inserção de dados de teste
INSERT INTO reservatorio (nome) VALUES ('Jaguari'), ('Cachoeira'), ('Represa Nova');
INSERT INTO parametro (nome_parametro) VALUES ('Temperatura'), ('Turbidez'), ('pH');

-- IDs: Jaguari (1), Cachoeira (2), Represa Nova (3)
-- IDs: Temperatura (1), Turbidez (2), pH (3)
INSERT INTO serie_temporal (id_reservatorio, id_parametro, valor, data_hora) VALUES
-- Jaguari (Média Turbidez > 5)
(1, 1, 25.5, '2025-11-01 10:00:00'), -- Temp
(1, 2, 6.0, '2025-11-01 10:00:00'),  -- Turbidez
(1, 2, 7.0, '2025-11-02 10:00:00'),  -- Turbidez (Média 6.5)
(1, 3, 7.2, '2025-11-01 10:00:00'),  -- pH
-- Cachoeira (Média Turbidez < 5)
(2, 1, 24.0, '2025-11-01 11:00:00'), -- Temp
(2, 2, 4.0, '2025-11-01 11:00:00'),  -- Turbidez
(2, 2, 5.0, '2025-11-02 11:00:00'),  -- Turbidez (Média 4.5)
-- Represa Nova (Só Temp)
(3, 1, 26.0, '2025-11-01 12:00:00'); -- Temp

---
-- RESOLUÇÃO DO EXERCÍCIO INDIVIDUAL (AULA15_VIEWS.sql)
---

-- 1. Criar uma view vw_media_temperatura_reservatorio
CREATE VIEW vw_media_temperatura_reservatorio AS
SELECT
    r.nome AS reservatorio,
    AVG(s.valor) AS media_temperatura
FROM reservatorio r
JOIN serie_temporal s ON r.id_reservatorio = s.id_reservatorio
JOIN parametro p ON p.id_parametro = s.id_parametro
WHERE p.nome_parametro = 'Temperatura'
GROUP BY r.nome;

-- 2. Criar uma view vw_eventos_reservatorio
CREATE VIEW vw_eventos_reservatorio AS
SELECT
    r.nome AS nome_reservatorio,
    p.nome_parametro AS nome_parametro,
    s.valor,
    s.data_hora
FROM serie_temporal s
JOIN reservatorio r ON s.id_reservatorio = r.id_reservatorio
JOIN parametro p ON s.id_parametro = s.id_parametro;

-- 3. Criar uma view que mostre apenas reservatórios com média de turbidez acima de 5
CREATE VIEW vw_reservatorios_alta_turbidez AS
SELECT
    r.nome AS reservatorio,
    AVG(s.valor) AS media_turbidez
FROM reservatorio r
JOIN serie_temporal s ON r.id_reservatorio = s.id_reservatorio
JOIN parametro p ON p.id_parametro = s.id_parametro
WHERE p.nome_parametro = 'Turbidez'
GROUP BY r.nome
HAVING AVG(s.valor) > 5;

-- 4. Consultar as views criadas
SELECT * FROM vw_media_temperatura_reservatorio;
SELECT * FROM vw_eventos_reservatorio;
SELECT * FROM vw_reservatorios_alta_turbidez;

-- 5. Remover uma view (DROP VIEW nome)
DROP VIEW vw_eventos_reservatorio;