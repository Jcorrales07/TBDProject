CREATE PROCEDURE sp_create_cliente(sp_nombre character varying(45), sp_apellido character varying(45), id_username character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO cliente(nombre, apellido, id_username) 
    VALUES (sp_nombre, sp_apellido, sp_id_username);

END;

CALL sp_create_cliente('Isaac', 'Flores', 'jcorralesss');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_read_cliente(sp_id_cliente integer)
LANGUAGE SQL
BEGIN ATOMIC

   	SELECT * FROM cliente WHERE id_cliente = sp_id_cliente;

END;

CALL sp_read_cliente(1);

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_update_cliente(sp_nombre character varying(45), sp_apellido character varying(45))
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE cliente
	SET 
        nombre = sp_nombre,
        apellido = sp_apellido
	WHERE id_cliente = sp_id_cliente;

END;


CALL sp_update_cliente('Checo', 'Perez');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_delete_cliente(sp_id_cliente integer)
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM cliente WHERE id_cliente = sp_id_cliente RETURNING *;

END;


CALL sp_delete_cliente(1);