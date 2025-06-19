USE universidade;
DELIMITER $$

CREATE PROCEDURE sp_gerenciar_aluno (
    IN acao INT,             -- 1: INSERT, 2: UPDATE, 3: DELETE
    IN p_id INT,
    IN p_nome VARCHAR(100),
    IN p_curso VARCHAR(100)
)
BEGIN
    CASE 
        WHEN acao = 1 THEN
            INSERT INTO aluno (id, nome, curso)
            VALUES (p_id, p_nome, p_curso);

        WHEN acao = 2 THEN
            UPDATE aluno
            SET nome = p_nome, curso = p_curso
            WHERE id = p_id;

        WHEN acao = 3 THEN
            DELETE FROM aluno WHERE id = p_id;

        ELSE
            SELECT 'Ação inválida. Use 1 (INSERT), 2 (UPDATE) ou 3 (DELETE).' AS mensagem;
    END CASE;
END$$

DELIMITER ;
