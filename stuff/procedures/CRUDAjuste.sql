CREATE PROCEDURE sp_ajuste_create(sp_comentario text, sp_usuario_creador character varying(50)) 
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO ajuste(comentario, usuario_creador) 
    VALUES (sp_comentario, sp_usuario_creador);

END;

CALL sp_ajuste_create('ESTE ES UN MULE COMENTARIO', 'jcorralesss');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_ajuste_read(sp_id_ajuste integer)
LANGUAGE SQL
BEGIN ATOMIC

   	SELECT * FROM ajuste WHERE id_ajuste = sp_id_ajuste;

END;

CALL sp_ajuste_read(1);


CREATE PROCEDURE sp_ajuste_read(sp_id_ajuste integer, get_result INOUT refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

	open get_result for
   	SELECT * FROM ajuste WHERE id_ajuste = sp_id_ajuste;

END
$BODY$;

CREATE OR REPLACE FUNCTION sp_ajuste_read(sp_id_ajuste character varying(50))
RETURNS TABLE(id_ajuste integer, comentario text, usuario_modifico varchar, fecha_creacion TIMESTAMP, fecha_modificacion TIMESTAMP, usuario_creador varchar)
LANGUAGE 'plpgsql'

AS $BODY$
BEGIN
RETURN QUERY
	SELECT * FROM ajuste WHERE id_ajuste = sp_id_ajuste;
END;
$BODY$

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_ajuste_update(sp_id_ajuste integer, sp_comentario text, sp_usuario_modifico character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE ajuste
	SET comentario = sp_comentario,
        fecha_modificacion = now(),
        usuario_modifico = sp_usuario_modifico 
	WHERE id_ajuste = sp_id_ajuste;

END;


CALL sp_ajuste_update(1, 'Comentario nuevo', 'jcorralesss');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_ajuste_delete(sp_id_ajuste integer)
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM ajuste WHERE id_ajuste = sp_id_ajuste RETURNING *;

END;


CALL sp_ajuste_delete(1);