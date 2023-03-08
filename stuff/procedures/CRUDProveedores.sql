CREATE PROCEDURE sp_proveedor_create(sp_nombre character varying(45), sp_direccion character varying(45), sp_telefono character varying(45), sp_nombre_contacto_principal character varying(45), sp_usuario_creador character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO proveedor(nombre, direccion, telefono, nombre_contacto_principal, id_username) 
    VALUES (sp_nombre, sp_direccion, sp_telefono, sp_nombre_contacto_principal, sp_usuario_creador);

END;

CALL sp_create_proveedor('MSI', 'Av. 1', '12314523123', 'Juan', 'jcorralesss');


-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_proveedor_read(sp_id_proveedor integer)
LANGUAGE SQL
BEGIN ATOMIC

   	SELECT * FROM proveedor WHERE id_proveedor = sp_id_proveedor;

END;

CALL sp_read_proveedor(1);

CREATE PROCEDURE sp_proveedor_read(sp_id_proveedor integer, get_result INOUT refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

	open get_result for
   	SELECT * FROM proveedor WHERE id_proveedor = sp_id_proveedor;

END
$BODY$;

CREATE OR REPLACE FUNCTION sp_proveedor_read(sp_id_producto integer)
RETURNS TABLE(id_proveedor integer, nombre varchar, direccion varchar, telefono varchar, nombre_contacto_principal varchar, estado smallint, usuario_creador varchar, usuario_modificador varchar, fecha_creacion TIMESTAMP, fecha_modificacion TIMESTAMP)
LANGUAGE 'plpgsql'

AS $BODY$
BEGIN
RETURN QUERY
	SELECT * FROM proveedor WHERE id_proveedor = sp_id_proveedor;
END;
$BODY$
-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_proveedor_update(sp_id_proveedor integer, sp_nombre character varying(45), sp_direccion character varying(45), sp_telefono character varying(45), sp_nombre_contacto_principal character varying(45), sp_estado integer, sp_usuario_modificador character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE proveedor
	SET nombre = sp_nombre,
		direccion = sp_direccion,
		telefono = sp_telefono,
		nombre_contacto_principal = sp_nombre_contacto_principal,
		estado = sp_estado,
		usuario_modificador = sp_usuario_modificador,
		fecha_modificacion = now()
	WHERE id_proveedor = sp_id_proveedor;

END;

CALL sp_update_proveedor(3, 'Lenovo', 'Av. 1', '123456789', 'Steve Jobs', 0, 'jcorralesss');


-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_proveedor_delete(sp_id_proveedor integer)
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM proveedor WHERE id_proveedor = sp_id_proveedor RETURNING *;

END;

CALL sp_delete_proveedor(3);