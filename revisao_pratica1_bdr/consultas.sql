--Questão 8:
SELECT 
	id_cliente, 
	nome, 
	cidade
FROM
	clientes;

--Questão 9:
SELECT
	titulo,
	ano_lancamento
FROM
	jogo
WHERE
	ano_lancamento > 2020;

--Questão 10:
SELECT SUM(quantidade) AS quantidade_jogos_comprados FROM compra_jogo;
