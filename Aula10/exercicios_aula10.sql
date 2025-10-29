
-- 1. Exibir o número de livros cadastrados por autor.

SELECT 
    a.nome AS nome_autor,
    COUNT(l.id_livro) AS qtd_livros
FROM autor a
INNER JOIN livro l 
    ON a.id_autor = l.id_autor
GROUP BY a.nome
ORDER BY qtd_livros DESC;


-- 2. Calcular a média de páginas por editora (exemplo hipotético).

SELECT 
    e.nome AS nome_editora,
    AVG(l.paginas) AS media_paginas
FROM livro l
INNER JOIN editora e 
    ON l.id_editora = e.id_editora
GROUP BY e.nome;



-- 3. Mostrar o total de campanhas registradas por reservatório.

SELECT 
    r.nome AS nome_reservatorio,
    COUNT(c.id_campanha) AS num_campanhas
FROM reservatorio r
INNER JOIN campanha c 
    ON r.id_reservatorio = c.id_reservatorio
GROUP BY r.nome
ORDER BY num_campanhas DESC;


-- 4. Calcular a média dos valores registrados para cada parâmetro.

SELECT 
    p.nome AS nome_parametro,
    AVG(st.valor) AS media_valor
FROM series_temporais st
INNER JOIN parametro p 
    ON st.id_parametro = p.id_parametro
GROUP BY p.nome;


-- 5. Listar as instituições que participaram de mais de 3 campanhas.

SELECT 
    i.nome AS nome_instituicao,
    COUNT(c.id_campanha) AS total_campanhas
FROM instituicao i
INNER JOIN campanha c 
    ON i.id_instituicao = c.id_instituicao
GROUP BY i.nome
HAVING COUNT(c.id_campanha) > 3
ORDER BY total_campanhas DESC;
