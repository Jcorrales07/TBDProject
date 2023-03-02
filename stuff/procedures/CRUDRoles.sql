CREATE PROCEDURE sp_create_rol(sp_nombre character varying(50)) 
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO rol(nombre) 
    VALUES (sp_nombre);

END;

CALL sp_create_rol('Admin');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_read_rol(sp_id_rol integer)
LANGUAGE SQL
BEGIN ATOMIC

   	SELECT * FROM rol WHERE id_rol = sp_id_rol;

END;

CALL sp_read_rol(1);

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_update_rol(sp_id_rol integer, sp_nombre character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE rol
	SET nombre = sp_nombre,
	WHERE id_rol = sp_id_rol;

END;


CALL sp_update_rol(1, 'Administrador');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_delete_rol(sp_id_rol integer)
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM rol WHERE id_rol = sp_id_rol RETURNING *;

END;


CALL sp_delete_rol(1);