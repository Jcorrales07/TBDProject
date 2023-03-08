CREATE PROCEDURE sp_usuario_create(sp_username character varying(50), sp_nombre character varying(45), sp_apellido character varying(45), sp_email character varying(50), sp_clave character varying(45), sp_usuario_creador character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    INSERT INTO usuario(username, nombre, apellido, email, clave, usuario_creador)
    VALUES (sp_username, sp_nombre, sp_apellido, sp_email, sp_clave, sp_usuario_creador);

END;


CREATE PROCEDURE sp_usuario_read(sp_username character varying(50))
LANGUAGE plpgsql
AS $$
BEGIN

   	SELECT * FROM usuario WHERE username = sp_username;

END;$$;

-- Esta si retorna la tabla
CREATE PROCEDURE sp_usuario_read(sp_username character varying(50), get_result INOUT refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

	open get_result for
   	SELECT * FROM usuario WHERE username = sp_username;

END
$BODY$;

CREATE OR REPLACE FUNCTION sp_usuario_read(sp_username character varying(50))
RETURNS TABLE(username character varying, nombre character varying, apellido character varying, email character varying, clave character varying, usuario_modificador character varying, fecha_creacion TIMESTAMP, fecha_modificacion TIMESTAMP, usuario_creador character varying)
LANGUAGE 'plpgsql'

AS $BODY$
BEGIN
RETURN QUERY
	SELECT * FROM usuario WHERE usuario.username = sp_username;
END;
$BODY$

-- Retorna pero bien raro
CREATE OR REPLACE FUNCTION sp_usuario_read(sp_username character varying(50))
RETURNS TABLE (r_username character varying(50), r_email character varying(45), r_clave character varying(45))
AS $$
BEGIN
   RETURN QUERY SELECT username, email, clave  FROM usuario WHERE username = sp_username;
END;
$$ LANGUAGE plpgsql;


CREATE PROCEDURE sp_usuario_update(sp_username character varying(50), sp_nombre character varying(45), sp_apellido character varying(45), sp_email character varying(50), sp_clave character varying(45), sp_usuario_modificador character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    UPDATE usuario
	SET nombre = sp_nombre,
		apellido = sp_apellido,
		email = sp_email,
		clave = sp_clave,
		fecha_modificacion = now(),
		usuario_modificador = sp_usuario_modificador

	WHERE username = sp_username;

END;

CREATE PROCEDURE sp_usuario_delete(sp_username character varying(50))
LANGUAGE SQL
BEGIN ATOMIC

    DELETE FROM usuario WHERE username = sp_username RETURNING *;

END;

CALL sp_create_usuario('icorrales', 'Ian', 'Corrales', 'icorrales@gmail.com', '123123');
CALL sp_read_usuario('icorrales');
CALL sp_update_usuario('icorrales', 'Ian', 'Corrales', 'icorrales@gmail.com', 'contrasena');
CALL sp_delete_usuario('icorrales');