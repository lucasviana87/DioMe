DELIMITER $$

CREATE PROCEDURE registrar_os_com_status (
    IN p_idVehicle INT,
    IN p_idTeam INT,
    IN p_idStatus INT
)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
        END;

    -- Inicia transação
    START TRANSACTION;

    -- Insere nova OS
    INSERT INTO os (dtEmissao, dtEntrega, idVehicle, idTeam)
    VALUES (CURRENT_DATE(), DATE_ADD(CURRENT_DATE(), INTERVAL 3 DAY), p_idVehicle, p_idTeam);

    -- Cria um ponto de salvamento
    SAVEPOINT depois_insercao_os;

    -- Tenta atualizar o status
    UPDATE statusos
    SET statusDescricao = 'Em andamento'
    WHERE idStatus = p_idStatus;

    -- Se nenhuma linha for afetada (status inválido), faz rollback parcial
    IF ROW_COUNT() = 0 THEN
        ROLLBACK TO SAVEPOINT depois_insercao_os;
    END IF;

    -- Commit final
    COMMIT;
END$$

DELIMITER ;
