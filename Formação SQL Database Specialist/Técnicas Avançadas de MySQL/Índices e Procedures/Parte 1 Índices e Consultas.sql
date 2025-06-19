-- Selecionar o banco de dados
USE company;

-- ========================================================
-- CONSULTA 1: Qual o departamento com maior número de pessoas?
-- ========================================================
-- Criação de índice baseado em uso frequente da foreign key 'department_id'
-- Índice tipo BTREE (padrão), ideal para busca, ordenação e agregação
CREATE INDEX idx_employee_department_id ON employee(department_id);

-- Consulta:
SELECT 
    d.name AS departamento,
    COUNT(e.id) AS total_funcionarios
FROM 
    department d
JOIN 
    employee e ON e.department_id = d.id
GROUP BY 
    d.name
ORDER BY 
    total_funcionarios DESC
LIMIT 1;

-- ========================================================
-- CONSULTA 2: Quais são os departamentos por cidade?
-- ========================================================
-- Índice composto para otimizar filtros por cidade e junções com departamentos
CREATE INDEX idx_department_city_id ON department(city_id);
CREATE INDEX idx_city_id ON city(id); -- suporte à junção

-- Consulta:
SELECT 
    c.name AS cidade,
    d.name AS departamento
FROM 
    department d
JOIN 
    city c ON d.city_id = c.id
ORDER BY 
    c.name, d.name;

-- ========================================================
-- CONSULTA 3: Relação de empregados por departamento
-- ========================================================
-- Índice já criado anteriormente em 'employee(department_id)'

-- Consulta:
SELECT 
    d.name AS departamento,
    e.name AS empregado
FROM 
    employee e
JOIN 
    department d ON e.department_id = d.id
ORDER BY 
    d.name, e.name;
