-- Sistema Bancário conforme MER
CREATE TABLE agencia (
    NOME_AGENCIA VARCHAR(50) PRIMARY KEY,
    CIDADE_AGENCIA VARCHAR(100) NOT NULL,
    DEPOSITOS DECIMAL(15,2) DEFAULT 0
);

CREATE TABLE cliente (
    ID_CLIENTE SERIAL PRIMARY KEY,
    NOME_CLIENTE VARCHAR(100) NOT NULL,
    CIDADE_CLIENTE VARCHAR(100) NOT NULL,
    ENDERECO_CLIENTE VARCHAR(200)
);

CREATE TABLE conta (
    NUMERO_CONTA VARCHAR(20) PRIMARY KEY,
    NOME_AGENCIA VARCHAR(50) NOT NULL,
    SALDO DECIMAL(15,2) DEFAULT 0,
    FOREIGN KEY (NOME_AGENCIA) REFERENCES agencia(NOME_AGENCIA)
);

CREATE TABLE emprestimo (
    NUMERO_EMPRESTIMO SERIAL PRIMARY KEY,
    NOME_AGENCIA VARCHAR(50) NOT NULL,
    VALOR DECIMAL(15,2) NOT NULL,
    FOREIGN KEY (NOME_AGENCIA) REFERENCES agencia(NOME_AGENCIA)
);

-- Inserir alguns dados de exemplo no sistema bancário
INSERT INTO agencia (NOME_AGENCIA, CIDADE_AGENCIA, DEPOSITOS) 
VALUES 
('Agência Central', 'São Paulo', 1000000.00),
('Agência Norte', 'Manaus', 500000.00),
('Agência Sul', 'Porto Alegre', 750000.00);

INSERT INTO cliente (NOME_CLIENTE, CIDADE_CLIENTE, ENDERECO_CLIENTE)
VALUES
('João Silva', 'São Paulo', 'Rua A, 123'),
('Maria Santos', 'Manaus', 'Av. B, 456'),
('Pedro Oliveira', 'Porto Alegre', 'Rua C, 789');

INSERT INTO conta (NUMERO_CONTA, NOME_AGENCIA, SALDO)
VALUES
('001-123', 'Agência Central', 2500.00),
('002-456', 'Agência Norte', 1800.50),
('003-789', 'Agência Sul', 3200.75);

INSERT INTO emprestimo (NOME_AGENCIA, VALOR)
VALUES
('Agência Central', 15000.00),
('Agência Norte', 8000.00),
('Agência Sul', 12000.00);

-- Consultas para verificar os dados inseridos
SELECT * FROM agencia;
SELECT * FROM cliente;
SELECT * FROM conta;
SELECT * FROM emprestimo;