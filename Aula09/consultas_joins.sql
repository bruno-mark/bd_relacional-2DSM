-- Consulta A: Listar o título do evento e o nome do tipo de evento (INNER JOIN)
SELECT 
    e.titulo AS evento,
    te.nome AS tipo_evento
FROM evento e
INNER JOIN tipo_evento te 
    ON e.id_tipo_evento = te.id_tipo_evento;


-- Consulta B: Mostrar título do evento, cidade e estado (INNER JOIN evento -> localizacao)
SELECT 
    e.titulo AS evento,
    l.cidade,
    l.sigla_estado
FROM evento e
INNER JOIN localizacao l 
    ON e.id_localizacao = l.id_localizacao;


-------------------------------------------------------

ALTER TABLE evento
ALTER COLUMN id_localizacao DROP NOT NULL;

INSERT INTO evento (titulo, descricao, data_hora, status, id_tipo_evento, id_localizacao) VALUES
('Fumaça Inexplicável', 'Relato de fumaça em área indefinida.', '2025-09-10 09:30:00', 'Ativo',
 (SELECT id_tipo_evento FROM tipo_evento WHERE nome = 'Queimada'),
 NULL);

INSERT INTO evento (titulo, descricao, data_hora, status, id_tipo_evento, id_localizacao) VALUES
('Possível Deslizamento', 'Sensor indica risco, aguardando confirmação.', '2025-09-11 12:15:00', 'Em Análise',
 (SELECT id_tipo_evento FROM tipo_evento WHERE nome = 'Deslizamento'),
 NULL);


-- Consulta C: Exibir título do evento, tipo, cidade e estado,
-- incluindo eventos sem localização definida (usar LEFT JOIN)
SELECT 
    e.titulo AS evento,
    te.nome AS tipo_evento,
    l.cidade,
    l.sigla_estado
FROM evento e
INNER JOIN tipo_evento te 
    ON e.id_tipo_evento = te.id_tipo_evento
LEFT JOIN localizacao l 
    ON e.id_localizacao = l.id_localizacao;

-- Explicação:
-- INNER JOIN com tipo_evento porque todo evento precisa ter um tipo.
-- LEFT JOIN com localizacao para incluir eventos que ainda não possuem localização.


-- Consulta D: Reescrita da Consulta B usando RIGHT JOIN (ordem invertida)
SELECT 
    e.titulo AS evento,
    l.cidade,
    l.sigla_estado
FROM localizacao l
RIGHT JOIN evento e 
    ON l.id_localizacao = e.id_localizacao;


-- Consulta E: Mostrar quantidade de eventos agrupados por cidade
SELECT 
    l.cidade,
    COUNT(e.id_evento) AS total_eventos
FROM evento e
INNER JOIN localizacao l 
    ON e.id_localizacao = l.id_localizacao
GROUP BY l.cidade
ORDER BY total_eventos DESC;
