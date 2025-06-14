-- Criando usuários
CREATE USER 'gerente_user'@'localhost' IDENTIFIED BY 'senha123';
CREATE USER 'employee_user'@'localhost' IDENTIFIED BY 'senha123';

-- Permissões para gerente_user (acesso total às views)
GRANT SELECT ON company.vw_employees_by_dept_location TO 'gerente_user'@'localhost';
GRANT SELECT ON company.vw_departments_managers TO 'gerente_user'@'localhost';
GRANT SELECT ON company.vw_projects_by_employee_count TO 'gerente_user'@'localhost';
GRANT SELECT ON company.vw_projects_departments_managers TO 'gerente_user'@'localhost';
GRANT SELECT ON company.vw_employees_dependents_managers TO 'gerente_user'@'localhost';

-- Permissões para employee_user (acesso limitado)
GRANT SELECT ON company.vw_employees_dependents_managers TO 'employee_user'@'localhost';

-- Aplicar as mudanças de privilégio
FLUSH PRIVILEGES;
