CREATE PROCEDURE sp_cliente_create(sp_nombre character varying(45), sp_apellido character varying(45), sp_usuario_creador character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO cliente(nombre, apellido, usuario_creador) 
    VALUES (sp_nombre, sp_apellido, sp_usuario_creador);

END;

CALL sp_create_cliente('Isaac', 'Flores', 'jcorralesss');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_cliente_read(sp_id_cliente integer)
LANGUAGE SQL
BEGIN ATOMIC

   	SELECT * FROM cliente WHERE id_cliente = sp_id_cliente;

END;

CALL sp_read_cliente(1);

CREATE PROCEDURE sp_cliente_read(sp_id_cliente integer, get_result INOUT refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

	open get_result for
   	SELECT * FROM cliente WHERE id_cliente = sp_id_cliente;

END
$BODY$;

CREATE OR REPLACE FUNCTION sp_cliente_read(sp_id_cliente integer)
RETURNS TABLE(id_cliente integer, nombre varchar, apellido varchar, usuario_creador varchar, usuario_modificador varchar, fecha_creacion TIMESTAMP, fecha_modificacion TIMESTAMP)
LANGUAGE 'plpgsql'

AS $BODY$
BEGIN
RETURN QUERY
	SELECT * FROM cliente WHERE id_cliente = sp_id_cliente;
END;
$BODY$

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_cliente_update(sp_id_cliente integer, sp_nombre character varying(45), sp_apellido character varying(45), sp_usuario_modificador character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE cliente
	SET 
        nombre = sp_nombre,
        apellido = sp_apellido,
        usuario_modificador = sp_usuario_modificador,
        fecha_modificacion = now()

	WHERE id_cliente = sp_id_cliente;

END;


CALL sp_update_cliente('Checo', 'Perez');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_cliente_delete(sp_id_cliente integer)
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM cliente WHERE id_cliente = sp_id_cliente RETURNING *;

END;


CALL sp_delete_cliente(1);