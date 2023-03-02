CREATE PROCEDURE sp_create_usuario(sp_username character varying(50), sp_nombre character varying(45), sp_apellido character varying(45), sp_email character varying(50), sp_clave character varying(45))
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO usuario 
    VALUES (sp_username, sp_nombre, sp_apellido, sp_email, sp_clave);

END;


CREATE PROCEDURE sp_read_usuario(sp_username character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

   	SELECT * FROM usuario WHERE username = sp_username;

END;

CREATE PROCEDURE sp_update_usuario(sp_username character varying(50), sp_nombre character varying(45), sp_apellido character varying(45), sp_email character varying(50), sp_clave character varying(45))
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE usuario
	SET nombre = sp_nombre,
		apellido = sp_apellido,
		email = sp_email,
		clave = sp_clave
	WHERE username = sp_username;

END;

CREATE PROCEDURE sp_delete_usuario(sp_username character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM usuario WHERE username = sp_username RETURNING *;

END;

CALL sp_create_usuario('icorrales', 'Ian', 'Corrales', 'icorrales@gmail.com', '123123');
CALL sp_read_usuario('icorrales');
CALL sp_update_usuario('icorrales', 'Ian', 'Corrales', 'icorrales@gmail.com', 'contrasena');
CALL sp_delete_usuario('icorrales');