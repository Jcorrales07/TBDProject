CREATE PROCEDURE sp_create_factura(
	id_username character varying(50),
	sp_subtotal double precision,
	sp_porcentaje_descuento integer
) 
LANGUAGE SQL BEGIN ATOMIC 

DECLARE sp_impuesto double precision := sp_subtotal * 0.15;

DECLARE sp_descuento double precision := sp_subtotal * (sp_porcentaje_descuento/100);

DECLARE sp_total double precision := sp_subtotal + sp_impuesto - sp_descuento;

INSERT INTO
	factura(
		id_username,
		subtotal,
		sp_impuesto,
		descuento,
		total
	)

VALUES
	(
		sp_id_username,
		sp_subtotal,
		sp_impuesto,
		sp_descuento,
		sp_total
	);

END;

CALL sp_create_factura('jcorralesss', 150, 10);

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_read_factura(sp_id_factura integer) 
LANGUAGE SQL BEGIN ATOMIC

SELECT
	*
FROM
	factura
WHERE
	id_factura = sp_id_factura;

END;

CALL sp_read_factura(1);

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_update_factura(
	sp_id_factura integer,
	sp_subtotal double precision,
	sp_porcentaje_descuento integer
) 
LANGUAGE SQL BEGIN ATOMIC


DECLARE sp_impuesto double precision := sp_subtotal * 0.15;

DECLARE sp_descuento double precision := sp_subtotal * (sp_porcentaje_descuento/100);

DECLARE sp_total double precision := sp_subtotal + sp_impuesto - sp_descuento;

UPDATE
	factura
SET
    fecha = now(),
	subtotal = sp_subtotal,
	sp_impuesto = sp_impuesto,
	descuento = sp_descuento,
	total = sp_total
WHERE
	id_factura = sp_id_factura;

END;

CALL sp_update_factura(1, 1500, 12);

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
CREATE PROCEDURE sp_delete_factura(sp_id_factura integer) LANGUAGE SQL BEGIN ATOMIC
DELETE FROM
	factura
WHERE
	id_factura = sp_id_factura RETURNING *;

END;

CALL sp_delete_factura(1);