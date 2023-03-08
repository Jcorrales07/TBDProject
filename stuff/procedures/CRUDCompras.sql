CREATE PROCEDURE sp_compra_create(
    sp_id_proveedor integer,
    sp_usuario_creador character varying(50),
    sp_total double precision
) LANGUAGE SQL BEGIN ATOMIC
INSERT INTO
    compra(id_proveedor, usuario_creador, total)
VALUES
    (sp_id_proveedor, sp_usuario_creador, sp_total);

END;

CALL sp_create_compra(1, 'jcorralesss', '150');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_compra_read(sp_id_compra integer) LANGUAGE SQL BEGIN ATOMIC
SELECT
    *
FROM
    compra
WHERE
    id_compra = sp_id_compra;

END;

CALL sp_read_compra(1);

CREATE PROCEDURE sp_compra_read(sp_id_compra integer, get_result IN OUT refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

	open get_result for
   	SELECT * FROM cliente WHERE id_cliente = sp_id_compra;

END
$BODY$;

CREATE OR REPLACE FUNCTION sp_compra_read(sp_id_compra integer)
RETURNS TABLE(id_compra integer, id_proveedor integer, total double precision, usuario_creador varchar, usuario_modificador varchar, fecha_creacion TIMESTAMP, fecha_modificacion TIMESTAMP)
LANGUAGE 'plpgsql'

AS $BODY$
BEGIN
RETURN QUERY
	SELECT * FROM cliente WHERE id_cliente = sp_id_compra;
END;
$BODY$

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_compra_update(sp_id_compra integer, sp_total double precision, sp_usuario_modificador character varying(50)) LANGUAGE SQL BEGIN ATOMIC
UPDATE
    compra
SET
    total = sp_total,
    usuario_modificador = sp_usuario_modificador,
    fecha_modificacion = now()
WHERE
    id_compra = sp_id_compra;

END;

CALL sp_update_compra(1, 500);

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_compra_delete(sp_id_compra integer) LANGUAGE SQL BEGIN ATOMIC
DELETE FROM
    compra
WHERE
    id_compra = sp_id_compra RETURNING *;

END;

CALL sp_delete_compra(1);