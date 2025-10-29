-- 1. Exibir a quantidade de livros publicados por cada autor em cada editora.

SELECT 
    a.nome AS nome_autor,
    e.nome AS nome_editora,
    COUNT(l.id_livro) AS qtd_livros
FROM autor a
INNER JOIN livro l 
    ON a.id_autor = l.id_autor
INNER JOIN editora e 
    ON l.id_editora = e.id_editora
GROUP BY a.nome, e.nome
ORDER BY nome_autor, qtd_livros DESC;


-- 2. Calcular a média de páginas dos livros por autor.

SELECT 
    a.nome AS nome_autor,
    AVG(l.num_paginas) AS media_paginas
FROM autor a
INNER JOIN livro l 
    ON a.id_autor = l.id_autor
GROUP BY a.nome
ORDER BY media_paginas DESC;



-- 3. Listar o total de campanhas realizadas por instituição em cada reservatório.

SELECT 
    r.nome AS nome_reservatorio,
    i.nome AS nome_instituicao,
    COUNT(c.id_campanha) AS qtd_campanhas
FROM campanha c
INNER JOIN reservatorio r 
    ON c.id_reservatorio = r.id_reservatorio
INNER JOIN instituicao i 
    ON c.id_instituicao = i.id_instituicao
GROUP BY r.nome, i.nome
ORDER BY nome_reservatorio, qtd_campanhas DESC;


-- 4. Calcular a média dos valores de parâmetros medidos em cada reservatório.

SELECT 
    r.nome AS nome_reservatorio,
    p.nome AS nome_parametro,
    AVG(s.valor) AS valor_medio
FROM series_temporais s
INNER JOIN reservatorio r 
    ON s.id_reservatorio = r.id_reservatorio
INNER JOIN parametro p 
    ON s.id_parametro = p.id_parametro
GROUP BY r.nome, p.nome
ORDER BY nome_reservatorio, nome_parametro;


-- 5. Identificar instituições que realizaram coletas em mais de um reservatório.

SELECT 
    i.nome AS nome_instituicao,
    COUNT(DISTINCT c.id_reservatorio) AS qtd_reservatorios
FROM instituicao i
INNER JOIN campanha c 
    ON i.id_instituicao = c.id_instituicao
GROUP BY i.nome
HAVING COUNT(DISTINCT c.id_reservatorio) > 1
ORDER BY qtd_reservatorios DESC;
