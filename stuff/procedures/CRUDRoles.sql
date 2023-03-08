CREATE PROCEDURE sp_rol_create(sp_nombre character varying(50), sp_usuario_creador character varying(50)) 
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO rol(nombre, usuario_creador) 
    VALUES (sp_nombre, sp_usuario_creador);

END;

CALL sp_create_rol('Admin');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_rol_read(sp_id_rol integer)
LANGUAGE SQL
BEGIN ATOMIC

   	SELECT * FROM rol WHERE id_rol = sp_id_rol;

END;

CALL sp_read_rol(1);

CREATE PROCEDURE sp_rol_read(sp_id_rol integer, get_result INOUT refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

	open get_result for
   	SELECT * FROM rol WHERE id_rol = sp_id_rol;

END
$BODY$;


CREATE OR REPLACE FUNCTION sp_rol_read(sp_id_rol integer)
RETURNS TABLE(id_rol integer, nombre varchar, usuario_creador varchar, usuario_modificador varchar, fecha_creacion TIMESTAMP, fecha_modificacion TIMESTAMP)
LANGUAGE 'plpgsql'

AS $BODY$
BEGIN
RETURN QUERY
	SELECT * FROM rol WHERE id_rol = sp_id_rol;
END;
$BODY$

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_rol_update(sp_id_rol integer, sp_nombre character varying(50), sp_usuario_modificador character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE rol
	SET nombre = sp_nombre,
        usuario_modificador = sp_usuario_modificador,
        fecha_modificacion = now()
	WHERE id_rol = sp_id_rol;

END;


CALL sp_update_rol(1, 'Administrador');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_rol_delete(sp_id_rol integer)
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM rol WHERE id_rol = sp_id_rol RETURNING *;

END;


CALL sp_delete_rol(1);
