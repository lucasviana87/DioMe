-- Seleciona o banco ecommerce
USE ecommerce;

-- Remove a procedure se já existir
DROP PROCEDURE IF EXISTS registrar_pedido_com_validacao_estoque;

DELIMITER $$

CREATE PROCEDURE registrar_pedido_com_validacao_estoque (
    IN p_idClient INT,
    IN p_idOrderStatus INT,
    IN p_idProduct INT,
    IN p_qtd INT
)
BEGIN
    -- Trata exceção SQL com rollback total
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    -- Início da transação
    START TRANSACTION;

    -- Insere um novo pedido
    INSERT INTO orders (idClient, idOrderStatus, orderDate)
    VALUES (p_idClient, p_idOrderStatus, CURRENT_DATE());

    -- SAVEPOINT após o pedido
    SAVEPOINT sp_pos_pedido;

    -- Tenta atualizar o estoque
    UPDATE productstock
    SET quantity = quantity - p_qtd
    WHERE idProduct = p_idProduct AND quantity >= p_qtd;

    -- Se não atualizou nada, faz rollback parcial
    IF ROW_COUNT() = 0 THEN
        ROLLBACK TO SAVEPOINT sp_pos_pedido;
    END IF;

    -- Finaliza a transação
    COMMIT;
END$$

DELIMITER ;
