CREATE PROCEDURE sp_create_producto(sp_id_usuario character varying(50), sp_nombre character varying(45), sp_costo double precision, sp_categoria character varying(45), sp_marca character varying(45), sp_precio double precision, sp_existencia_min integer, sp_existencia_max integer)
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO producto(id_usuario, nombre, costo, categoria, marca, precio, existencia_min, existencia_max) 
    VALUES (sp_id_usuario, sp_nombre, sp_costo, sp_categoria, sp_marca, sp_precio, sp_existencia_min, sp_existencia_max);

END;

CALL sp_create_producto('Lenovo', 'Av. 1', '123456789', 'Juan', 1, 'jcorralesss');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_read_producto(sp_id_producto integer)
LANGUAGE SQL
BEGIN ATOMIC

   	SELECT * FROM producto WHERE id_producto = sp_id_producto;

END;

CALL sp_read_producto(1);

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_update_producto(sp_id_usuario character varying(50), sp_nombre character varying(45), sp_costo double precision, sp_categoria character varying(45), sp_marca character varying(45), sp_precio double precision, sp_existencia_min integer, sp_existencia_max integer)
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE producto
	SET nombre = sp_nombre,
		costo = sp_costo,
		categoria = sp_categoria,
		marca = sp_marca,
		precio = sp_precio,
		existencia_min = sp_existencia_min,
		existencia_max = sp_existencia_max
	WHERE id_producto = sp_id_producto;

END;


CALL sp_update_producto();

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_delete_producto(sp_id_producto integer)
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM producto WHERE id_producto = sp_id_producto RETURNING *;

END;


CALL sp_delete_producto(1);