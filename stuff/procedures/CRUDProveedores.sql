CREATE PROCEDURE sp_create_proveedor(sp_nombre character varying(45), sp_direccion character varying(45), sp_telefono character varying(45), sp_nombre_contacto_principal character varying(45), id_username character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO proveedor(nombre, direccion, telefono, nombre_contacto_principal, id_username) 
    VALUES (sp_nombre, sp_direccion, sp_telefono, sp_nombre_contacto_principal, id_username);

END;

CALL sp_create_proveedor('MSI', 'Av. 1', '12314523123', 'Juan', 'jcorralesss');


-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_read_proveedor(sp_id_proveedor integer)
LANGUAGE SQL
BEGIN ATOMIC

   	SELECT * FROM proveedor WHERE id_proveedor = sp_id_proveedor;

END;

CALL sp_read_proveedor(1);


-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_update_proveedor(sp_id_proveedor integer, sp_nombre character varying(45), sp_direccion character varying(45), sp_telefono character varying(45), sp_nombre_contacto_principal character varying(45), sp_estado integer, id_username character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE proveedor
	SET nombre = sp_nombre,
		direccion = sp_direccion,
		telefono = sp_telefono,
		nombre_contacto_principal = sp_nombre_contacto_principal,
		estado = sp_estado,
	WHERE id_proveedor = sp_id_proveedor;

END;

CALL sp_update_proveedor(3, 'Lenovo', 'Av. 1', '123456789', 'Steve Jobs', 0, 'jcorralesss');


-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_delete_proveedor(sp_id_proveedor integer)
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM proveedor WHERE id_proveedor = sp_id_proveedor RETURNING *;

END;

CALL sp_delete_proveedor(3);