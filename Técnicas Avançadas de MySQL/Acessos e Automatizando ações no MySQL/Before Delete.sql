USE company

-- Criar tabela para histórico de empregados removidos
CREATE TABLE IF NOT EXISTS employees_history (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    deleted_at DATETIME,
    PRIMARY KEY (employee_id)
);

DELIMITER //
CREATE TRIGGER trg_before_delete_employees
BEFORE DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employees_history (employee_id, first_name, last_name, department_id, deleted_at)
    VALUES (OLD.employee_id, OLD.first_name, OLD.last_name, OLD.department_id, NOW());
END;
//
DELIMITER ;
