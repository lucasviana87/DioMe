USE ecommerce;
DELIMITER $$

CREATE PROCEDURE sp_gerenciar_produto (
    IN acao INT,             -- 1: INSERT, 2: UPDATE, 3: DELETE
    IN p_id INT,
    IN p_nome VARCHAR(100),
    IN p_preco DECIMAL(10,2)
)
BEGIN
    IF acao = 1 THEN
        INSERT INTO produto (id, nome, preco)
        VALUES (p_id, p_nome, p_preco);

    ELSEIF acao = 2 THEN
        UPDATE produto
        SET nome = p_nome, preco = p_preco
        WHERE id = p_id;

    ELSEIF acao = 3 THEN
        DELETE FROM produto WHERE id = p_id;

    ELSE
        SELECT 'Ação inválida. Use 1 (INSERT), 2 (UPDATE) ou 3 (DELETE).' AS mensagem;
    END IF;
END$$

DELIMITER ;
