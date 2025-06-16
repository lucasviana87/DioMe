-- Seleciona o banco mechanic
USE mechanic;

-- Remove a procedure se já existir
DROP PROCEDURE IF EXISTS criar_os_com_rollback_condicional;

DELIMITER $$

CREATE PROCEDURE criar_os_com_rollback_condicional (
    IN p_idVehicle INT,
    IN p_idTeam INT,
    IN p_idStatus INT
)
BEGIN
    -- Trata qualquer exceção SQL com rollback total
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    -- Início da transação
    START TRANSACTION;

    -- Inserção de nova ordem de serviço
    INSERT INTO os (dtEmissao, dtEntrega, idVehicle, idTeam)
    VALUES (CURRENT_DATE(), DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY), p_idVehicle, p_idTeam);

    -- SAVEPOINT após a inserção
    SAVEPOINT sp_pos_insert_os;

    -- Tenta atualizar o status
    UPDATE statusos
    SET statusDescricao = 'Em andamento'
    WHERE idStatus = p_idStatus;

    -- Se nenhum registro foi atualizado, desfaz a atualização mas mantém a OS
    IF ROW_COUNT() = 0 THEN
        ROLLBACK TO SAVEPOINT sp_pos_insert_os;
    END IF;

    -- Finaliza a transação
    COMMIT;
END$$

DELIMITER ;
