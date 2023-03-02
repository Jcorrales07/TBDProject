CREATE PROCEDURE sp_create_ajuste(sp_comentario text, sp_id_username character varying(50)) 
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO ajuste(comentario, id_username) 
    VALUES (sp_comentario, sp_id_username);

END;

CALL sp_create_ajuste('ESTE ES UN MULE COMENTARIO', 'jcorralesss');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_read_ajuste(sp_id_ajuste integer)
LANGUAGE SQL
BEGIN ATOMIC

   	SELECT * FROM ajuste WHERE id_ajuste = sp_id_ajuste;

END;

CALL sp_read_ajuste(1);

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_update_ajuste(sp_id_ajuste integer, sp_comentario text)
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE ajuste
	SET comentario = sp_comentario
	WHERE id_ajuste = sp_id_ajuste;

END;


CALL sp_update_ajuste(1, 'Comentario nuevo');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_delete_ajuste(sp_id_ajuste integer)
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM ajuste WHERE id_ajuste = sp_id_ajuste RETURNING *;

END;


CALL sp_delete_ajuste(1);