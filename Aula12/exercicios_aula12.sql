-- Exibir, para cada reservatório, os valores médio, mínimo e máximo de pH utilizando subconsultas correlacionadas no SELECT.

SELECT
    r.nome AS nome_reservatorio,

    -- Subconsulta A: obtém a média de pH do reservatório atual
    (SELECT AVG(st.valor)
     FROM series_temporais st
     INNER JOIN parametro pr ON st.id_parametro = pr.id_parametro
     WHERE st.id_reservatorio = r.id_reservatorio
       AND pr.nome = 'pH'
    ) AS ph_medio,

    -- Subconsulta B: obtém o menor valor de pH registrado
    (SELECT MIN(st.valor)
     FROM series_temporais st
     INNER JOIN parametro pr ON st.id_parametro = pr.id_parametro
     WHERE st.id_reservatorio = r.id_reservatorio
       AND pr.nome = 'pH'
    ) AS ph_minimo,

    -- Subconsulta C: obtém o maior valor de pH registrado
    (SELECT MAX(st.valor)
     FROM series_temporais st
     INNER JOIN parametro pr ON st.id_parametro = pr.id_parametro
     WHERE st.id_reservatorio = r.id_reservatorio
       AND pr.nome = 'pH'
    ) AS ph_maximo

FROM reservatorio r
ORDER BY nome_reservatorio;
