CREATE PROCEDURE sp_create_compra(
    sp_id_proveedor integer,
    sp_id_username character varying(50),
    sp_total double precision
) LANGUAGE SQL BEGIN ATOMIC
INSERT INTO
    compra(id_proveedor, id_username, total)
VALUES
    (sp_id_proveedor, sp_id_username, sp_total);

END;

CALL sp_create_compra(1, 'jcorralesss', '150');

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_read_compra(sp_id_compra integer) LANGUAGE SQL BEGIN ATOMIC
SELECT
    *
FROM
    compra
WHERE
    id_compra = sp_id_compra;

END;

CALL sp_read_compra(1);

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_update_compra(sp_id_compra integer, sp_total double precision) LANGUAGE SQL BEGIN ATOMIC
UPDATE
    compra
SET
    total = sp_total
WHERE
    id_compra = sp_id_compra;

END;

CALL sp_update_compra(1, 500);

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_delete_compra(sp_id_compra integer) LANGUAGE SQL BEGIN ATOMIC
DELETE FROM
    compra
WHERE
    id_compra = sp_id_compra RETURNING *;

END;

CALL sp_delete_compra(1);