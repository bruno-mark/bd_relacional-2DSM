--Questão 3:
INSERT INTO loja (nome, cidade) VALUES
('Steam', 'Jacarei'),
('Epic Games', 'São José dos Campos'),
('Xbox GamePass', 'Santa Branca');

--Questão 4:
INSERT INTO cliente (nome, email, cidade) VALUES
('Bruno Mark', 'bruno.mark@email.com', 'Belford Roxo'),
('Eric Souza', 'eric.souza@email.com', 'São José dos Campos'),
('Leonardo Broinizi', 'leonardo.broinizi@email.com', 'Jacareí');

--Questão 5:
INSERT INTO jogo (titulo, ano_lancamento, genero) VALUES
('The Last Of Us', 2013, 'Ação'),
('BMPES', 2025, 'Esporte'),
('Call of Duty Warzone', 2020, 'Tiroteio');

--Questão 6:
-- Compra 1
INSERT INTO compra (data_compra, id_cliente, id_loja) VALUES
('2025-09-01', 1, 1);

-- Compra 2
INSERT INTO compra (data_compra, id_cliente, id_loja) VALUES
('2025-09-02', 2, 2);

--Questão 7:
-- Compra 1, cliente 1 comprou dois jogos
INSERT INTO compra_jogo (id_compra, id_jogo, quantidade) VALUES
(1, 1, 1), 
(1, 2, 2); 

-- Compra 2, cliente 2 comprou dois jogos
INSERT INTO compra_jogo (id_compra, id_jogo, quantidade) VALUES
(2, 2, 1), 
(2, 3, 3); 