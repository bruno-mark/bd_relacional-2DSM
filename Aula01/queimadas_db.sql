-- 1. Criar banco de dados queimadas_db
CREATE DATABASE queimadas_db;

-- 2. Criar tabela focos_calor
CREATE TABLE focos_calor (
    id SERIAL PRIMARY KEY,
    estado VARCHAR(50) NOT NULL,
    bioma VARCHAR(50) NOT NULL,
    data_ocorrencia DATE NOT NULL
);

-- 3. Inserir registros na tabela focos_calor
INSERT INTO focos_calor (estado, bioma, data_ocorrencia) 
VALUES 
('Amazonas', 'Amazônia', '2025-02-01'),
('Mato Grosso', 'Cerrado', '2025-02-03'),
('Pará', 'Amazônia', '2025-02-05');

-- 4. Consulta para exibir os dados inseridos
SELECT * FROM focos_calor;
