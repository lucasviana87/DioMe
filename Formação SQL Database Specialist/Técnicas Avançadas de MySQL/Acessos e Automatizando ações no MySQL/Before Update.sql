USE company

-- Criar tabela para histórico de salários
CREATE TABLE IF NOT EXISTS salary_history (
    employee_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_at DATETIME
);

DELIMITER //
CREATE TRIGGER trg_before_update_salary
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    -- Validar salário > 0
    IF NEW.salary <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salário deve ser maior que zero.';
    END IF;

    -- Se salário mudou, registrar no histórico
    IF NEW.salary <> OLD.salary THEN
        INSERT INTO salary_history (employee_id, old_salary, new_salary, changed_at)
        VALUES (OLD.employee_id, OLD.salary, NEW.salary, NOW());
    END IF;
END;
//
DELIMITER ;
