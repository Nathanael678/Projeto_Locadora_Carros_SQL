-- PARTE 1: Criar o BD

-- Cria o BD Locadora
CREATE DATABASE Locadora;

-- Comando para usar o BD Locadora
USE Locadora;

-- Cria a tabela de Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    cpf VARCHAR(14)
);

-- Cria a tabela Veiculos
CREATE TABLE Veiculos (
    id_veiculo INT PRIMARY KEY,
    modelo VARCHAR(100),
    placa VARCHAR(10),
    status VARCHAR(20)
);

-- Cria a tabela da Locadora
CREATE TABLE Locacoes (
    id_locacao INT PRIMARY KEY,
    id_cliente INT,
    id_veiculo INT,
    data_inicio DATE,
    data_fim DATE,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_veiculo) REFERENCES Veiculos(id_veiculo)
);

-- Cria a tabela de pagamentos
CREATE TABLE Pagamentos (
    id_pagamento INT PRIMARY KEY,
    id_locacao INT,
    valor DECIMAL(10,2),
    FOREIGN KEY (id_locacao) REFERENCES Locacoes(id_locacao)
);

-- Adiciona pessoas na tabela Clientes
INSERT INTO Clientes VALUES (1,'João Silva','123.456.789-00');
INSERT INTO Clientes VALUES (2,'Maria Souza','987.654.321-00');
INSERT INTO Clientes VALUES (3,'Carlos Pereira','111.222.333-44');
INSERT INTO Clientes VALUES (4,'Ana Oliveira','555.666.777-88');
INSERT INTO Clientes VALUES (5,'Bruno Santos','999.888.777-66');
INSERT INTO Clientes VALUES (6,'Fernanda Lima','222.333.444-55');
INSERT INTO Clientes VALUES (7,'Ricardo Alves','333.444.555-66');
INSERT INTO Clientes VALUES (8,'Juliana Rocha','444.555.666-77');
INSERT INTO Clientes VALUES (9,'Lucas Martins','777.888.999-00');
INSERT INTO Clientes VALUES (10,'Patricia Gomes','888.999.000-11');
INSERT INTO Clientes VALUES (11,'Eduardo Costa','000.111.222-33');

-- Adiciona carros na tabela Veiculos
INSERT INTO Veiculos VALUES (1,'Gol','ABC-1234','Disponível');
INSERT INTO Veiculos VALUES (2,'Onix','DEF-5678','Disponível');
INSERT INTO Veiculos VALUES (3,'HB20','GHI-9012','Disponível');
INSERT INTO Veiculos VALUES (4,'Corolla','JKL-3456','Disponível');
INSERT INTO Veiculos VALUES (5,'Civic','MNO-7890','Disponível');
INSERT INTO Veiculos VALUES (6,'Argo','PQR-1235','Disponível');
INSERT INTO Veiculos VALUES (7,'Tracker','STU-6789','Disponível');
INSERT INTO Veiculos VALUES (8,'Renegade','VWX-2468','Disponível');
INSERT INTO Veiculos VALUES (9,'Compass','YZA-1357','Disponível');
INSERT INTO Veiculos VALUES (10,'Kwid','BCD-9753','Disponível');
INSERT INTO Veiculos VALUES (11,'T-Cross','EFG-8642','Disponível');

-- ======================================================================
-- PARTE 2: Realizar um CRUD

-- =========================
-- CREATE (Criar registros)
-- =========================

-- Criar uma locação
INSERT INTO Locacoes VALUES (1, 1, 1, '2026-02-01', NULL);

-- Atualizar status do veículo para Indisponível
UPDATE Veiculos
SET status = 'Indisponível'
WHERE id_veiculo = 1;

-- Registrar pagamento
INSERT INTO Pagamentos VALUES (1, 1, 1500.00);


-- =========================
-- READ (Ler registros)
-- =========================

-- Listar todos os clientes
SELECT * FROM Clientes;

-- Listar todos os veículos
SELECT * FROM Veiculos;

-- Listar locações ativas (data_fim nula)
SELECT * FROM Locacoes
WHERE data_fim IS NULL;

-- Listar veículos disponíveis
SELECT * FROM Veiculos
WHERE status = 'Disponível';


-- =========================
-- UPDATE (Atualizar registros)
-- =========================

-- Finalizar uma locação
UPDATE Locacoes
SET data_fim = '2026-02-10'
WHERE id_locacao = 1;

-- Após finalizar, deixar o veículo disponível novamente
UPDATE Veiculos
SET status = 'Disponível'
WHERE id_veiculo = 1;


-- =========================
-- DELETE (Excluir registros)
-- =========================

-- Excluir pagamento
DELETE FROM Pagamentos
WHERE id_pagamento = 1;

-- Excluir locação
DELETE FROM Locacoes
WHERE id_locacao = 1;

-- ======================================================================
-- PARTE 3: Solução do desafio enigmático

/* 
O problema acontece porque o campo status da tabela Veiculos pode ser alterado manualmente, sem depender da tabela Locacoes.

Assim, um veículo pode ficar marcado como “Indisponível” mesmo sem existir uma locação ativa (com data_fim nula ou maior que a data atual).

A falha na lógica está na falta de integração entre o status do veículo e as locações.

A solução correta é fazer com que o veículo fique indisponível somente quando houver uma locação ativa vinculada a ele, garantindo que o status sempre reflita a situação real no banco de dados.
*\