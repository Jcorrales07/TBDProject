CREATE PROCEDURE sp_create_privilegio(sp_nombre character varying(50)) 
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO privilegio(nombre) 
    VALUES (sp_nombre);

END;

CALL sp_create_privilegio('Ediar');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_read_privilegio(sp_id_privilegio integer)
LANGUAGE SQL
BEGIN ATOMIC

   	SELECT * FROM privilegio WHERE id_privilegio = sp_id_privilegio;

END;

CALL sp_read_privilegio(1);

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_update_privilegio(sp_id_privilegio integer, sp_nombre character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE privilegio
	SET nombre = sp_nombre,
	WHERE id_privilegio = sp_id_privilegio;

END;


CALL sp_update_privilegio(1, 'Editar');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_delete_privilegio(sp_id_privilegio integer)
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM privilegio WHERE id_privilegio = sp_id_privilegio RETURNING *;

END;


CALL sp_delete_privilegio(1);