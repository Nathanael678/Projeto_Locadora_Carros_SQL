USE locadora;

-- 1. Liste todas as locações realizadas, exibindo o nome do cliente, o modelo do veículo e o período da locação.

SELECT 
    c.nome AS cliente,
    v.modelo AS veiculo,
    l.data_inicio,
    l.data_fim
FROM Locacoes l
JOIN Clientes c ON l.id_cliente = c.id_cliente
JOIN Veiculos v ON l.id_veiculo = v.id_veiculo;

-- 2. Liste os veículos que estão atualmente alugados.

SELECT * FROM veiculos
WHERE status = 'Indisponível';

-- 3. Liste todos os veículos que estão disponíveis para locação no momento.

SELECT * FROM veiculos
WHERE status = 'disponível';

-- 4. Apresente o histórico de locações do cliente João Silva.

SELECT 
    c.nome AS cliente,
    v.modelo AS veiculo,
    l.data_inicio,
    l.data_fim
FROM Locacoes l
JOIN Clientes c ON l.id_cliente = c.id_cliente
JOIN Veiculos v ON l.id_veiculo = v.id_veiculo
WHERE c.nome = 'João Silva';

-- 5. Exiba a quantidade de locações realizadas por cada cliente.

SELECT 
    c.nome AS cliente,
    COUNT(l.id_locacao) AS total_locacoes
FROM Clientes c
LEFT JOIN Locacoes l ON c.id_cliente = l.id_cliente
GROUP BY c.nome;

-- 6. Clientes que não realizaram nenhuma locação

SELECT c.nome
FROM Clientes c
LEFT JOIN Locacoes l ON c.id_cliente = l.id_cliente
WHERE l.id_locacao IS NULL;

-- 7. Locações em andamento (data_fim NULL)

SELECT *
FROM Locacoes
WHERE data_fim IS NULL;

-- 8. Quantidade de dias de cada contratação finalizada

SELECT 
    id_locacao,
    DATEDIFF(data_fim, data_inicio) AS dias_locacao
FROM Locacoes
WHERE data_fim IS NOT NULL;

-- 9. Veículo mais alugado

SELECT 
    v.modelo,
    COUNT(l.id_locacao) AS total
FROM Locacoes l
JOIN Veiculos v ON l.id_veiculo = v.id_veiculo
GROUP BY v.modelo
ORDER BY total DESC
LIMIT 1;

-- 10. Relatório completo

SELECT 
    c.nome AS cliente,
    v.modelo,
    v.placa,
    l.data_inicio,
    l.data_fim,
    CASE 
        WHEN l.data_fim IS NULL THEN 'Em andamento'
        ELSE 'Finalizada'
    END AS status_locacao
FROM Locacoes l
JOIN Clientes c ON l.id_cliente = c.id_cliente
JOIN Veiculos v ON l.id_veiculo = v.id_veiculo;
