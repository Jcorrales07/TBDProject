CREATE PROCEDURE sp_privilegio_create(sp_nombre character varying(50), sp_usuario_creador character varying(50)) 
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO privilegio(nombre, usuario_creador) 
    VALUES (sp_nombre, sp_usuario_creador);

END;


CREATE PROCEDURE sp_privilegio_read(sp_id_privilegio character varying(50), get_result INOUT refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

	open get_result for
   	SELECT * FROM privilegio WHERE id_privilegio = sp_id_privilegio;
	
END
$BODY$;

CREATE OR REPLACE FUNCTION sp_privilegio_read(sp_id_privilegio character varying(50))
RETURNS TABLE(id_privilegio integer, nombre character varying, usuario_creador character varying, usuario_modificador character varying, fecha_creacion TIMESTAMP, fecha_modificacion TIMESTAMP)
LANGUAGE 'plpgsql'

AS $BODY$
BEGIN
RETURN QUERY
	SELECT * FROM privilegio WHERE id_privilegio = sp_id_privilegio;
END;
$BODY$


CREATE PROCEDURE sp_privilegio_update(sp_id_privilegio integer, sp_nombre character varying(50), sp_usuario_modificador character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE privilegio
	SET nombre = sp_nombre,
        usuario_modificador = sp_usuario_modificador,
        fecha_modificacion = now()
	WHERE id_privilegio = sp_id_privilegio;

END;

CREATE PROCEDURE sp_privilegio_delete(sp_id_privilegio integer)
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM privilegio WHERE id_privilegio = sp_id_privilegio RETURNING *;

END;
