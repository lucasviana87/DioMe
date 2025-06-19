DELIMITER $$

CREATE PROCEDURE registrar_pedido_com_estoque (
    IN p_idClient INT,
    IN p_idOrderStatus INT,
    IN p_idProduct INT,
    IN p_quantidade INT
)
BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
        END;

    -- Inicia a transação
    START TRANSACTION;

    -- Insere novo pedido
    INSERT INTO orders (idClient, idOrderStatus, orderDate)
    VALUES (p_idClient, p_idOrderStatus, CURRENT_DATE());

    -- Cria ponto de salvamento
    SAVEPOINT depois_pedido;

    -- Tenta atualizar estoque
    UPDATE productstock
    SET quantity = quantity - p_quantidade
    WHERE idProduct = p_idProduct AND quantity >= p_quantidade;

    -- Se nenhuma linha foi afetada, produto não existe ou sem estoque suficiente
    IF ROW_COUNT() = 0 THEN
        ROLLBACK TO SAVEPOINT depois_pedido;
    END IF;

    -- Commit final
    COMMIT;
END$$

DELIMITER ;
