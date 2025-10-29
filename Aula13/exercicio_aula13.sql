-- Parte 1: Criação e carga de dados de exemplo

DROP TABLE IF EXISTS serie_temporal CASCADE;
DROP TABLE IF EXISTS parametro CASCADE;
DROP TABLE IF EXISTS reservatorio CASCADE;

CREATE TABLE reservatorio (
    id_reservatorio SERIAL PRIMARY KEY,
    nome VARCHAR(200) NOT NULL
);

CREATE TABLE parametro (
    id_parametro SERIAL PRIMARY KEY,
    nome_parametro VARCHAR(150) NOT NULL
);

CREATE TABLE serie_temporal (
    id_serie SERIAL PRIMARY KEY,
    id_reservatorio INT NOT NULL REFERENCES reservatorio(id_reservatorio),
    id_parametro INT NOT NULL REFERENCES parametro(id_parametro),
    valor NUMERIC(12,4) NOT NULL,
    data_hora TIMESTAMP NOT NULL
);

-- Inserindo dados de exemplo

INSERT INTO reservatorio (nome) VALUES
('Jaguari'),
('Paraibuna'),
('Cachoeira do França'),
('Santa Branca');

INSERT INTO parametro (nome_parametro) VALUES
('pH'),
('Oxigênio Dissolvido'),
('Temperatura');

INSERT INTO serie_temporal (id_reservatorio, id_parametro, valor, data_hora) VALUES
(
  (SELECT id_reservatorio FROM reservatorio WHERE nome = 'Jaguari'),
  (SELECT id_parametro FROM parametro WHERE nome_parametro = 'Oxigênio Dissolvido'),
  6.80,
  '2025-01-10 09:00:00'
),
(
  (SELECT id_reservatorio FROM reservatorio WHERE nome = 'Jaguari'),
  (SELECT id_parametro FROM parametro WHERE nome_parametro = 'pH'),
  7.20,
  '2025-01-10 09:05:00'
),
(
  (SELECT id_reservatorio FROM reservatorio WHERE nome = 'Paraibuna'),
  (SELECT id_parametro FROM parametro WHERE nome_parametro = 'pH'),
  6.90,
  '2025-02-20 10:00:00'
),
(
  (SELECT id_reservatorio FROM reservatorio WHERE nome = 'Cachoeira do França'),
  (SELECT id_parametro FROM parametro WHERE nome_parametro = 'pH'),
  7.60,
  '2025-03-15 11:00:00'
),
(
  (SELECT id_reservatorio FROM reservatorio WHERE nome = 'Santa Branca'),
  (SELECT id_parametro FROM parametro WHERE nome_parametro = 'Oxigênio Dissolvido'),
  7.00,
  '2025-04-01 08:00:00'
);

-- Parte 2: Consultas com subconsultas no WHERE (IN e EXISTS)

-- Etapa 1: Conferir parâmetros disponíveis
SELECT * FROM parametro;
-- Parâmetro de interesse: 'Oxigênio Dissolvido'

-- Etapa 2: Subconsulta isolada
-- Retorna IDs dos reservatórios com medições de "Oxigênio Dissolvido"
SELECT DISTINCT st.id_reservatorio
FROM serie_temporal st
JOIN parametro p ON st.id_parametro = p.id_parametro
WHERE p.nome_parametro = 'Oxigênio Dissolvido';

-- Etapa 3: Consulta usando IN
SELECT r.nome AS reservatorio
FROM reservatorio r
WHERE r.id_reservatorio IN (
    SELECT DISTINCT st.id_reservatorio
    FROM serie_temporal st
    JOIN parametro p ON st.id_parametro = p.id_parametro
    WHERE p.nome_parametro = 'Oxigênio Dissolvido'
)
ORDER BY r.nome;

-- Etapa 4: Consulta equivalente usando EXISTS
SELECT r.nome AS reservatorio
FROM reservatorio r
WHERE EXISTS (
    SELECT 1
    FROM serie_temporal st
    JOIN parametro p ON st.id_parametro = p.id_parametro
    WHERE st.id_reservatorio = r.id_reservatorio
      AND p.nome_parametro = 'Oxigênio Dissolvido'
)
ORDER BY r.nome;

-- Etapa 5 (opcional): Comparar desempenho entre IN e EXISTS
EXPLAIN ANALYZE
SELECT r.nome AS reservatorio
FROM reservatorio r
WHERE r.id_reservatorio IN (
    SELECT DISTINCT st.id_reservatorio
    FROM serie_temporal st
    JOIN parametro p ON st.id_parametro = p.id_parametro
    WHERE p.nome_parametro = 'Oxigênio Dissolvido'
);

EXPLAIN ANALYZE
SELECT r.nome AS reservatorio
FROM reservatorio r
WHERE EXISTS (
    SELECT 1
    FROM serie_temporal st
    JOIN parametro p ON st.id_parametro = p.id_parametro
    WHERE st.id_reservatorio = r.id_reservatorio
      AND p.nome_parametro = 'Oxigênio Dissolvido'
);

-- Observação: EXISTS pode ser mais eficiente, pois encerra a busca
-- assim que encontra uma correspondência.


-- Parte 3: Subconsultas escalares no SELECT

-- Calcula média, mínimo e máximo do parâmetro "Oxigênio Dissolvido" por reservatório.

SELECT 
    r.nome AS reservatorio,
    (SELECT AVG(st.valor)
     FROM serie_temporal st
     JOIN parametro p ON st.id_parametro = p.id_parametro
     WHERE st.id_reservatorio = r.id_reservatorio
       AND p.nome_parametro = 'Oxigênio Dissolvido') AS media_oxigenio,

    (SELECT MIN(st.valor)
     FROM serie_temporal st
     JOIN parametro p ON st.id_parametro = p.id_parametro
     WHERE st.id_reservatorio = r.id_reservatorio
       AND p.nome_parametro = 'Oxigênio Dissolvido') AS minimo_oxigenio,

    (SELECT MAX(st.valor)
     FROM serie_temporal st
     JOIN parametro p ON st.id_parametro = p.id_parametro
     WHERE st.id_reservatorio = r.id_reservatorio
       AND p.nome_parametro = 'Oxigênio Dissolvido') AS maximo_oxigenio
FROM reservatorio r
ORDER BY r.nome;