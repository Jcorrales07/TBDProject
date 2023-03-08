CREATE PROCEDURE sp_producto_create(sp_usuario_creador character varying(50), sp_nombre character varying(45), sp_costo double precision, sp_categoria character varying(45), sp_marca character varying(45), sp_precio double precision, sp_existencia_min integer, sp_existencia_max integer)
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO producto(usuario_creador, nombre, costo, categoria, marca, precio, existencia_min, existencia_max) 
    VALUES (sp_usuario_creador, sp_nombre, sp_costo, sp_categoria, sp_marca, sp_precio, sp_existencia_min, sp_existencia_max);

END;

CALL sp_create_producto('Lenovo', 'Av. 1', '123456789', 'Juan', 1, 'jcorralesss');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_producto_read(sp_id_producto integer)
LANGUAGE SQL
BEGIN ATOMIC

   	SELECT * FROM producto WHERE id_producto = sp_id_producto;

END;

CREATE PROCEDURE sp_producto_read(sp_id_producto integer)
LANGUAGE 'plpgsql' AS $BODY$ BEGIN 

open get_result for
SELECT * FROM producto WHERE id_producto = sp_id_producto;

END $BODY$;

CALL sp_read_producto(1);

CREATE OR REPLACE FUNCTION sp_producto_read(sp_id_producto integer)
RETURNS TABLE(id_producto integer, usuario_creador varchar, nombre varchar, costo double precision, categoria varchar, marca varchar, precio double precision, existencia_min integer, existencia_max integer, estado smallint, usuario_modificador varchar, fecha_modificacion TIMESTAMP fecha_creacion TIMESTAMP)
LANGUAGE 'plpgsql'

AS $BODY$
BEGIN
RETURN QUERY
	SELECT * FROM producto WHERE id_producto = sp_id_producto;
END;
$BODY$
-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_producto_update(sp_id_producto integer, sp_usuario_modificador character varying(50), sp_nombre character varying(45), sp_costo double precision, sp_categoria character varying(45), sp_marca character varying(45), sp_precio double precision, sp_existencia_min integer, sp_existencia_max integer)
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE producto
	SET nombre = sp_nombre,
		costo = sp_costo,
		categoria = sp_categoria,
		marca = sp_marca,
		precio = sp_precio,
		existencia_min = sp_existencia_min,
		existencia_max = sp_existencia_max,
		usuario_modificador = sp_id_usuario,
		fecha_modificacion = now()

	WHERE id_producto = sp_id_producto;

END;


CALL sp_update_producto();

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_producto_delete(sp_id_producto integer)
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM producto WHERE id_producto = sp_id_producto RETURNING *;

END;



CALL sp_delete_producto(1);